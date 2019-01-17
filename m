Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F31C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2418E205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQ6Lkye6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PezxzrDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2418E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6U0h5bCQY/vLAvaT1EF90QXdzgbIoLT7vM7YESTCjZ4=; b=sQ6Lkye6PzAUm5
	iMCe2w45LxVbqdd2icGcqlWSSLSoY8ALuxyeDUnRxNhtRG/BwzU5rjeg6pWQ3pU2k4FjpN1B034gj
	QfnnUUCozfo5R0+NWewh3sIYyR98xnfxvHSpE577rx9HQs4WPCvyKtrzXQIPJ4UPlje2KRIZH0lCb
	EnB/i/c2MT4u1AIeIZgsUu4bvLN4SxsIyqSGwYypiXtrOWJ7diwKs+UO9Fjkls13Xe19cyPK1buF8
	VWKxPSViX5ak1ORRscIli0g6XwQFiEgwDbEtLdCNwFC7D1muvhCOcPuqtSSMg6y0zDm081HuJ/qNh
	pO3LYtHeY+/GJ/5BTNrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjxif-0000Qj-M8; Thu, 17 Jan 2019 02:47:49 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjxiY-0000Jo-QE
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 02:47:47 +0000
Received: by mail-qk1-x741.google.com with SMTP id z18so5153340qkj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 18:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rg1vNvR5pbrB66mtDDBifmLfQdSn09IgrAfhdxtpDvE=;
 b=PezxzrDR7iDernYmPx9IwD3FED9nyblCOHyFkvJxWHVwAa1qOVjqaLr+/76p3ugaCZ
 /WguOh2eYTQ1Ujzf6pjnGtlzTJB3VlfyNJcPZgWWQA2mt4lk1iICCPUqfeW/Ubfm8bpq
 pCj1EzorH3dxFc9sz60hzXUyURyTtnGVzL/Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rg1vNvR5pbrB66mtDDBifmLfQdSn09IgrAfhdxtpDvE=;
 b=Ai8BwtDEifTOqv8L5HK2Lob/RbyoIYR94ZRs8uuJl3jStBLFxhNct7UW/1dserOfdt
 qQoldHLahOqk6Zwsz/uCR3VNkEkvXURUjunYCQIHaGkbGZbEjTiT6Y/p15ozCX5kmykZ
 JEQucH9L+zQurugxsWjAbDMY51pbK0vR31i9zGFx3p/0urSybINzPxTGAhs0oEwI3zGJ
 7Tvh/Pmk39oRxI+yKF3YVmOk1Y3l9HKZeD8TuMOWPB9N/saCxK6ww7Up1ewV+1Vcj/4r
 f8aALm9WkmU2glY08T/GKGYx6GLeauPh70B8lcai2QHzQl4/+woaHLdWmqumlnr31kqq
 RQow==
X-Gm-Message-State: AJcUukeQT9x0EjHKuaoRC1BARkv9nfguqZ58rZu6dWGokppkDptKVJLc
 R6QhFZMzz627UlEsxPWqQoAZBzUCAykb7bbxyrA=
X-Google-Smtp-Source: ALg8bN7MVmbeu1Q3GqsgLUzW/P2tCyvjTvWLcDPvaWwZQoPKRx6ZlZhqRPTC6t/zvZQAlc0roWP5/JNrvgDGr5Qhcyg=
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr9168191qkf.127.1547693261504; 
 Wed, 16 Jan 2019 18:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
 <20181217200405.2904551-3-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-3-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:47:30 +1100
Message-ID: <CACPK8XcErvKa6ROTonrxc5nd=keDCEL2QniQAwWaAO0FrTQVGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: aspeed: Add KCS for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_184743_343310_34FC6573 
X-CRM114-Status: UNSURE (   8.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
