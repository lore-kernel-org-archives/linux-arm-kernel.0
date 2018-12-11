Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B3C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:15:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BBD2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qDADVRfQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fGpDwENd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BBD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fmj2QdXExsXtRJzzraUdaBzlK/G8k7cIOo8JvdkRG+w=; b=qDADVRfQy2Hmfw
	qbZuzabe/vAHVTkAROdJ8I3RzqyOkPxzVquAoSySrlftM+fgNTsVMn1htyAukC1d1mYCnp3KJczhV
	l/EyTkqW6rZjYtuC7H0kM9scVyREpx8gFS/5mvkMbn9ncHGj/a49dssKYzs20SdkgbgXOIQyejHYC
	vAYopDb/AsYve4wqu7mIkpyHd3u3TIrYVFpYr+EQlhfL/8GgqtecWwo5EwCLy4gTJhYHIBOS0Yjjg
	K7OdO+dA7F+LlS0md2qQa1TweTTC8Me6Ot1hEtO7t1kjhXQbYb2VknMXCq2bEfzKUaVj0amoIOaKJ
	erG7UcXHTYU0DYuW24cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWe8Z-0005jF-1y; Tue, 11 Dec 2018 09:15:31 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWe8W-0005in-1M
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:15:29 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f80230000>; Tue, 11 Dec 2018 01:15:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 11 Dec 2018 01:15:17 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 11 Dec 2018 01:15:17 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 11 Dec 2018 09:15:16 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 996644053C; Tue, 11 Dec 2018 11:15:14 +0200 (EET)
Date: Tue, 11 Dec 2018 11:15:14 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Message-ID: <20181211091514.GA29064@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544519715; bh=JtRcGU7uSLlDQHzVE/5xrx7U9Pn2qELtrHn9KxpN8jc=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=fGpDwENdzpBhTq0uThDCLcf91NWv6BUQSKdXKJhhzCTZhOVVM9fbIwftZAN8DVSWU
 iO2gVZxakPYeWOQbrpqtqSF1BiA+cVzobez1f/Wit4LyKZfRQHgFV8OxY066SjU9UK
 KZaPYzBWEjV8YB6Y/xDxjioJfkUHoUKq99tBuBIKw6w+xhHENNAVXWEc6YIqWqJOmk
 Wo2gHNnwqdmpDSsAJcZzwq1e0IaKZlKS+XNMpBagJ0UHUiuuICtyNKsUbHKKywInX9
 /fZ6iEAxCroJKyInsPkcfSea1+BB14nzvCgOawNzoj9wfvmztAoB1d/QPs7C1E2Mk6
 lRzh2vOekFH9w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_011528_100442_DA5A0AB0 
X-CRM114-Status: GOOD (  20.10  )
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
Cc: devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 01:41:57PM +0000, Jon Hunter wrote:
> 
> On 04/12/2018 09:25, Joseph Lo wrote:
> > From: Peter De Schrijver <pdeschrijver@nvidia.com>
> > 
> > Add new properties to configure the DFLL PWM regulator support. Also
> > add an example and make the I2C clock only required when I2C support is
> > used.
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> >  .../bindings/clock/nvidia,tegra124-dfll.txt   | 73 ++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > index dff236f524a7..8c97600d2bad 100644
> > --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> > @@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
> >  oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
> >  control module that will automatically adjust the VDD_CPU voltage by
> >  communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
> > -Currently only the I2C mode is supported by these bindings.
> >  
> >  Required properties:
> >  - compatible : should be "nvidia,tegra124-dfll"
> > @@ -45,10 +44,28 @@ Required properties for the control loop parameters:
> >  Optional properties for the control loop parameters:
> >  - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
> >  
> > +Optional properties for mode selection:
> > +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> > +
> >  Required properties for I2C mode:
> >  - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
> >  
> > -Example:
> > +Required properties for PWM mode:
> > +- nvidia,pwm-period: period of PWM square wave in microseconds.
> > +- nvidia,init-uv: Regulator voltage in micro volts when PWM control is disabled.
> 
> Maybe consider 'pwm-inactive-voltage-microvolt'.
> 

Inactive is not very accurate. The OVR regulator will output
nvidia,align-offset-uv when the PWM input is driven low but will output
nvidia,init-uv when the PWM input is in tristate mode.

> > +- nvidia,align-offset-uv: Regulator voltage in micro volts when PWM control is
> > +			  enabled and PWM output is low.
> 
> Would this be considered the minimum pwm active voltage?
> 
> > +- nvidia,align-step-uv: Voltage increase in micro volts corresponding to a
> > +			1/33th increase in duty cycle. Eg the voltage for 2/33th
> > +			duty cycle would be:
> 
> Maybe consider 'pwm-voltage-step-microvolt'.
> 
> > +			nvidia,align-offset-uv + nvidia,align-step-uv * 2.
> > +- pinctrl-0: I/O pad configuration when PWM control is enabled.
> > +- pinctrl-1: I/O pad configuration when PWM control is disabled.
> > +- pinctrl-names: must include the following entries:
> > +  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
> > +  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
> 
> Please see Rob's feedback on the above [0].
> 
> Cheers
> Jon
> 
> [0] https://lore.kernel.org/patchwork/patch/885328/
> 
> -- 
> nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
