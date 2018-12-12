Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65969C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:27:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237EF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EUGmhame";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nw4kjoW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237EF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nYWJWqtqBeWjw7b7gR5JGAS8zvSlxBTEtDPKBKF1kTo=; b=EUGmhameZz3paB
	02ePRYvQH8HVHUli743bqjfbR7htVugcblyjnVW+OCRi394tUdH5BsSTkMbbiV5Wff4BveyvUmXyi
	JJZCAv90qn+C/oJP5g8dYJIW7bkoeKXDbUcXidGtmQ1SVrGhiiSL+4OiO3E3NY896niLt5SV3kTvV
	ZJ3MB9w1POoGsAodcL/WQ9WPQ3JBixtTBI5AXD9FJXz623FZPFKMkPLC3B8SOIsDWXZy//Evt6TqY
	OTdytJWHI4KCuBRani8GrnOq3i0UrhdF/bUMk+zUuvRbqLkVOoCwXkqZJG+dyPDLqBwnHxY1JcnT8
	pObuwyginpcmo6aDjDMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXAA6-0003tr-I0; Wed, 12 Dec 2018 19:27:14 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXAA3-0003ig-Kw
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:27:13 +0000
Received: by mail-vs1-xe43.google.com with SMTP id v205so11783461vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yfH2oigcKOr3vxZNl2G/nBw2SJijyEJRABMAcO6/pC0=;
 b=Nw4kjoW9/doKki8QF6vPogYB6DHi7AG1MADKjE9pBrNyKskDd3Z+ZWpb3mR5T9CyCZ
 aWG4lFbFMskIab5Vk+4ih9PxQ/OYUJSTHwteadK44UbM7MuTEXZfpKNA7hTPs83DLMaa
 iG69AzCmYG46AJXDRicq2HqRBYpyx9bOYYjcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yfH2oigcKOr3vxZNl2G/nBw2SJijyEJRABMAcO6/pC0=;
 b=a5/xo3Vrezuu/oaet9eqQYKyFmq6tHDkGjVWH/I1575Qt3ArSyBZ40QkewdGNEJLqU
 OgYI418MwCGjQZLr/zPwL923UVtK9BnnN1DQOxLyYoSPY/Xq64Bbnsc6CpY5gpY9TGvH
 OKbk8xWjnApzkENwTGn6/Pw/OpseiT+bQvlPz3GpnTsot/pZKiZTlPtOwgid29Qy3Ml6
 z32G8oWLqj04Jwa17czjQ7tAcDvs4YfAWSJjKfmf80laP103Y9vLh5akFuFNCVNJEvzC
 85V+AgNXcKFR95jZSe7lnAWAn/ueFaeeCVlGuL+pdyxX+qz/+FpZTX0y0u+iZB9ZiHEw
 AtIA==
X-Gm-Message-State: AA+aEWakc95IYKK4h12eIa042AHmukrqu2s71ctgHR3GBbb2Wi++QAGF
 AsdlvE6Zi3Vs+XVtHdj0XE6ZKXdqyvs=
X-Google-Smtp-Source: AFSGD/VAar3gUKgnsLCW04tanJviXsLjOIEILkBK5tNmokSXiQqXizj3Vithnkz0NSk/9eW9/7gDsQ==
X-Received: by 2002:a67:7685:: with SMTP id r127mr9745468vsc.35.1544642820071; 
 Wed, 12 Dec 2018 11:27:00 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46])
 by smtp.gmail.com with ESMTPSA id t67sm5210921vkc.50.2018.12.12.11.26.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 11:26:59 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t17so11751608vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 11:26:58 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr9981525vsj.144.1544642817941; 
 Wed, 12 Dec 2018 11:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20181212173106.29618-1-jcrouse@codeaurora.org>
 <20181212173106.29618-2-jcrouse@codeaurora.org>
In-Reply-To: <20181212173106.29618-2-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Dec 2018 11:26:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xiu-Vqm3F0PbvgWOpmk9gKA_xNaEKRJpT_092ztA4QUg@mail.gmail.com>
Message-ID: <CAD=FV=Xiu-Vqm3F0PbvgWOpmk9gKA_xNaEKRJpT_092ztA4QUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: Document,qcom,adreno-gmu
To: jcrouse@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_112711_712475_FC302199 
X-CRM114-Status: GOOD (  21.95  )
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

