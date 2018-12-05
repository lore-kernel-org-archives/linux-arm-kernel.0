Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:03:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B06206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O19H48nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B06206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dYNxxR1yrXXmRpnqyFegylXaWfTMzyLTQTgTCYI5Yg=; b=O19H48nHvDT7e+
	AMAGXzX300GspmMl1nlZbhbpvZqVpvFgkcE/YTAU+NKQOG/sZWSOlu3Aq7e/Z1bRk8RwfV0nSnVf2
	8CBENiJ6UZozPCmkbbE8lv7hzdeTE0SCzkbDEddc6Rxeyzr9qd9+m65MaHHYkKR6K3ia9f6mkLRec
	jMHYv9vcaAbXTSV1LUJ7pkmj9wNlY6Tbcle5/1v3jZE/gYFZb9jtxTtbq9Q95SzLMrI62EORttzaK
	fD4Bs2jcwNkn6Aw5nZZvKSoqfM4T0hlmC+9eHzmoG9kdLMr/BQ7GK5ISPQFXVBF+kGcJdudn3/SkR
	5o1SEE473OFnoV0KCPKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYhm-0007PY-5k; Wed, 05 Dec 2018 15:03:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYhH-0006o3-7L
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:02:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7764180D;
 Wed,  5 Dec 2018 07:02:32 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 474343F5AF;
 Wed,  5 Dec 2018 07:02:32 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 07DF41AE0BC5; Wed,  5 Dec 2018 15:02:52 +0000 (GMT)
Date: Wed, 5 Dec 2018 15:02:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
Message-ID: <20181205150252.GB16171@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
 <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_070244_406201_556BB7B9 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: mark.rutland@arm.com, vladimir.murzin@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 05:18:00PM +0000, Suzuki K Poulose wrote:
> We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :
> 
> 1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
> 2) ARM Errata 819472 on A53 r0p[01]
> 
> Both have the same work around. Merge these entries to avoid
> duplicate entries for a single capability. Add a new Kconfig
> entry to control the "capability" entry to make it easier
> to handle combinations of the CONFIGs.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig               |  7 +++++++
>  arch/arm64/include/asm/cputype.h |  1 +
>  arch/arm64/kernel/cpu_errata.c   | 28 ++++++++++++++++------------
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d785..ad69e15 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -313,9 +313,13 @@ menu "Kernel Features"
>  
>  menu "ARM errata workarounds via the alternatives framework"
>  
> +config ARM64_WORKAROUND_CLEAN_CACHE
> +	def_bool n
> +
>  config ARM64_ERRATUM_826319
>  	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 826319 on Cortex-A53 parts up to r0p2 with an AMBA 4 ACE or
> @@ -337,6 +341,7 @@ config ARM64_ERRATUM_826319
>  config ARM64_ERRATUM_827319
>  	bool "Cortex-A53: 827319: Data cache clean instructions might cause overlapping transactions to the interconnect"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 827319 on Cortex-A53 parts up to r0p2 with an AMBA 5 CHI
> @@ -358,6 +363,7 @@ config ARM64_ERRATUM_827319
>  config ARM64_ERRATUM_824069
>  	bool "Cortex-A53: 824069: Cache line might not be marked as clean after a CleanShared snoop"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 824069 on Cortex-A53 parts up to r0p2 when it is connected
> @@ -380,6 +386,7 @@ config ARM64_ERRATUM_824069
>  config ARM64_ERRATUM_819472
>  	bool "Cortex-A53: 819472: Store exclusive instructions might cause data corruption"
>  	default y
> +	select ARM64_WORKAROUND_CLEAN_CACHE
>  	help
>  	  This option adds an alternative code sequence to work around ARM
>  	  erratum 819472 on Cortex-A53 parts up to r0p1 with an L2 cache
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 12f93e4d..2e26375 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -151,6 +151,7 @@ struct midr_range {
>  		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
>  	}
>  
> +#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)

What's the point of this macro?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
