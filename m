Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3ABC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB8320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="If5xEnWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB8320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vJgAYFbVq5eANMES4h3jmspl+TjaJ2kan/gNghTwAec=; b=If5xEnWs9BlS9F
	U+C2CgCi1DF/4b+g4kCiYwmI4NPNBw+1YkWVRif4zKzl+998N58WSNWUz6MBJZwwCDR2Hta6N6j82
	OXnsrdIRXYFwkTv/7NNi5TXa0T9EeJAO0D0OJ/8YbkCd/DsCtVOcI5VARDytfIkmgHwfDzmkWvBR1
	QO06DBw8R/FIbdpHUMQdU18xI9lfyZFb1SASM1eoVPzbVuTWZ4Y6ELvIk7UM2YBOltcVjX87Nai0Y
	9S3HvDwX7SrVxAbyeNReo05bNLHRcVfqPPexrMopnGHsefcp/ed3LxqHn32ytV0Eoj8p2CKV+X+GZ
	S4cOOub+GVNvgRdzvmNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPAM-0006Wp-TT; Thu, 29 Nov 2018 16:27:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPA9-0006Gp-MH
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:27:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215C1A78;
 Thu, 29 Nov 2018 08:27:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305293F59C;
 Thu, 29 Nov 2018 08:27:25 -0800 (PST)
Date: Thu, 29 Nov 2018 16:27:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 02/24] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
Message-ID: <20181129162722.s2ee2mdteli7jdir@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_082737_879680_6AB26C4C 
X-CRM114-Status: GOOD (  20.61  )
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
Cc: daniel.thompson@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:53AM +0000, Julien Thierry wrote:
> It is not supported to have some CPUs using GICv3 sysreg CPU interface
> while some others do not.
> 
> Once ICC_SRE_EL1.SRE is set on a CPU, the bit cannot be cleared. Since
> matching this feature require setting ICC_SRE_EL1.SRE, it cannot be
> turned off if found on a CPU.
> 
> Set the feature as STRICT_BOOT, if boot CPU has it, all other CPUs are
> required to have it.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Makes sense.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index af50064..03a9d96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1149,7 +1149,7 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>  	{
>  		.desc = "GIC system register CPU interface",
>  		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>  		.matches = has_useable_gicv3_cpuif,
>  		.sys_reg = SYS_ID_AA64PFR0_EL1,
>  		.field_pos = ID_AA64PFR0_GIC_SHIFT,
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
