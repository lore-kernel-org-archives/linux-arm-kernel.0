Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7806C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD1D2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CeaXQTL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD1D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yO+GXB342HEbpdXB5njdrtyeASTyIohVzj67pQ6QeHc=; b=CeaXQTL7/5phQx
	Lqvn/rh8mTDVQwq4DqqGMVff2ef9+swsr6n0NPOSDXAaFKHKNi/OYkb4L/PjSVVoe9s46p1BwNvFA
	dJmrF6O1AP1YsMBfrsXS3y1Od34JGg8V5Zi/Lj+ugvxHz+Z8AgogGNpoykEjI/WzIAx8sVwxVVfox
	wyB3nvEqe6qHeMHcNLkWO1hFyqws4m+1Lcf4fbOpQjkRJ3o8ICWClOAUOo3IDAxu4yM2zIoL/QvUO
	L2le5t60eIrh40sn7gXT9L6U6zkKw9NRKZ89xMx5fubBe2k4eweP3lPvaj0glOorKu0AgVQ1n8nLN
	0TF5/nX6wo5edHlhDJJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPFH-0000vU-Ly; Thu, 29 Nov 2018 16:32:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPFE-0000tG-Ao
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:32:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB900A78;
 Thu, 29 Nov 2018 08:32:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB79E3F59C;
 Thu, 29 Nov 2018 08:32:39 -0800 (PST)
Date: Thu, 29 Nov 2018 16:32:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 04/24] arm/arm64: gic-v3: Add PMR and RPR accessors
Message-ID: <20181129163237.dyppwn5ipkehv527@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-5-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-5-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_083252_383228_7EEB4273 
X-CRM114-Status: GOOD (  16.27  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:55AM +0000, Julien Thierry wrote:
> Add helper functions to access system registers related to interrupt
> priorities: PMR and RPR.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

The AArch32 ICC_RPR encoding looks right per ARM DDI 0487D.a table G7-3,
and the rest looks sane to me.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/arch_gicv3.h   | 16 ++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 15 +++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
> index 0bd5307..bef0b5d 100644
> --- a/arch/arm/include/asm/arch_gicv3.h
> +++ b/arch/arm/include/asm/arch_gicv3.h
> @@ -34,6 +34,7 @@
>  #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
>  #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
>  #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
> +#define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
>  
>  #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
>  #define ICC_AP0R0			__ICC_AP0Rx(0)
> @@ -245,6 +246,21 @@ static inline void gic_write_bpr1(u32 val)
>  	write_sysreg(val, ICC_BPR1);
>  }
>  
> +static inline u32 gic_read_pmr(void)
> +{
> +	return read_sysreg(ICC_PMR);
> +}
> +
> +static inline void gic_write_pmr(u32 val)
> +{
> +	write_sysreg(val, ICC_PMR);
> +}
> +
> +static inline u32 gic_read_rpr(void)
> +{
> +	return read_sysreg(ICC_RPR);
> +}
> +
>  /*
>   * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
>   * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index e278f94..37193e2 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -114,6 +114,21 @@ static inline void gic_write_bpr1(u32 val)
>  	write_sysreg_s(val, SYS_ICC_BPR1_EL1);
>  }
>  
> +static inline u32 gic_read_pmr(void)
> +{
> +	return read_sysreg_s(SYS_ICC_PMR_EL1);
> +}
> +
> +static inline void gic_write_pmr(u32 val)
> +{
> +	write_sysreg_s(val, SYS_ICC_PMR_EL1);
> +}
> +
> +static inline u32 gic_read_rpr(void)
> +{
> +	return read_sysreg_s(SYS_ICC_RPR_EL1);
> +}
> +
>  #define gic_read_typer(c)		readq_relaxed(c)
>  #define gic_write_irouter(v, c)		writeq_relaxed(v, c)
>  #define gic_read_lpir(c)		readq_relaxed(c)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
