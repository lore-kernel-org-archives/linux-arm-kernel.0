Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE43C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:38:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA0B20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFCLRNiI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jPJI6Svw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA0B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Subject:To:From:Message-ID:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6t/clKQYqIAcotv3yHZ2gvgEsVwMMHCv+bSGTYj5VpM=; b=dFCLRNiIjsfyiy
	l68zIydMRB/SH4njRAxAJjoIQbfuOSi65//BMt5wqbwbkQxGnOCrbfDlx+LpuljpMndAdV0+2rBY2
	6o+Bzpw1NXpNqj8i3SU94wL8ygEmpghNoENBfFdcib0IbBP8JlmHMvqAWHM2sZIXf4rZiY3mUmORo
	lr1IiF36oKcjhTRFthCZ4AA4MzrXJKjSweq/nSlTNFZevxqFjoIZeqz1nhTwSfff0G6BfhwqX/aMS
	uMtv//cgQhvJy74Ws3sU2l93rvh53yUH8l/LGF+R/+D/UFbsiHMXL0qOfy7HhZVghuKV5spY8SKJi
	hlAP8s8sA5nHjDzxwlvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3Mj-0001di-Ac; Mon, 28 Jan 2019 09:38:05 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3MS-0001OW-AA
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 09:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mzYV5QxvuEjZhjPQAOjtdlHikFRLjLqvXFf5+p/MYk8=; b=jPJI6Svwq2ozGfR+aJC9K5QlA
 4tHScTUoXw09/rqM/owwQFCN1Fe+XQhhZmt04cDCPSicCvqe4Km3a1myXJyqDOyV87oIpGr4KjAnq
 nTwkKM2d2j+MJKQfrxGkqO8KpFJ1SA2wkVsC2CcEU0yxLSQUzDV6b2FUCGsfNRLV2TS60HfefUYXx
 CIPPzTG9ob/QeptvSNaxkrYwUYg0Tz1Nm9DRZUJl67oUqNsrmszRIn9JzPaNZrvpTXAbKdSqeByWp
 2oRKtBgQwas7Bhw+N/hF/RDgajF25/h0dcTWUaYoxzrzCeYOLHPSewMXZazsweL7U3afKXjWoOhgJ
 eEeceLpZg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3MP-00065Q-63
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:37:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DA41EBD;
 Mon, 28 Jan 2019 01:37:42 -0800 (PST)
Received: from big-swifty.misterjones.org (big-swifty.cambridge.arm.com
 [10.1.39.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42043F589;
 Mon, 28 Jan 2019 01:37:39 -0800 (PST)
Date: Mon, 28 Jan 2019 09:37:37 +0000
Message-ID: <86ef8xw2am.wl-marc.zyngier@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v9 07/26] arm64: ptrace: Provide definitions for PMR values
In-Reply-To: <1548084825-8803-8-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-8-git-send-email-julien.thierry@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/25.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Organization: ARM Ltd
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_043745_313792_2FFE538E 
X-CRM114-Status: GOOD (  22.94  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 15:33:26 +0000,
Julien Thierry <julien.thierry@arm.com> wrote:
> 
> Introduce fixed values for PMR that are going to be used to mask and
> unmask interrupts by priority.
> 
> The current priority given to GIC interrupts is 0xa0, so clearing PMR's
> most significant bit is enough to mask interrupts.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/ptrace.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index fce22c4..05cf913 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -25,6 +25,18 @@
>  #define CurrentEL_EL1		(1 << 2)
>  #define CurrentEL_EL2		(2 << 2)
>  
> +/*
> + * PMR values used to mask/unmask interrupts.
> + *
> + * GIC priority masking works as follows: if an IRQ's priority is a higher value
> + * than the value held in PMR, that interrupt is masked. A lower value of PMR
> + * means more IRQ priorities are masked.

Nit: It is not the priorities that are masked, but interrupts that
have a priority higher than that of PMR.

> + *
> + * To mask priorities, we clear the most significant bit of PMR.
> + */
> +#define GIC_PRIO_IRQON		0xf0
> +#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON & ~0x80)
> +
>  /* Additional SPSR bits not exposed in the UABI */
>  #define PSR_IL_BIT		(1 << 20)
>  
> -- 
> 1.9.1
> 

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