Hi,

On Wed, Dec 12, 2018 at 9:31 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Document the device tree bindings for the Adreno GMU device
> available on Adreno a6xx targets.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  .../devicetree/bindings/display/msm/gmu.txt   | 54 +++++++++++++++++++
>  .../devicetree/bindings/display/msm/gpu.txt   |  2 +
>  2 files changed, 56 insertions(+)

nit: Why does subject have a "," after "Document"?

nit: Should subject start "dt-bindings: drm/msm/a6xx" or something
like that?  I thought you wanted not just "dt-bindings" but also a
subsystem prefix?


>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
>
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> new file mode 100644
> index 000000000000..f65bb49fff36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> @@ -0,0 +1,54 @@
> +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> +
> +The GMU is a programmable power controller for the GPU. the CPU controls the
> +GMU which in turn handles power controls for the GPU.
> +
> +Required properties:
> +- compatible:
> +  * "qcom,adreno-gmu"
> +- reg: Physical base address and length of the GMU registers.
> +- reg-names: Matching names for the register regions
> +  * "gmu"
> +  * "gmu_pdc"
> +- interrupts: The interrupt signals from the GMU.
> +- interrupt-names: Matching names for the interrupts
> +  * "hfi"
> +  * "gmu"
> +- clocks: phandles to the device clocks
> +- clock-names: Matching names for the clocks
> +   * "gmu"
> +   * "cxo"
> +   * "axi"
> +   * "mnoc"
> +- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
> +- iommus: phandle to the adreno iommu
> +- operating-points-v2: phandle to the OPP operating points
> +
> +Example:
> +
> +/ {
> +       ...
> +
> +       gmu: gmu@506a000 {
> +               compatible="qcom,adreno-gmu";
> +
> +               reg = <0x506a000 0x30000>,
> +                       <0xb200000 0x300000>;
> +               reg-names = "gmu", "gmu_pdc";

Your implementation has 3 register ranges but your bindings have 2.
You also have a different address for "gmu_pdc" even though it looks
like your examples are supposed to be based on sdm845.

(you'd want to not only change the example but also the bindings above)


> +
> +               interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "hfi", "gmu";
> +
> +               clocks = <&clock_gpucc GPU_CC_CX_GMU_CLK>,
> +                       <&clock_gpucc GPU_CC_CXO_CLK>,
> +                       <&clock_gcc GCC_DDRSS_GPU_AXI_CLK>,
> +                       <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>;

nit: might as well update to "&gpucc" to match the style of clock
controller labels used in sdm845.dts.


> +               clock-names = "gmu", "cxo", "axi", "memnoc";
> +
> +               power-domains = <&clock_gpucc GPU_CX_GDSC>;
> +               iommus = <&adreno_smmu 5>;
> +
> +       i       operating-points-v2 = <&gmu_opp_table>;

Why "i"?

...also: worth actually including the operating table here in the example?


> +       };
> +};
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 43fac0fe09bb..754f6c6f34e5 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -14,6 +14,8 @@ Required properties:
>    * "core"
>    * "iface"
>    * "mem_iface"
> +- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> +  control the power for the GPU

You seem to have lost something between the previous version of this
and the latest.  In the last version (and the version Rob gave his
review to) you added some extra text.  Diffing your old patch to your
new one:

-Optional properties.
-- clocks: device clocks. Required for a3xx, a4xx and a5xx targets. a6xx and
-  newer with a GMU attached do not have direct clock control from the CPU and
-  do not need to provide clock properties.
+- clocks: device clocks
   See ../clocks/clock-bindings.txt for details.
-- clock-names: the following clocks can be provided:
+- clock-names: the following clocks are required:

Did you mean to remove that?  Your current bindings now say that the
clocks are required but then your device tree patch for sdm845 says
they're not.

>  Example:

While you're touching this file, maybe update the "Example" so instead
of saying "qcom,kgsl-3d0@" it says "gpu@"


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
