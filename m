Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78978214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFZ/4ikn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kIt8rzHs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bMROu3pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78978214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KTKDXsgXLL1B2J2z4ieWYMEz96y89UhrkRqS9Kqh0Zk=; b=OFZ/4ikntodKzn
	5WvZ5WX772WOM5FeVMG1T+CHK7PV9+fT0eG1iGu9IKd6PkUnGaNDHJdiyJ9RDsABopO9Z++K2jOkl
	dn2/TAl+pNTaLeF8lZEuqCGhBe17kbiHJbR3poHRjky+xnpocP+h22i4SuDIu9TFx55qkLevp5rCU
	kOGDeF0QFu0ZXs6rKlj5GGRyiOjyBGWm3aqiXWgBQLq+8MawhUcjslD6qQhel0NGjz1LEFqrzF40i
	sVzGNI+6bCxx6ot1UoNjY0CIgVu6RiB0t4Xr6YPVCpTnlX3IsV++AdnDSlLSvmFEJFne/wMw2ZCmF
	cGaHghUw1uf7G7kX6l/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWU9-0008C9-HK; Tue, 29 Jan 2019 16:43:41 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWU5-0008BG-2F
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:43:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 9A48960881; Tue, 29 Jan 2019 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548780216;
 bh=JfTrcetsbIer2xED0sD2i7Mz01/A5DfN8tSHkm0L1/o=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=kIt8rzHsEL6QFMpIsCz93vpqYp4jGRPOplr0WHmOTYX2k7+kHYPnANlKUdjahkwIp
 U6YVBzqMvvovNEiuA1Fw15VevNKpMtcphbOjlNluUuMZBeFin57uhaOQU3UbXYeddU
 L9sIq1sb6COmwCGYiZtf3pCD6apuza5azaIzXYiQ=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A8E75601CF;
 Tue, 29 Jan 2019 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548780215;
 bh=JfTrcetsbIer2xED0sD2i7Mz01/A5DfN8tSHkm0L1/o=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=bMROu3pGcvlDg5M5AK/lkq99zRox9csQN5evQ16vBttp94OwPUmDOzeREknDGC8j6
 1KLy/SP/K4uo7gUDiqlz6VeAd9pjnYYxdtM833rIFUgGjq5uCek1X5DXORoBAlu1nM
 OlAgikCboDXVxDZIHTBtqeOqLfIpIrWgajMIS24U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8E75601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 29 Jan 2019 09:43:32 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 4/6] arm64: dts: Add Adreno GPU and GPU smmu definitions
Message-ID: <20190129164332.GB18874@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
 <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
 <20190129160426.GA18874@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129160426.GA18874@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_084337_142467_DF0935B2 
X-CRM114-Status: GOOD (  24.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 09:04:26AM -0700, Jordan Crouse wrote:
> On Tue, Jan 29, 2019 at 01:23:33PM +0000, Srinivas Kandagatla wrote:
> > From: Jordan Crouse <jcrouse@codeaurora.org>
> > 
> > Add an initial node for the Adreno GPU and it's companion
> > SMMU. The GPU node is mostly complete except for a bare
> > bones power table that will be filled out more completely
> > later.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > [Remove mmagic clocks from GPU/smmu nodes]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Thanks for sending this.
> 
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 52 +++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 0d0b9482aa4d..b5f23594905c 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -84,6 +84,12 @@
> >  			qcom,client-id = <1>;
> >  			qcom,vmid = <15>;
> >  		};
> > +
> > +		zap_shader_region: gpu@8f200000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x0 0x90b00000 0x0 0xa00000>;
> > +			no-map;
> > +		};
> >  	};
> >  
> >  	cpus {
> > @@ -1338,6 +1344,52 @@
> >  			};
> >  		};
> >  
> > +		gpu@b00000 {
> > +			compatible = "qcom,adreno-530.2", "qcom,adreno";
> > +			#stream-id-cells = <16>;
> > +
> > +			reg = <0xb00000 0x3f000>;
> > +			reg-names = "kgsl_3d0_reg_memory";
> > +
> > +			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "kgsl_3d0_irq";
> 
> We dropped the interrupt name as of:
> 
> https://cgit.freedesktop.org/~robclark/linux/commit/?h=msm-next&id=2255f244f92e651dbd410f92d2968c6dae4ead8e
> 
> You should be able to safely omit it.
> 
> > +
> > +			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
> > +				<&mmcc GPU_AHB_CLK>,
> > +				<&mmcc GPU_GX_RBBMTIMER_CLK>,
> > +				<&gcc GCC_BIMC_GFX_CLK>,
> > +				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
> > +
> > +			clock-names = "core",
> > +				"iface",
> > +				"rbbmtimer",
> > +				"mem",
> > +				"mem_iface";
> > +
> > +			power-domains = <&mmcc GPU_GDSC>;
> > +			iommus = <&adreno_smmu 0>;
> > +
> > +			qcom,gpu-quirk-two-pass-use-wfi;
> > +			qcom,gpu-quirk-fault-detect-mask;
> 
> This was downstream silliness - neither of these "flags" made it upstream
> (thankfully).
> 
> > +
> > +			/* This is a safe speed for bring up in all bin levels.
> > +			 * This isn't the fastest the chip can go, but we can
> > +			 * get there eventually */
> > +			qcom,gpu-pwrlevels {
> > +				compatible = "qcom,gpu-pwrlevels";
> > +				qcom,gpu-pwrlevel@0 {
> > +					qcom,gpu-freq = <510000000>;
> > +				};
> > +				qcom,gpu-pwrlevel@1 {
> > +					qcom,gpu-freq = <27000000>;
> > +				};
> 
> Hmm - I haven't looked at the integration branch in a while but I'm positive
> that we had opp tables at some point because the driver supports
> opp-supported-hw. I hope I didn't just leave that sitting on my hard drive
> somewhere. I'll check and let you know.

Ugh, I just found them sitting unsent in a dusty git branch. I can either send
them as incremental patches on top of yours to be squashed later or I can
refactor this patch and send it out again, whatever is easiest for you.

Jordan

> > +			};
> > +
> > +			zap-shader {
> > +				memory-region = <&zap_shader_region>;
> > +			};
> > +		};
> > +
> >  		mdss: mdss@900000 {
> >  			compatible = "qcom,mdss";
> >  
> > -- 
> > 2.20.1
> > 
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
