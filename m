Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89950C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:48:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5947320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VcIH6g85";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MISxFTZV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="baQMrvhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gZWHrkN5w7OPSOduOzlASfCSSKKmOAOpP038zWXOCCM=; b=VcIH6g85dQK9sb
	NiZEstRAXNGgphATVCp/2nX6SNs4t0ew2vKVXya2pAi1MuNcE9RKpUZHtXerGqkUwpSlQWLcOwqsE
	V42PB88WMQRf1jiNuhPFP89/fPsfl12ajSfhcwG8lVy4NvaBW3HYEEjCkwAWLXdHZI7YwnN48b/bh
	nKyTsSbdgERTUojVEVhn/T6bS4ClCC78YX09tAyOVPMcV1k06snSLTziQ3x1YBCkhOiEr9pr/LFWW
	qoZU6Av/PzBeteboYhqGVtDh766fUynA2rDEWk4eLMcA+AjclJVBJOkmGCJOciby1FvhPaF0PP6Ck
	1UBbX91kqvzAXYz9ac/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAV0-0000Id-Vb; Wed, 12 Dec 2018 19:48:50 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAUx-0000H3-G3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:48:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id EF02D602FE; Wed, 12 Dec 2018 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544644116;
 bh=b46EnVHCycbvAASQ6jHtGXHYP5VwT18OFa5ZY32q7Ys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MISxFTZVQvYY3T64FySX2ZzA62ok2cdy6fbrkBrCV+2/OJv881zPOjriHYq1H5cYM
 9hlpyPdqokcR5JqQ5HLenXADGgvQpWp8svFDovAHBH23PNj5p564ifru69AMMFGy2s
 +sgkYjwnFXr+pOm+QYuUMsuXCQseKaNil/2jmzLo=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id F41ED6021A;
 Wed, 12 Dec 2018 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544644114;
 bh=b46EnVHCycbvAASQ6jHtGXHYP5VwT18OFa5ZY32q7Ys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=baQMrvhgFmIcjJf91tgnaIR59NQF5AffgHBUTtLAcks64t7d1N4tBnXGZ80/ttLY2
 0ehbcpkkUdhFA/Jud0zQNwuzHmz67NVlaEIQvHqvLTwOJPZV+r+6oCrUddbTyJ4isV
 xIBZL7YUoFIxh5FyvfDxUEwoMSaUv6JfGYcEeTcs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F41ED6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Wed, 12 Dec 2018 12:48:31 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: Document,qcom,adreno-gmu
Message-ID: <20181212194831.GA29770@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, vireshk@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20181212173106.29618-1-jcrouse@codeaurora.org>
 <20181212173106.29618-2-jcrouse@codeaurora.org>
 <CAD=FV=Xiu-Vqm3F0PbvgWOpmk9gKA_xNaEKRJpT_092ztA4QUg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xiu-Vqm3F0PbvgWOpmk9gKA_xNaEKRJpT_092ztA4QUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_114847_570708_D7A11250 
X-CRM114-Status: GOOD (  31.47  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 11:26:46AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Dec 12, 2018 at 9:31 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Document the device tree bindings for the Adreno GMU device
> > available on Adreno a6xx targets.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  .../devicetree/bindings/display/msm/gmu.txt   | 54 +++++++++++++++++++
> >  .../devicetree/bindings/display/msm/gpu.txt   |  2 +
> >  2 files changed, 56 insertions(+)
> 
> nit: Why does subject have a "," after "Document"?

Typo.

> nit: Should subject start "dt-bindings: drm/msm/a6xx" or something
> like that?  I thought you wanted not just "dt-bindings" but also a
> subsystem prefix?

I was trying to reuse the subject from the previous versions, but I would be
happy to change it.

> 
> >  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > new file mode 100644
> > index 000000000000..f65bb49fff36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > @@ -0,0 +1,54 @@
> > +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> > +
> > +The GMU is a programmable power controller for the GPU. the CPU controls the
> > +GMU which in turn handles power controls for the GPU.
> > +
> > +Required properties:
> > +- compatible:
> > +  * "qcom,adreno-gmu"
> > +- reg: Physical base address and length of the GMU registers.
> > +- reg-names: Matching names for the register regions
> > +  * "gmu"
> > +  * "gmu_pdc"
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
> > +       ...
> > +
> > +       gmu: gmu@506a000 {
> > +               compatible="qcom,adreno-gmu";
> > +
> > +               reg = <0x506a000 0x30000>,
> > +                       <0xb200000 0x300000>;
> > +               reg-names = "gmu", "gmu_pdc";
> 
> Your implementation has 3 register ranges but your bindings have 2.
> You also have a different address for "gmu_pdc" even though it looks
> like your examples are supposed to be based on sdm845.
>
> (you'd want to not only change the example but also the bindings above)

I'll update the settings - a new region has indeed been added since the last
time we were here.

> 
> > +
> > +               interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> > +               interrupt-names = "hfi", "gmu";
> > +
> > +               clocks = <&clock_gpucc GPU_CC_CX_GMU_CLK>,
> > +                       <&clock_gpucc GPU_CC_CXO_CLK>,
> > +                       <&clock_gcc GCC_DDRSS_GPU_AXI_CLK>,
> > +                       <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>;
> 
> nit: might as well update to "&gpucc" to match the style of clock
> controller labels used in sdm845.dts.
> 
> 
> > +               clock-names = "gmu", "cxo", "axi", "memnoc";
> > +
> > +               power-domains = <&clock_gpucc GPU_CX_GDSC>;
> > +               iommus = <&adreno_smmu 5>;
> > +
> > +       i       operating-points-v2 = <&gmu_opp_table>;
> 
> Why "i"?

Also a typo.

> ...also: worth actually including the operating table here in the example?

I say no.  It might good practice to have the opp tables in the child node but I
don't think it is mandatory from a bindings perspective.

The bindings are documented elsewhere and to me that seems enough for our
purposes - at least thats our story for smmu and gpucc and other phandles.

> 
> > +       };
> > +};
> > diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > index 43fac0fe09bb..754f6c6f34e5 100644
> > --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> > @@ -14,6 +14,8 @@ Required properties:
> >    * "core"
> >    * "iface"
> >    * "mem_iface"
> > +- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> > +  control the power for the GPU
> 
> You seem to have lost something between the previous version of this
> and the latest.  In the last version (and the version Rob gave his
> review to) you added some extra text.  Diffing your old patch to your
> new one:
> 
> -Optional properties.
> -- clocks: device clocks. Required for a3xx, a4xx and a5xx targets. a6xx and
> -  newer with a GMU attached do not have direct clock control from the CPU and
> -  do not need to provide clock properties.
> +- clocks: device clocks
>    See ../clocks/clock-bindings.txt for details.
> -- clock-names: the following clocks can be provided:
> +- clock-names: the following clocks are required:

You are right that "can be provided" is correct.

> Did you mean to remove that?  Your current bindings now say that the
> clocks are required but then your device tree patch for sdm845 says
> they're not.
> 
> >  Example:
> 
> While you're touching this file, maybe update the "Example" so instead
> of saying "qcom,kgsl-3d0@" it says "gpu@"

I don't want to much with the example too much lest we "break" it for older
targets. I'll see what generic stuff we can change without breaking the original
intent.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
