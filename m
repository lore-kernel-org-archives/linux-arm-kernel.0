Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A40C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED412133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7vU0w64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED412133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SHu/yIfeclwzYu5hOLAw2tAQ3BURa0OxqGjKt+XHyjE=; b=p7vU0w64OxFV51
	q90YsuFNT4EMnzCfOD9pnro4zw3yEYwBufQQo5OGKhk2ikJvYM7Z2bgDHamwUDB1LrWBegEg0H55h
	zFXymL4e5NFsuPQ49vb8sARUN8aswIhG4rPaFWHcb8hNPWecDhr0juC9+k3/73WnFOoZEN1FU5Xnj
	NzuVjcDz07WI5NVTNcPdpR4IplW9Ij4KnMB8UKjiZ4w34unrNFd7USxSQsXetWXQG/3XRTXr5Z38b
	Qg/KOkp0DUBvTbXE+TD7UK5JCGl3FlNUcDJjCZmleKazIgLpFXWRxx8DO+auMsz5ivlJ1PKobRFIm
	Jjor3KFvZULZDZBAXmvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ0JO-0004L9-7x; Mon, 17 Dec 2018 21:20:26 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ0JL-0004KM-9l
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 21:20:24 +0000
Received: by mail-ot1-f68.google.com with SMTP id v23so13595205otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 13:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dHNjVyUyv+cXt8/HdMets4+TSK2C5WCQqxpfmYWmDeY=;
 b=VJvVG0oOXEcGKo0M61bkE7Y6FuOBZ1RJtQve+l4kv7JTB/XHQb1a/VCnsA+KS/Vcly
 ZqBZVcm+NDSsU0yxugntPz5/4oVZ+j9SbJE0fsFG2Ig2VKBAt6t9gRYmqIPp9fneQkXG
 qsPBmMUX9Yz7r4qx7bkZLPpCb4wSMP/orXldDoj+Khag4EfYl7mOGIu2tFcXW6DBeUAR
 yb6Rkbtu1SkKnuMQZIovC1QwOPxSOW2ruacGkSiu16AU8x3+RBBlojh1GeiVzV0k0+mT
 f2vNb0zYGdwH1n/TOZrjXdN2/Gsjh4/4lhPuKcXZRPKwSfYeKotPvVSAF2WydthzTDwZ
 NOTA==
X-Gm-Message-State: AA+aEWY8Kpt3YqRn/oXppLsPkeajbfWv50FsT0EbJD7sZrTFiJfv+nV5
 iRVEU+TQF2AqKIgD00GBjg==
X-Google-Smtp-Source: AFSGD/XzCx0eE9jDBuQjHBlrJpaGbaAPIs2VIuIyn2Fl1ikEhbZGNqmp4X4BAW1HnMaeSzbIkDHQCg==
X-Received: by 2002:a9d:4201:: with SMTP id q1mr849989ote.126.1545081612205;
 Mon, 17 Dec 2018 13:20:12 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id k13sm11782125otj.19.2018.12.17.13.20.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 13:20:11 -0800 (PST)
Date: Mon, 17 Dec 2018 15:20:10 -0600
From: Rob Herring <robh@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: drm/msm/a6xx: Document GMU and
 update GPU bindings
Message-ID: <20181217212010.GA22389@bogus>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-2-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212211848.26768-2-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_132023_340570_1FD382B9 
X-CRM114-Status: GOOD (  23.54  )
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

On Wed, Dec 12, 2018 at 02:18:47PM -0700, Jordan Crouse wrote:
> Update the GPU bindings and document the new bindings for the GMU
> device found with Adreno a6xx targets.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  .../devicetree/bindings/display/msm/gmu.txt   | 56 +++++++++++++++++++
>  .../devicetree/bindings/display/msm/gpu.txt   | 41 +++++++++++++-
>  2 files changed, 94 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> new file mode 100644
> index 000000000000..6152cb551d29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> @@ -0,0 +1,56 @@
> +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> +
> +The GMU is a programmable power controller for the GPU. the CPU controls the
> +GMU which in turn handles power controls for the GPU.
> +
> +Required properties:
> +- compatible:
> +  * "qcom,adreno-gmu"

I probably asked before, but this needs a specific compatible unless you 
have reliable version/capability registers. If you do, please state that 
here.

> +- reg: Physical base address and length of the GMU registers.
> +- reg-names: Matching names for the register regions
> +  * "gmu"
> +  * "gmu_pdc"
> +  * "gmu_pdc_seg"
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
> +	...
> +
> +	gmu: gmu@506a000 {
> +		compatible="qcom,adreno-gmu";
> +
> +		reg = <0x506a000 0x30000>,
> +			<0xb280000 0x10000>,
> +			<0xb480000 0x10000>;
> +		reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> +
> +		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "hfi", "gmu";
> +
> +		clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +			<&gpucc GPU_CC_CXO_CLK>,
> +			<&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +			<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> +		clock-names = "gmu", "cxo", "axi", "memnoc";
> +
> +		power-domains = <&gpucc GPU_CX_GDSC>;
> +		iommus = <&adreno_smmu 5>;
> +
> +		operating-points-v2 = <&gmu_opp_table>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 43fac0fe09bb..8d9415180c22 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -8,14 +8,21 @@ Required properties:
>    with the chip-id.
>  - reg: Physical base address and length of the controller's registers.
>  - interrupts: The interrupt signal from the gpu.
> -- clocks: device clocks
> +- interrupt-names: List of names for the interrupt signals. The following can be
> +  provided:
> +  * "kgsl_3d0_irq"

I'm pretty sure 'kgsl' is not a hardware thing. You don't need *-names 
when there is only one of something.

> +- clocks: device clocks (if applicable)

What does this mean? They are now optional? If so, move to an "Optional" 
section. Likewise for the others.

Really, you should add a new compatible so we can validate when clocks 
not being present is valid vs. an error in the DT.

>    See ../clocks/clock-bindings.txt for details.
> -- clock-names: the following clocks are required:
> +- clock-names: the following clocks can be provided:
>    * "core"
>    * "iface"
>    * "mem_iface"
> +- iommus: optional phandle to an adreno iommu instance
> +- operating-points-v2: optional phandle to the OPP operating points
> +- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
> +  control the power for the GPU

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
