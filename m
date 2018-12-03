Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784FAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EFA20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+vcYUX5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmFQoVms";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmFQoVms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EFA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZCklBe7Q78BHGbRJx3exVGuHjsazdWX3Ta8INBQ1dL8=; b=S+vcYUX5tmBoFD
	69NdPLSEEpfQhpe8iaGpEelmZig5SoauIoej0TZzsmrreVbM5j3QY9zfM9mAzG76ccNP756cBdg1h
	SSy9OuMdERAHt/FcmY4Es+CiYmLmUStfHhBGVT3K6NK2JNjvri3xDGjX671vs7jjPlX6wOEfGlrte
	bHD8Pqh0PUdpe1lVXUhtLLqdt3lpWJggj/NeZyTE1t+9OgTjfiloiOhLETuITdCfUj/0ImT924Sp7
	68FovsN4nqkOrLjboIh06WiSFqUE8x8sOmgrOflYFBLiCTQz0EZQb4roSLmcWnTPv0eUccgli10Ew
	TZDMOF9D6n+bQpG3HNaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwQW-0006fM-L6; Mon, 03 Dec 2018 22:10:52 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwQR-0006eh-OT
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:10:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id E025160246; Mon,  3 Dec 2018 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543875036;
 bh=wzzF/+xrkrPLC2bh8Hg4oY4qj9NdTA4BS+gipVPwm8Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZmFQoVmsr+g0neq+Xl7t/bGqXgRtg9U2EQNzw28bsBW1G/yXjbZCbjdAAQmRqyExw
 QPLW74OrTSkBUAjNZnk1wgLVPcOno6beJnZde5nTGikVrhqu7IvRyrz9ftZppVbH/g
 jrL+1smgb4w697cHIljqI16DNg8Qi473EAqKp38o=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 22C996019F;
 Mon,  3 Dec 2018 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543875036;
 bh=wzzF/+xrkrPLC2bh8Hg4oY4qj9NdTA4BS+gipVPwm8Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZmFQoVmsr+g0neq+Xl7t/bGqXgRtg9U2EQNzw28bsBW1G/yXjbZCbjdAAQmRqyExw
 QPLW74OrTSkBUAjNZnk1wgLVPcOno6beJnZde5nTGikVrhqu7IvRyrz9ftZppVbH/g
 jrL+1smgb4w697cHIljqI16DNg8Qi473EAqKp38o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22C996019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 3 Dec 2018 15:10:33 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Jonathan Marek <jonathan@marek.ca>
Subject: Re: [Freedreno] [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
Message-ID: <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
 freedreno@lists.freedesktop.org,
 Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, 
 festevam@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Chris.Healy@zii.aero,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 NXP Linux Team <linux-imx@nxp.com>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203211816.5129-4-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_141049_220527_04C0BC1B 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, festevam@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris.Healy@zii.aero, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 freedreno@lists.freedesktop.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 04:18:16PM -0500, Jonathan Marek wrote:
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 67d462715..e9a7bbce9 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -628,5 +628,22 @@
>  				clock-names = "ipg", "ahb";
>  			};
>  		};
> +
> +		gpu: gpu@30000000 {
> +			compatible = "amd,imageon-200.1", "amd,imageon";
> +			reg = <0x30000000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <12>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +			clock-names = "core_clk", "mem_iface_clk";
> +
> +			qcom,gpu-pwrlevels {
> +				compatible = "qcom,gpu-pwrlevels";
> +				qcom,gpu-pwrlevel@0 {
> +					qcom,gpu-freq = <166250000>;
> +				};
> +			};

There shouldn't be any incremental cost in the source code to use OPP; it should
just work. And then this won't give us a further reason to keep the legacy
code around when we decide to dump any pretense of downstream "compatibility".

> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 207eb557c..586d45586 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -838,5 +838,22 @@
>  			reg = <0xf8000000 0x20000>;
>  			clocks = <&clks IMX5_CLK_OCRAM>;
>  		};
> +
> +		gpu: gpu@30000000 {
> +			compatible = "amd,imageon-200.0", "amd,imageon";
> +			reg = <0x30000000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <12>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +			clock-names = "core_clk", "mem_iface_clk";
> +
> +			qcom,gpu-pwrlevels {
> +				compatible = "qcom,gpu-pwrlevels";
> +				qcom,gpu-pwrlevel@0 {
> +					qcom,gpu-freq = <200000000>;
> +				};

Same.

> +			};

> +		};
>  	};
>  };
> -- 
> 2.17.1

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
