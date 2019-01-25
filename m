Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA5C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B172C218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rppmdloj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B172C218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lf3x3bhzGZQ1Ndc5KhC6PQsi06gIjmX8oO/tWtek6+Y=; b=Rppmdlojb7iK7e
	E8JAWLBu5XyR1qMdFFyqPkzK2in/woLyvoetIi2GTDL/kWIdmSonPS6CoF+xAnJHGysFZkmonz/OK
	lBpvbMDE1VrBhAwq/UfT5WWrHxh6Uf+6rlQNwZAr2teB8DGTEt9WGSYT8zxx03bJZIBJO1oesBk3S
	cS3vptlWJt42r4+VqpU6qoADO9FxzzKlniwOQ2eT5UJYkyN9jD690/JOdFpS2X5oGrTSZMZ6+jbUV
	DOM83sfRaUMKvuEAfhRk/C8LIPAQtzxAa8qGT17XDfaG73QcP2Vk8z3SxNeP6qsuKnD7l+F4K+9ve
	z28a+qoVS3gcHLT1L1DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2Wt-0000nm-Gt; Fri, 25 Jan 2019 14:32:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2Wq-0000nI-CV
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:32:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28249A78;
 Fri, 25 Jan 2019 06:32:19 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 184303F5C1; Fri, 25 Jan 2019 06:32:17 -0800 (PST)
Date: Fri, 25 Jan 2019 14:32:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Message-ID: <20190125143215.GE25901@arrakis.emea.arm.com>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115191839.13823-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_063220_428119_21128404 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 08:18:39PM +0100, Anders Roxell wrote:
> When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
> this warning will happen when COMPAT isn't set.
> 
> WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
>   Depends on [n]: COMPAT [=n]
>   Selected by [y]:
>   - ARCH_MXC [=y]
> 
> Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
> since ARM64_ERRATUM_845719 depends on COMPAT.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 251ecf34cb02..d4faca775d9c 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -145,7 +145,7 @@ config ARCH_MVEBU
>  config ARCH_MXC
>  	bool "ARMv8 based NXP i.MX SoC family"
>  	select ARM64_ERRATUM_843419
> -	select ARM64_ERRATUM_845719
> +	select ARM64_ERRATUM_845719 if COMPAT
>  	help
>  	  This enables support for the ARMv8 based SoCs in the
>  	  NXP i.MX family.

Actually, do we need to select the errata workarounds explicitly? That
seems to be the only case where we do it (commit 930507c18304, "arm64:
add basic Kconfig symbols for i.MX8"). They are default y, so we
shouldn't need to force them on.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
