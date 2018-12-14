Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED860C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:28:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB7021104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qUB+i0Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB7021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UzWKb8N1QtwPyhSTMIRR/spaFgoyKsNG/Cp11MKMiR4=; b=qUB+i0UnoqPq1B
	Hv2sapy6KalwJK94fnRmFuXTBWuQg7FP7Zg1+FQtRdhdYMTTpTVaq4LPka/aC4P4cirnm2uIVh2+/
	r7y63r3siTsfom3bos1NfOEcDPMwyZ37qGzfFlhV0BmezdjDrOwPRGmwFgazkgHk+R9KBNHHRGaSt
	adl98ihOtb2V8TP0thJ6jx/fCsoirSXIZ8i1pXzsdiOfLd9d93viiU9CtrvaOwci/x8h51W2SD4nn
	UEOdFDLVoLYD1Cvcpr3zLNMyKzBCZPXWtT2Uf52Rsj2r5ZgsLMN9NS354iEsDygyb2/cfBeVvIx59
	sCwMhtNCq/RcI/lCK37g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXldz-0006r1-Rz; Fri, 14 Dec 2018 11:28:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXldx-0006px-Lf
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:28:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917AAEBD;
 Fri, 14 Dec 2018 03:28:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0B623F6A8;
 Fri, 14 Dec 2018 03:28:18 -0800 (PST)
Date: Fri, 14 Dec 2018 11:28:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative
 store bypass
Message-ID: <20181214112809.GF3505@e103592.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-6-jeremy.linton@arm.com>
 <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
 <20181214103644.GB1872@edgewater-inn.cambridge.arm.com>
 <96ac8a3f-9c03-9ad9-e148-5f3422c51075@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96ac8a3f-9c03-9ad9-e148-5f3422c51075@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_032833_716062_E518BE3E 
X-CRM114-Status: GOOD (  22.87  )
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
 Will Deacon <will.deacon@arm.com>, ykaukab@suse.de,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 shankerd@codeaurora.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:41:42AM +0000, Steven Price wrote:
> On 14/12/2018 10:36, Will Deacon wrote:
> > On Fri, Dec 14, 2018 at 10:34:31AM +0000, Steven Price wrote:
> >> On 06/12/2018 23:44, Jeremy Linton wrote:
> >>> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> >>>
> >>> Return status based no ssbd_state and the arm64 SSBS feature.
> >>                       ^^ on
> >>
> >>> Return string "Unknown" in case CONFIG_ARM64_SSBD is
> >>> disabled or arch workaround2 is not available
> >>> in the firmware.
> >>>
> >>> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> >>> [Added SSBS logic]
> >>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>> ---
> >>>  arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
> >>>  1 file changed, 28 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> >>> index 6505c93d507e..8aeb5ca38db8 100644
> >>> --- a/arch/arm64/kernel/cpu_errata.c
> >>> +++ b/arch/arm64/kernel/cpu_errata.c
> >>> @@ -423,6 +423,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >>>  		ssbd_state = ARM64_SSBD_UNKNOWN;
> >>>  		return false;
> >>>  
> >>> +	/* machines with mixed mitigation requirements must not return this */
> >>>  	case SMCCC_RET_NOT_REQUIRED:
> >>>  		pr_info_once("%s mitigation not required\n", entry->desc);
> >>>  		ssbd_state = ARM64_SSBD_MITIGATED;
> >>> @@ -828,4 +829,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> >>>  	}
> >>>  }
> >>>  
> >>> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> >>> +		struct device_attribute *attr, char *buf)
> >>> +{
> >>> +	/*
> >>> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> >>> +	 *  for hetrogenous machines, and that if SSBS is supported its
> >>                                                   ^^^^ SSBD
> >>> +	 *  supported by all cores.
> >>> +	 */
> >>> +	switch (arm64_get_ssbd_state()) {
> >>> +	case ARM64_SSBD_MITIGATED:
> >>> +		return sprintf(buf, "Not affected\n");
> >>> +
> >>> +	case ARM64_SSBD_KERNEL:
> >>> +	case ARM64_SSBD_FORCE_ENABLE:
> >>> +		if (cpus_have_cap(ARM64_SSBS))
> >>> +			return sprintf(buf, "Not affected\n");
> >>> +		return sprintf(buf,
> >>> +			"Mitigation: Speculative Store Bypass disabled\n");
> >>
> >> NIT: To me this reads as the mitigation is disabled. Can we call it
> >> "Speculative Store Bypass Disable" (with a capital 'D' and without the
> >> 'd at the end)?
> > 
> > Whilst I agree that the strings are reasonably confusing (especially when
> > you pile on the double-negatives all the way up the stack!), we really
> > have no choice but to follow x86's lead with these strings.
> > 
> > I don't think it's worth forking the ABI in an attempt to make this clearer.
> 
> Ah, sorry I hadn't checked the x86 string - yes we should match that.

This is rather why I feel these strings are either a) useless or
b) should be documented somewhere.

Putting at least a skeleton document somewhere could be a good start,
and would require little effort.


What decisions do we expect userspace to make based on this information?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
