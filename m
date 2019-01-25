Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98425C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67971218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E16GNfH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67971218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kAKT8reZTRnH/JCMtM7LqwQmmA9pxxlmBnH1F0PXJb4=; b=E16GNfH06IK66d
	fNVb5Z45fC0KiIwaUtdiMwXBw3lx1r9xxwmrhWCsj0F+NKj/PzHin+wkUolh9TUBRJ8pTjUoX+NCR
	6TOFfcaZCmueFegcQxEG4Q0VliHLmeIah1Qnkk0KL5MLcVgL8VXL+iuXG6t6UO6TVU1qRFOQK+jcG
	gcWZZrzN/ix/opxDq4M2WK7OreYqwVmSkMKhsq4Z5Bn71MgGK3/EZQBO9SRZncl71ADE8XDuMe1S4
	hc3rjU75UtfRp9mNXy5mXRXKWHWgQYLYVaVieUzV4P4tLfpRd3lXt39Gc61iWoNj2qWTqWUsqrUi+
	ijuo8vob7FyZccg5axCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5wX-0001Xn-Ui; Fri, 25 Jan 2019 18:11:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5tq-0006FB-Vs
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:09:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951841596;
 Fri, 25 Jan 2019 10:08:17 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 85BE93F5AF; Fri, 25 Jan 2019 10:08:16 -0800 (PST)
Date: Fri, 25 Jan 2019 18:08:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190125180813.GM25901@arrakis.emea.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_100820_036722_B88DFFCE 
X-CRM114-Status: GOOD (  16.18  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 08:54:33AM +0000, Zhang, Lei wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index efb7b2c..37e4f18 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -666,6 +666,28 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static int do_bad_unknown_63(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +{
> +	/*
> +	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
> +	 * memory accesses may spuriously trigger data aborts with
> +	 * DFSC=0b111111.
> +	 */
> +	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001)) {
> +		if (cpus_have_cap(ARM64_WORKAROUND_FUJITSU_A64FX_0100001)) {
> +			return 0;
> +		} else { /* cpu capabilities maybe not ready*/
> +			unsigned int current_cpu_midr = read_cpuid_id();
> +			const struct midr_range fujitsu_a64fx_midr_range = {
> +				MIDR_FUJITSU_A64FX, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0)
> +			};
> +			if (is_midr_in_range(current_cpu_midr, &fujitsu_a64fx_midr_range) == TRUE)
> +				return 0;
> +		}
> +	}
> +	return do_bad(addr, esr, regs);
> +}

IIUC, this can happen very early when the errata framework isn't yet
ready. Given that this is not on a fast path (you already took a fault),
I don't think it's worth optimising for cpus_have_cap() (and
ARM64_WORKAROUND_FUJITSU_A64FX_0100001). I've seen Mark's comments on
why checking MIDR in a preemptible context is not a good idea but I
suspect your platform is homogeneous (i.e. not big.LITTLE).

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
