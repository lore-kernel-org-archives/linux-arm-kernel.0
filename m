Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CAC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:34:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0508120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qnh17RPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0508120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wl7X6pCqemkGnWdC3RdLdp7mmE8BTkWeboZGc+K3zQ8=; b=qnh17RPlk8ng1c
	EBPihuu6PjjF9XvaxBH1eAU79852J/pcbWWmmFt5gb3m160VrNsiVhe3llIQQG/d4sOxZeT1ElKa2
	9Tn6/dwlR9EwTwUyXH0GkGfT3b/1ql+Zl/sK/74RPSMS1c2yjYROpUSZU038JJoYuESuyGLtntZD0
	EXpIzpnuu3TXJWC6yo89zPvi1aUklsMXLyh96Ne7x63bvFt/0zjEup4udHx6XOQyTf4gdnuU9A6Ik
	71yjusz3CxDf+6bi2dAlgtk/wZw3unPWWNbkmQ7vseu2qkixJbSnmpJ1IFUHOO/j+ptaesIdpNvNH
	TGHeUdNxLxguPsonpV4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkny-0008N6-Od; Fri, 14 Dec 2018 10:34:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXknu-0008ML-N9
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:34:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A99DA78;
 Fri, 14 Dec 2018 02:34:34 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE133F614;
 Fri, 14 Dec 2018 02:34:32 -0800 (PST)
Subject: Re: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative
 store bypass
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-6-jeremy.linton@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
Date: Fri, 14 Dec 2018 10:34:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-6-jeremy.linton@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_023446_760290_C15C87FD 
X-CRM114-Status: GOOD (  19.97  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06/12/2018 23:44, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Return status based no ssbd_state and the arm64 SSBS feature.
                      ^^ on

> Return string "Unknown" in case CONFIG_ARM64_SSBD is
> disabled or arch workaround2 is not available
> in the firmware.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Added SSBS logic]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 6505c93d507e..8aeb5ca38db8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -423,6 +423,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		ssbd_state = ARM64_SSBD_UNKNOWN;
>  		return false;
>  
> +	/* machines with mixed mitigation requirements must not return this */
>  	case SMCCC_RET_NOT_REQUIRED:
>  		pr_info_once("%s mitigation not required\n", entry->desc);
>  		ssbd_state = ARM64_SSBD_MITIGATED;
> @@ -828,4 +829,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>  	}
>  }
>  
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> +	 *  for hetrogenous machines, and that if SSBS is supported its
                                                  ^^^^ SSBD
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

NIT: To me this reads as the mitigation is disabled. Can we call it
"Speculative Store Bypass Disable" (with a capital 'D' and without the
'd at the end)?

Steve

> +
> +	case ARM64_SSBD_FORCE_DISABLE:
> +		return sprintf(buf, "Vulnerable\n");
> +
> +	default: /* ARM64_SSBD_UNKNOWN*/
> +		return sprintf(buf, "Unknown\n");
> +	}
> +}
> +
>  #endif
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
