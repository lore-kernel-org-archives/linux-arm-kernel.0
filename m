Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E3C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TPPBK4Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5k4F0XgWQcKG8vM6yagCs1iohW51Pdn9PjLjtmUid7g=; b=TPPBK4GgzvArCN
	brSZTUlTFCqYIeRoPs8V9/WP1CaFptMQOQC8dG7KztJr9tZPjWYgqBmAhIi4e+qPTOlDjgWFOgMhm
	ZwyOY3L/LJWmPzgBmfUVUpAPcCVTttrIxsuhUaaS/5sbX6Wav8CGcD2ZtDK7S6w8boOmNgkJS1J3b
	dN63hr75TxbdjTznbDkrJnYMGt7DA6G17+RGNfkeg3pIPXAy/6L4dd/4JeMLM+zGIwx5NCw0AhLuk
	+yDwRLNEIvu7agvVvBikdd1nrOLcl90LnLJq6+3wy7xnWlCsdcjiyAC0xvZg9hOeWS95Ys/UFBdi+
	z6x2Gq2ioUdNhAKba6hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGZW-0007gW-0d; Thu, 31 Jan 2019 17:56:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGZA-0007Q8-SN
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:56:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D95FA78;
 Thu, 31 Jan 2019 09:55:56 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16CE13F59C;
 Thu, 31 Jan 2019 09:55:53 -0800 (PST)
Date: Thu, 31 Jan 2019 17:55:50 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 11/12] arm64: add sysfs vulnerability show for
 speculative store bypass
Message-ID: <20190131175550.1e96e80f@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-12-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-12-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_095557_749609_3D07C45C 
X-CRM114-Status: GOOD (  19.96  )
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

On Fri, 25 Jan 2019 12:07:10 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> Return status based on ssbd_state and the arm64 SSBS feature. If
> the mitigation is disabled, or the firmware isn't responding then
> return the expected machine state based on a new blacklist of known
> vulnerable cores.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index caedf268c972..e9ae8e5fd7e1 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -265,6 +265,7 @@ static int detect_harden_bp_fw(void)
>  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  
>  int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
> +static bool __ssb_safe = true;
>  
>  static const struct ssbd_options {
>  	const char	*str;
> @@ -362,10 +363,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  {
>  	struct arm_smccc_res res;
>  	bool required = true;
> +	bool is_vul;

I don't think you need this variable, you can just call is_midr_in_range_list() directly.

>  	s32 val;
>  
>  	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>  
> +	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
> +
> +	if (is_vul)
> +		__ssb_safe = false;
> +
>  	if (this_cpu_has_cap(ARM64_SSBS)) {
>  		required = false;
>  		goto out_printmsg;
> @@ -399,6 +406,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		ssbd_state = ARM64_SSBD_UNKNOWN;
>  		return false;
>  
> +	/* machines with mixed mitigation requirements must not return this */
>  	case SMCCC_RET_NOT_REQUIRED:
>  		pr_info_once("%s mitigation not required\n", entry->desc);
>  		ssbd_state = ARM64_SSBD_MITIGATED;
> @@ -454,6 +462,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  	return required;
>  }
>  
> +/* known vulnerable cores */
> +static const struct midr_range arm64_ssb_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> +	{},
> +};
> +
>  static void __maybe_unused
>  cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>  {
> @@ -743,6 +761,7 @@ const struct arm64_cpu_capabilities arm64_errata[] =
>  	{ .capability = ARM64_SSBD,
>  		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>  		.matches = has_ssbd_mitigation,
> +		.midr_range_list = arm64_ssb_cpus,
>  	},
>  #ifdef CONFIG_ARM64_ERRATUM_1188873
>  	{
> @@ -784,4 +803,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Vulnerable\n");
>  }
>  
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)

w/s issue

Cheers,
Andre.

> +{
> +	/*
> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> +	 *  for hetrogenous machines, and that if SSBS is supported its
> +	 *  supported by all cores.
> +	 */
> +	switch (arm64_get_ssbd_state()) {
> +	case ARM64_SSBD_MITIGATED:
> +		return sprintf(buf, "Not affected\n");
> +
> +	case ARM64_SSBD_KERNEL:
> +	case ARM64_SSBD_FORCE_ENABLE:
> +		if (cpus_have_cap(ARM64_SSBS))
> +			return sprintf(buf, "Not affected\n");
> +		return sprintf(buf,
> +			"Mitigation: Speculative Store Bypass disabled\n");
> +	}
> +
> +	if (__ssb_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> +
>  #endif


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
