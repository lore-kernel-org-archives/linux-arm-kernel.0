Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD66C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:48:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1882080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nBBQXFf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1882080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/RpGzKkr0rjgppA1XXzIbaLmmi37Jk9sTTbFHBiaKnE=; b=nBBQXFf1hZ7GJN
	S7LJQEZMriQzXeZ9scQJb0vaDM6VjmJmwOQbTkQR8rWFUi5CHCQJW/m0Rg0wuMKs1l2mCHs5IVhg/
	1YRlyW+IBcuietYyji5+vWYzBScXszDbisg+0aZSC5hmY5pO5Wvjz+SG52t418QOefwZrrdQ42Sml
	VYVOV8ojaIGLhsb4e+FomDBUzzZK9rhw6MjTANPRK2f+JrVBVLhV4YL9Ni9b7fZyvP5vOt1jtD2Zc
	46yqFKffvyEczN+qJZkii+3cruLyRi07QPVxRJ+durl78meh8gX70OpHL2XWgfRS9ma27EEo/2lqz
	DSY79wmJld8X3XHd3Q9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1griA3-0006Wx-UL; Thu, 07 Feb 2019 11:48:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1griA0-0006WX-Pm
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:48:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492A9A78;
 Thu,  7 Feb 2019 03:48:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3891B3F675;
 Thu,  7 Feb 2019 03:48:02 -0800 (PST)
Date: Thu, 7 Feb 2019 11:47:59 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 3/6] arm64: HWCAP: encapsulate elf_hwcap
Message-ID: <20190207114757.GG3567@e103592.cambridge.arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
 <1549459868-45992-4-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549459868-45992-4-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_034804_839101_3EFA9090 
X-CRM114-Status: GOOD (  15.81  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 01:31:05PM +0000, Andrew Murray wrote:
> The introduction of elf_hwcap2 introduced accessors which ensure that
> features are set/tested in the appropriate elf_hwcapX variable.
> 
> Let's now mandate access to elf_hwcapX via these accessors by making
> elf_hwcapX static within cpufeature.c.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 19 ++++---------------
>  arch/arm64/include/asm/hwcap.h      |  6 +++---
>  arch/arm64/kernel/cpufeature.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 35 insertions(+), 23 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 05ee9b9..ced87ad 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h

[...]

> @@ -97,6 +98,5 @@ enum {
>  #endif
>  };
>  
> -extern unsigned long elf_hwcap, elf_hwcap2;
>  #endif
>  #endif
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d10a455..5b9620d 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -35,11 +35,8 @@
>  #include <asm/traps.h>
>  #include <asm/virt.h>
>  
> -unsigned long elf_hwcap __read_mostly;
> -EXPORT_SYMBOL_GPL(elf_hwcap);
> -

Will this affect out-of-tree modules?

I also note an out-of-arch/ use in
drivers/clocksource/arm_arch_timer.c, which this series doesn't appear
to address (or I missed it).

We are allowed to break EXPORT_SYMBOL_GPL()s in general so long as it's
not done without any meaningful reason, so maybe this is not a huge
concern so long as we catch all the in-tree users.

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
