Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D11C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40350222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rLHOcRbD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+RTdKtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40350222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KeXkLCvNMWWuyTPQUdwZTpPOlzGQQXkXSBH9c1cgz+M=; b=rLHOcRbDc+estQ
	nGKJUxiUgM/at8FeF6Z8q2f06RbQRdjSCbQhrA1HkaKZcne9LzJlrwOetBvlwHaeUZQuMcF62twL7
	DqshVVhBNayE0qXC3D776LAZo2klsO+lJQgkVUwCHZA8iA3qiSrQwWZCI58gHq8vSQ+BOvt6ePJAp
	x4xOvT9jopSF8AmmDcmFlHfZ0qC3KKCdrtzjuFXzF7D3MS+uCy2g8eOvEalh0AfV50jjbj4vp1DwH
	AB5B5wRlWx6Jy9dWZ12FFsdIb+QDoJa73LkH5GFGqMvdTd5XFJPa4hbDKTWUSu5Q4IWfuylQWGTJ2
	zBvmTtrTPH2v2ze/WfIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtpnq-0005h9-Bd; Wed, 13 Feb 2019 08:21:58 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtpnn-0005gU-7l
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:21:56 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so1421075wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OP1OccV571tuh3QSGB4f69ZRaeS/Vq+cIRqqhx3Knhw=;
 b=C+RTdKtVwJW4ufQjVmHZ5hACH3WjYlv8ZEJ3kGThVSgx+bQMCls+gLCCKQXGzW+GZH
 ZJF/FPkHLiwlNVx0MFxF/tpoZcHxcYxkJ+IsGEzZ1KSJlDvK37KIq28q4H0wlrTakH97
 /2gnj65LEO8975uU22MmlOlCKR9xgGsVtXIJKA0YxyjL9d8senBOPpvj671y0eZBVlOq
 1hsyE0CbDWhsnexGmiXGaqASJHph3Y+pdYSVEw9K3P9b+wKrsgkYQUW9IwU3UBeNqHFN
 AlCL1Zc2i9CZCG13tpaTv2K2+/jCNrwgk/6C0OBchboI5cOnUxVlAJTRMTANXhAYLEdP
 NGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=OP1OccV571tuh3QSGB4f69ZRaeS/Vq+cIRqqhx3Knhw=;
 b=f4J4xbZUTra9b7a8XwUyK4Bl15NCLo0ZvWrJA3GBGNlKBE8v5KWY7+U96Elb7gt4mP
 fDW7CN61YAMlSQC1Czl8HmWBK0h73k7cgPnJ4P4BvzRVEW4umhDJLIQHu+3W2S6Ixzur
 jwvQy5R9iP4VuTYFy7YAK1zXYIzcmEDq8w5Rsb8RTSK/pZe9xyDGOaLkXrx9faQt8Rh0
 L0MsgNTGJ4SUX9TCvYDtB8FljWdxovHEA/f3SS8Fe9q9SODh0gzab6dq4WHyZW1RESBX
 FPRFyB0XQ1bZTy4UWn3xdGb8dKuqxUvWLWiJP1g6X/8tdAmF9iM4/KXvDYL9dIpMEuIj
 nzpQ==
X-Gm-Message-State: AHQUAubslvuqdM+QIWn83kGFnykW10kRcmE+01JuvPkeahxOZCEw4ftm
 ANJ7v6ZX5m2eiGcAY8SKkj8=
X-Google-Smtp-Source: AHgI3IYXEgkxWzm0pHd6UslqLXP0PacBc7qfraB4ipE7T2v2FPgavLd+ZmYzew/bsu1YYAVUVjXpPg==
X-Received: by 2002:adf:f4c8:: with SMTP id h8mr6458431wrp.6.1550046113810;
 Wed, 13 Feb 2019 00:21:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id x18sm11372256wrw.61.2019.02.13.00.21.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 00:21:53 -0800 (PST)
Date: Wed, 13 Feb 2019 09:21:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213082150.GA57916@gmail.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_002155_311220_E4E517BB 
X-CRM114-Status: UNSURE (   7.82  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


* Julien Thierry <julien.thierry@arm.com> wrote:

> I guess I'll drop the might_resched() part of this patch if that sounds
> alright.

That sounds perfect - that bit was pretty much the only problem I had 
with the series.

Thanks,

	Ingo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
