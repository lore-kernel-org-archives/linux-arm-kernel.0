Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8894C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:17:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D592082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KyRzG/bl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pmfyfouw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ruEpBB/nMA1mXvwmgnLsOzS8alO0kTR1G3MQZAcBFGs=; b=KyRzG/bls9OucD
	aWoNdBdm2Z2MzR7p1mdt4cTmtB0ppljbs4BHx0ixlCM6kEdC5Oaezd3LTMwujlohvarR3s5TFiP6Y
	uaqeGgKJAjT5UOCr3vWfN0TkwFhhmgOQZ55e+Fr5AUNDnoaIt8wJkPLWL614VYkIpW4VImwVDHcb2
	DICKewk5vVTwepCoKWGlLkLgB4/Jl3qCMTnUPan5vxU7vsAhTPJk+FlrSYf7jtFN/asX2xgG4/kRy
	FyOmUWboGxzch1LHFHI971Lf2M31rPrvH38mggtRbsojX06NNMrFxao6OoEatNwWyy8zhB7+ey1ta
	GYAVy1XUPvAr1zuURCzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeAB-0006KJ-QJ; Tue, 11 Dec 2018 09:17:11 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWe9u-0005zZ-36
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:16:59 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0f80780000>; Tue, 11 Dec 2018 01:16:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 11 Dec 2018 01:16:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 11 Dec 2018 01:16:43 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 11 Dec 2018 09:16:43 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 0E31A4053C; Tue, 11 Dec 2018 11:16:41 +0200 (EET)
Date: Tue, 11 Dec 2018 11:16:41 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 01/19] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Message-ID: <20181211091641.GB29064@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-2-josephl@nvidia.com>
 <af1211f0-dda0-bdde-f320-03e54f82d7e1@nvidia.com>
 <46b5eafa-00a0-1d91-1f4d-97ab119fcf21@nvidia.com>
 <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e61b1da8-78cd-c3d4-9878-c25fd9c89ba3@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544519800; bh=A411QSLmIPpAC1NMANbP/z9YFRgAKuIPGAUL3gFl+v8=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
 User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=PmfyfouwRrR7+LsbYUDw/630/hG0H+8bVLp2kITlgi8c0LaSusGPT+c5hJ3R2gbWf
 05zwymmk9fk5Rek5V3c8DVLtmeJQ5AxtZU6/7QMgZUiED5ueH3GabZawXp9uAMsjwH
 y++keznCMNFT7NLyxPtNd5gXgbwHFurz+5C/cTPNxLNHBXU1o/LYArhjz2P6gYxFpy
 3HsJhcd10hOUWX005cZj4kWDjmZFMb/2WfLKyTwG+XxrTIJxKidmYHZmg8qXG161W6
 fBxl0f7PqUerGPEKQKycdM6Qg35f7DrFFNKL7BqSX27uidtkBSQfSDu6vA2OKqw41G
 nsbH2Iey46ptQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_011654_655715_15952999 
X-CRM114-Status: GOOD (  27.81  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 08:59:10AM +0000, Jon Hunter wrote:
> =

> On 10/12/2018 08:49, Joseph Lo wrote:
> > Hi Jon,
> > =

> > Thanks for reviewing this series.
> > =

> > On 12/7/18 9:41 PM, Jon Hunter wrote:
> >>
> >> On 04/12/2018 09:25, Joseph Lo wrote:
> >>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>>
> >>> Add new properties to configure the DFLL PWM regulator support. Also
> >>> add an example and make the I2C clock only required when I2C support =
is
> >>> used.
> >>>
> >>> Cc: devicetree@vger.kernel.org
> >>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> >>> ---
> >>> =A0 .../bindings/clock/nvidia,tegra124-dfll.txt=A0=A0 | 73 ++++++++++=
++++++++-
> >>> =A0 1 file changed, 71 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>> b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>> index dff236f524a7..8c97600d2bad 100644
> >>> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> >>> @@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running
> >>> voltage controlled
> >>> =A0 oscillator connected to the CPU voltage rail (VDD_CPU), and a
> >>> closed loop
> >>> =A0 control module that will automatically adjust the VDD_CPU voltage=
 by
> >>> =A0 communicating with an off-chip PMIC either via an I2C bus or via
> >>> PWM signals.
> >>> -Currently only the I2C mode is supported by these bindings.
> >>> =A0 =A0 Required properties:
> >>> =A0 - compatible : should be "nvidia,tegra124-dfll"
> >>> @@ -45,10 +44,28 @@ Required properties for the control loop paramete=
rs:
> >>> =A0 Optional properties for the control loop parameters:
> >>> =A0 - nvidia,cg-scale: Boolean value, see the field
> >>> DFLL_PARAMS_CG_SCALE in the TRM.
> >>> =A0 +Optional properties for mode selection:
> >>> +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> >>> +
> >>> =A0 Required properties for I2C mode:
> >>> =A0 - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
> >>> =A0 -Example:
> >>> +Required properties for PWM mode:
> >>> +- nvidia,pwm-period: period of PWM square wave in microseconds.
> >>> +- nvidia,init-uv: Regulator voltage in micro volts when PWM control
> >>> is disabled.
> >>
> >> Maybe consider 'pwm-inactive-voltage-microvolt'.
> > Ah, I think I need to refine the description here. It should be
> > something like below.
> > =A0- nvidia,pwm-init-microvolt : Regulator voltage in micro volts when =
PWM
> > control is initialized
> > =

> > This is the initial voltage that when we just initialize the DFLL
> > hardware for PWM output. And before we switch the CPU clock from PLLX to
> > DFLL, we will enable DFLL hardware in closed loop mode which will aplly
> > the DVFS table that was calculated from CVB table.
> > =

> > The original description maybe make you think that it's the working
> > voltage when it's under open-loop mode. But it's not. Sorry.
> > =

> > When we working on open-loop mode which will switch to low voltage range
> > which also follows the DVFS table. Not this one.
> =

> OK, but I am still not sure what this voltage is. I mean that I
> understand it is the initial voltage, but how exactly do we define this
> number? Where does it come from, how is this determined?
> =


It is set by a resistive divider on the board iirc.

> >>
> >>> +- nvidia,align-offset-uv: Regulator voltage in micro volts when PWM
> >>> control is
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled and PWM output is lo=
w.
> >>
> >> Would this be considered the minimum pwm active voltage?
> > This would be used for minimum voltage for LUT table, which is the table
> > that PMIC can output. The real minimum voltage in PWM mode still depends
> > on the CVB table.
> > =

> > So maybe change this one to 'nvidia,pwm-offset-uv'.
> =

> So is this the min supported by the PMIC? Maybe the name should reflect
> that because the above name does not reflect this. Furthermore, if this
> is a min then maybe the name should use 'min' as opposed to 'offset'.
> for example, 'nvidia,pwm-pmic-min-microvolts'.
> =

> Does this need to be described in DT, can it not be queried from the PMIC?
> =


There is no interface to query anything from the OVR regulator.

Peter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
