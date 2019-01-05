Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736B321874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ahU9ANWf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4Wz0WHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736B321874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSD1hIWCHnuj+1yn/z8P4PNfFjnUmob6wmFtqCbZm4Y=; b=ahU9ANWfNTdNoD
	o4Lq0zfXsWTmcQG82G8qlGt9UUdpSNZIjGHRrmsyZEJcZbyU0nvpKu3kbPqk16+xrfmHBb0XhtRpO
	0+2ALz/x5k4/5Qds2H8KzSigl6aPn3hyxgyP+RyAiUXsS0rpsR7n1un4dLO2hSugTYvsNl/adORb2
	j0A9T5YvYpETmDbBGiYWDEBob7DlddkYWq3vtu47Ger9OVMQT8kQMgkeQ3oN8GWWwQv1AHsLt5T++
	IoAc5AxSDoDEUEXxxds31z7KPLAaFW8z1ekll/YDXzHcGDN6WfWT/dDkmKRQU34wN1O5+2GVgYRlS
	6ihgw2+bqIzwHFmk3dpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfeeU-0002pn-A2; Sat, 05 Jan 2019 05:37:42 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfeeQ-0002or-AJ
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 05:37:40 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so2815131wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 21:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tcixzltADjssKiWqoqYobPa1vyHbdsw3OxwbfCgPu3M=;
 b=h4Wz0WHykaKwJNLvADVeZ4OYwHnpxtd1NyN79BJ8q4RilkASoWHpaGIBMfZr1DpCnc
 eCRIiEsrdhlromC5O+4d6cbqImYQx/UtliHyteZW18mRRZBGjoIrOB2gN+9pQOndlVIk
 ekCsQH0Lm9jmlvsoAWFbUTQlZtzJ7OIfpw2dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tcixzltADjssKiWqoqYobPa1vyHbdsw3OxwbfCgPu3M=;
 b=hglCTsuOxRHaHXAKYA1I+PT0lHQyd9aEaLRNxVd552w1IZkZ69OsMc2brrIz6xZVEq
 AViV/WOl27buRtZDrhWWQOhHcPkLE4OTV6aqDg2csdQPwOlnyqQ+0fhpui6Iu96vxqQ9
 xBEfZAuEWN7NT2ZpwBBoJrmZb7U0DZn1Pnz9akD2oDl2KsAvhI06b2Prhc/KxnNl9oRl
 UXfUE72NEOrfz+tH2TR7awRLqbPjQWrXijc+i0ww3+oepsQ8c68pKv+w+hbFDMdT+o21
 VCuPoJM6AiIkme5BdPlgR/AjFCcIQKixW6KZ7l0VKqsuuDNPBGajRC4pzig3LtaKIIUk
 fS5w==
X-Gm-Message-State: AJcUukf6qrG+DN+UgVw1BYh6oDJ6ZrdiX4bHMbrit83njccS61qib4jp
 LlRlaVaOeSCtLC5qu+uxIXLOS9to8F8Z6JA0P9Yhow==
X-Google-Smtp-Source: ALg8bN5BKSchTBYUATMxJhIqATdi2OwkbolG2AhmChMtnqCv71kIiiC0yvKIDK55hzFYVdilhqIn5+V5b86BVY6/4No=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr1482830wme.64.1546666655915; 
 Fri, 04 Jan 2019 21:37:35 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
 <20190105034904.GD2477@Mani-XPS-13-9360>
 <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
In-Reply-To: <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 4 Jan 2019 21:37:23 -0800
Message-ID: <CALAqxLUtCtEF1bck5WcfHFugrjS5b73MOMVz+9CiML0oG9ZzGA@mail.gmail.com>
Subject: Re: [PATCH 6/8 v2] arm64: dts: hi3660: Add dma to uart nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_213738_390891_426A54CE 
X-CRM114-Status: GOOD (  20.48  )
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
 <devicetree@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 8:34 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Fri, Jan 4, 2019 at 7:49 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hi John,
> >
> > On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> > > Try to add DMA support to the uart nodes following
> > > the assignments made in the dts from the victoria vendor kernel
> > > here:
> > > https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> > >
> > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > Cc: Ryan Grachek <ryan@edited.us>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: Wei Xu <xuwei5@hisilicon.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > index 20ae40d..aaa2b04 100644
> > > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > @@ -466,6 +466,8 @@
> > >                       compatible = "arm,pl011", "arm,primecell";
> > >                       reg = <0x0 0xfdf02000 0x0 0x1000>;
> > >                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > > +                     dma-names = "rx", "tx";
> > > +                     dmas =  <&dma0 0 &dma0 1>;
> >
> > Usage of DMA channel 0 contradicts with the description provided in
> > patch, "dma: k3dma: Add support to dma_avail_chan".
>
> Hrm. Good point.  I'll double check w/ Dr Su on this, I'm not sure if
> that inconsistency is due to the the vendor kernel (where these came
> from) having different reserved channels or just something overlooked
> if the uart0 is not actually being used (as we find on hikey960 as
> well).

Hrm. So it seems like uart0 is mapped to the dma0 chan0, but the
device specific files in the vendor tree overwite the dma values:
                serial0: uart@fdf02000 {
                        pinctrl-names = "default", "idle";
                        pinctrl-0 = <&gpio053_pmx_func
&gpio054_pmx_func &gpio053_cfg_func &gpio054_cfg_func>;
                        pinctrl-1 = <&gpio053_pmx_idle
&gpio054_pmx_idle &gpio053_cfg_idle &gpio054_cfg_idle>;
                        dma-names = "", "";
                        dmas = <>;
                        clock-rate = <0 19200000>;
                        status = "ok";
                };

But I went ahead and pulled the dma values on uart0.

thaks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
