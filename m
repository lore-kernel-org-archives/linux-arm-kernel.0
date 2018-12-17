Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:02:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306152133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dkWlhBOu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="THVyinoG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="myc9L/Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306152133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c9xPdm8un6XeP+YP3ZBPtShdSjYEFWAKSMhRy2B/dSs=; b=dkWlhBOuoKOuIa
	fDxFecVdP6Y2ht+z/aPuEnCHNAwajTemlNGUIl/yv147/FD98JcJjl3ZdWwRWoDLYRwVzFf8Ge+2f
	IBHAtJSw3hea1sL3KFiBLcEwCJY6mRauMkGPJtKRCYB9Fnwal010cCwhJMEXYE3/zP91bwdINNuXg
	tsTtRYESZROsqOX5lXQw7sLCAEyfVhypdc8tNtLFzDyHbpkCuKoviXcHh8a61YgOkSR2hl223Gxih
	Skoa2KSFLFfIz+pzYXK2U42XJhGol+vlhwFVSAV3tMP+gLaOl95zVvSCiKa8y2874YEOD3lRjusED
	bqEvXL1pamtTDUpBkl9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ0xh-0001P7-Bq; Mon, 17 Dec 2018 22:02:05 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ0xd-0001O5-Ab
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 22:02:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6C7A160851; Mon, 17 Dec 2018 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545084110;
 bh=ZR0llJLMIAFU8g4tn84/yMCgjeabveCXDS9qPeBElJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=THVyinoGBXfDQZfe6piSjMGqQiErumW97XbCa/+0O0AVwBBksGyPPYeK4CZ2/gKU8
 qjyrHOfeYFXk/a5EHnlvyoi0E3FSBdRRWA1q+ICsa7Zg3JnTa/YR3lW5o39oxXhbs0
 9vNhYm5unMF4BkUQDpXwIox6UjaPIB6P3ni3Xk2Y=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 683D360225;
 Mon, 17 Dec 2018 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545084109;
 bh=ZR0llJLMIAFU8g4tn84/yMCgjeabveCXDS9qPeBElJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=myc9L/GhjLUr1es6cQiZ3txHXvdo5wiK9ad6iq9Q4aQUR7hVEoako/Lal3ZhNreqj
 8NYaKQ2ekLT460aL2SxkWW/MYX1FDGOPx6eMYu4VybrkQJBdaixlO+4CeN325JhxjW
 n8+2LXl6MvuTKNDyZN4R9plFkkET0rKYu9wis4pc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 683D360225
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 17 Dec 2018 15:01:46 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: drm/msm/a6xx: Document GMU and
 update GPU bindings
Message-ID: <20181217220146.GA18380@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dianders@chromium.org, vireshk@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-2-jcrouse@codeaurora.org>
 <20181217212010.GA22389@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217212010.GA22389@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_140201_401847_77E4AAA6 
X-CRM114-Status: GOOD (  26.13  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, vireshk@kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 03:20:10PM -0600, Rob Herring wrote:
> On Wed, Dec 12, 2018 at 02:18:47PM -0700, Jordan Crouse wrote:
> > Update the GPU bindings and document the new bindings for the GMU
> > device found with Adreno a6xx targets.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  .../devicetree/bindings/display/msm/gmu.txt   | 56 +++++++++++++++++++
> >  .../devicetree/bindings/display/msm/gpu.txt   | 41 +++++++++++++-
> >  2 files changed, 94 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > new file mode 100644
> > index 000000000000..6152cb551d29
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > @@ -0,0 +1,56 @@
> > +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> > +
> > +The GMU is a programmable power controller for the GPU. the CPU controls the
> > +GMU which in turn handles power controls for the GPU.
> > +
> > +Required properties:
> > +- compatible:
> > +  * "qcom,adreno-gmu"
> 
> I probably asked before, but this needs a specific compatible unless you 
> have reliable version/capability registers. If you do, please state that 
> here.

Most of our decisions are made based on the type of GPU attached but it wouldn't
hurt to make this future proof.  I'll do it.

> > +- reg: Physical base address and length of the GMU registers.
> > +- reg-names: Matching names for the register regions
> > +  * "gmu"
> > +  * "gmu_pdc"
> > +  * "gmu_pdc_seg"
> > +- interrupts: The interrupt signals from the GMU.
> > +- interrupt-names: Matching names for the interrupts
> > +  * "hfi"
> > +  * "gmu"
> > +- clocks: phandles to the device clocks
> > +- clock-names: Matching names for the clocks
> > +   * "gmu"
> > +   * "cxo"
> > +   * "axi"
> > +   * "mnoc"
> > +- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
> > +- iommus: phandle to the adreno iommu
> > +- operating-points-v2: phandle to the OPP operating points
> > +
> > +Example:
> > +
> > +/ {
> > +	...
> > +
> > +	gmu: gmu@506a000 {
> > +		compatible="qcom,adreno-gmu";
> > +
> > +		reg = <0x506a000 0x30000>,
> > +			<0xb280000 0x10000>,
> > +			<0xb480000 0x10000>;
> > +		reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> > +
> > +		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-names = "hfi", "gmu";
> > +
> > +		clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> > +			<&gpucc GPU_CC_CXO_CLK>,
> > +			<&gcc GCC_DDRSS_GPU_AXI_CLK>,
> > +			<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> > +		clock-names = "gmu", "cxo", "axi", "memnoc";
> > +
> > +		power-domains = <&gpucc GPU_CX_GDSC>;
> > +		iommus = <&adreno_smmu 5>;
> > +
> > +		operating-points-v2 = <&gmu_opp_table>;
> > +	};
> > +};
> > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > index 43fac0fe09bb..8d9415180c22 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > @@ -8,14 +8,21 @@ Required properties:
> >    with the chip-id.
> >  - reg: Physical base address and length of the controller's registers.
> >  - interrupts: The interrupt signal from the gpu.
> > -- clocks: device clocks
> > +- interrupt-names: List of names for the interrupt signals. The following can be
> > +  provided:
> > +  * "kgsl_3d0_irq"
> 
> I'm pretty sure 'kgsl' is not a hardware thing. You don't need *-names 
> when there is only one of something.

This has mainly existed just for compatibility issues.  We do only have the one
interrupt so lets zap the downstream name and never look back.

> > +- clocks: device clocks (if applicable)
> 
> What does this mean? They are now optional? If so, move to an "Optional" 
> section. Likewise for the others.

They are indeed optional now.

> Really, you should add a new compatible so we can validate when clocks 
> not being present is valid vs. an error in the DT.

We could use the GPU revision for that, but our approach has been to make all
clocks optional for all targets.  Eventually when we go to power up if the GPU
core ends up needing a clock and it isn't defined we fail probe at that point.
I'm not sure if that is resilient enough for DT purposes though.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
