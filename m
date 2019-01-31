Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A3C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED06E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z2x3wnG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED06E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0CNxf/nxkZ68PViy0Mv7ONr5BIWgAcp3JW5LUX+QCWg=; b=Z2x3wnG/IhIb3D
	XH9/6xN6KbYlYV/VbVAWiGUj2biZvEyv7V+4bcCXTNQewD7KEvxSC3e9Lx+iVugk+ov6+0q2xIQwN
	xlVIg2sTD+BQ2WV/L9j//I+awRXKnhr57tB/0Ko0PMpFNVKXgYfhIjiwss0GuH3yGXgEc9IE4s9Qk
	J3B6P+EB12p1EwxKQw4pz3KKs2eyratZS1aNYGZ/3LCNki692FjgZm6uqKNWjWnknbLWJDxq4A701
	QIxVx+4idUrtdAp2E3q7Zp6nla0Ie0WMzj2okmZKdsiLGxPrlfbmsgaPp+GoO2YvbaPnunC4XspJX
	/At0ylzDfxrBZl1b0wkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGZ5-0007Jr-9R; Thu, 31 Jan 2019 17:55:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGZ0-0007GY-Jf
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:55:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52254A78;
 Thu, 31 Jan 2019 09:55:46 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2ED23F59C;
 Thu, 31 Jan 2019 09:55:43 -0800 (PST)
Date: Thu, 31 Jan 2019 17:55:35 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 10/12] arm64: add sysfs vulnerability show for
 spectre v2
Message-ID: <20190131175535.3a632ba5@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-11-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-11-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_095546_918108_9146EF5F 
X-CRM114-Status: GOOD (  21.43  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 12:07:09 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> Add code to track whether all the cores in the machine are
> vulnerable, and whether all the vulnerable cores have been
> mitigated.
> 
> Once we have that information we can add the sysfs stub and
> provide an accurate view of what is known about the machine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 024c83ffff99..caedf268c972 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -497,6 +497,10 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
> 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
> 	CAP_MIDR_RANGE_LIST(midr_list)
> 
> +/* Track overall mitigation state. We are only mitigated if all cores are ok */
> +static bool __hardenbp_enab = true;
> +static bool __spectrev2_safe = true;
> +
>  /*
>   * List of CPUs that do not need any Spectre-v2 mitigation at all.
>   */
> @@ -507,6 +511,10 @@ static const struct midr_range spectre_v2_safe_list[] = {
> 	{ /* sentinel */ }
>  };
>  
> +/*
> + * Track overall bp hardening for all heterogeneous cores in the machine.
> + * We are only considered "safe" if all booted cores are known safe.
> + */
>  static bool __maybe_unused
>  check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>  {
> @@ -528,12 +536,19 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>  	if (!need_wa)
>  		return false;
>  
> -	if (need_wa < 0)
> +	__spectrev2_safe = false;
> +
> +	if (need_wa < 0) {
>  		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
> +		__hardenbp_enab = false;
> +	}
>  
>  	/* forced off */
> -	if (__nospectre_v2)
> +	if (__nospectre_v2) {
> +		pr_info_once("spectrev2 mitigation disabled by command line option\n");
> +		__hardenbp_enab = false;
>  		return false;
> +	}
>  
>  	return (need_wa > 0);
>  }
> @@ -757,4 +772,16 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  }
>  
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)

w/s issue. Other than that:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> +{
> +	if (__spectrev2_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	if (__hardenbp_enab)
> +		return sprintf(buf, "Mitigation: Branch predictor hardening\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> +
>  #endif


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
