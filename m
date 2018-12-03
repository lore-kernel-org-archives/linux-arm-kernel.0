Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608472087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AkxqsoUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608472087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Js6i5MeW6WM5LkUQFXHe6HK5/fppfi0GSaUUudaEIks=; b=AkxqsoUqxgurNA
	+E1qeSEcMY+A+M6op4YbMdjQocpBw4Dx6/WtqG08m6iOZYFDKDX5mlJLpz8CzEUkNYRW2Lx3WaQgD
	/DKtt7QsHLrDFM13odwj8w0iDzzln1LI83Uyqae5/R675W5ta5RWYNyOQxO1NzNvvjZwFmzHTBD9A
	DD5NXqi0+R8tNDhRH0ZhrsBPp2pH2VfT/8KuTpIu1to5pKNUPAUAKkRRY2hjQ5buyj7UiLUHRB4BJ
	52lg6L7eYHl9oK2xvYv+3LBdIz+z45uv5j2Ofiogx7jK4Gppl6tmmSKxOEb9KYoE4D9v9eBxeWVW1
	1ORRaJVKX6sW/UY0p4sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtyd-0002Cn-0K; Mon, 03 Dec 2018 19:33:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtxI-0000eI-QG
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:33:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2EE1688;
 Mon,  3 Dec 2018 11:32:21 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC6A03F575;
 Mon,  3 Dec 2018 11:32:21 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C4C481AE1062; Mon,  3 Dec 2018 19:32:41 +0000 (GMT)
Date: Mon, 3 Dec 2018 19:32:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: huanglingyan <huanglingyan2@huawei.com>
Subject: Re: [PATCH] arm64: lib: accelerate do_csum() with NEON instruction
Message-ID: <20181203193241.GH29028@arm.com>
References: <1542792065-98282-1-git-send-email-huanglingyan2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542792065-98282-1-git-send-email-huanglingyan2@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113234_323794_6C60470C 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, liuyun01@kylinos.cn,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+ Ard and Jackie]

On Wed, Nov 21, 2018 at 05:21:05PM +0800, huanglingyan wrote:
> From: Lingyan Huang <huanglingyan2@huawei.com>
> 
> Function do_csum() in lib/checksum.c is used to compute checksum,
> which is turned out to be slowly and costs a lot of resources.
> Let's use neon instructions to accelerate the checksum computation
> for arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
> ---
>  arch/arm64/include/asm/checksum.h |   8 ++
>  arch/arm64/lib/Makefile           |   3 +
>  arch/arm64/lib/checksum.c         |  30 +++++++
>  arch/arm64/lib/do_csum.S          | 182 ++++++++++++++++++++++++++++++++++++++
>  lib/checksum.c                    |   6 +-
>  5 files changed, 226 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/lib/checksum.c
>  create mode 100644 arch/arm64/lib/do_csum.S

I think we can avoid dropping into assembly for this if we build on top of
arm_neon.h for the core of the loop:

> +do_loop_64:
> +
> +	ldp	q5, q4, [x0], #32
> +	ldp	q7, q6, [x0], #32
> +
> +    uadalp v0.4s, v4.8h
> +    uadalp v1.4s, v5.8h
> +    uadalp v2.4s, v6.8h
> +    uadalp v3.4s, v7.8h

So please look at Jackie's patch for XOR checksumming as inspiration:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615625.html

Thanks,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
