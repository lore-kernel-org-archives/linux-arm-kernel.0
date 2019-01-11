Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:33:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF4A20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GP71w18/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF4A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xRCnjNeduPQBQqcocMCMSuclysBO2vtUnmCGzFgrhGQ=; b=GP71w18/wkngx+
	zj8qAiOqYR7zagp+uFepfqNIBYxH37cdR3bGFXjeWLTbmgbMCdDpIN4tSzcU/TrUYZoshrPKjDlpI
	lguSI6imPFIY3q6vaXNhMp/+sRafuwBBTj6RyJbkP/0vuv4nz8584daUoZ5MpVAiqWnhAbo2lc4hJ
	uerqOnOrZXphjhc2WlMZMno3cWJitzrSnFVekuJq99lPQt71m/eY4giKBgmpZESLu5nmLucBJBJIT
	UgqlRMbyoMIhjfMIi6GLKWRytGb0hoEWSkE8PcLjJDbwVRPWZuoki53p397GEdm1qfSJjjgzktrKV
	0gkYA/f8rR+3KCbBMpfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyoB-0002nh-3E; Fri, 11 Jan 2019 15:33:19 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghynz-0002hL-Mh; Fri, 11 Jan 2019 15:33:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF280EBD;
 Fri, 11 Jan 2019 07:33:06 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F110B3F5AF;
 Fri, 11 Jan 2019 07:33:05 -0800 (PST)
Subject: Re: [PATCH] arm64: kexec_file: return successfully even if kaslr-seed
 doesn't exist
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20190111074021.23639-1-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <3565a2f8-c4f2-1ff3-9b04-1db87b1f72bf@arm.com>
Date: Fri, 11 Jan 2019 15:33:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190111074021.23639-1-takahiro.akashi@linaro.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_073308_056860_69DA1E02 
X-CRM114-Status: UNSURE (   8.60  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Akashi,

On 11/01/2019 07:40, AKASHI Takahiro wrote:
> In kexec_file_load, kaslr-seed property of the current dtb will be deleted
> any way before setting a new value if possible. It doesn't matter whether
> it exists in the current dtb.

Could you describe what goes wrong without this patch?

If the rng isn't ready yet, this stale error causes us to return an error,
causing kexec_file_load() to fail unnecessarily.

> So "ret" should be reset to 0 here.
> 
> Fixes: commit 884143f60c89 ("arm64: kexec_file: add kaslr support")

Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
