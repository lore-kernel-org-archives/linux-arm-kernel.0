Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2CBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:12:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FDB2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DKpTVTGa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMsRq722"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FDB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Qg+7SwIIwx3M4W6Bpz2hAqEsC/SeendcmGglppuTsg=; b=DKpTVTGaRStsa4
	39083mDcR/EDYRJdfRyl6xBlCdmlM0L/PkdV2BAHG0m1+kLe7ALGn7YG20Otih58UF6pjXtbCmfpS
	af8Q8XFnk9iXNZchUm0TBOwb4sf8x22WmfRRH74nulpbMWINaNaMcdM3btFiEnD4Ig0zvab/Tkbmj
	xZjaAEPM2hIZDRu2lW44p6YVYudr2F8fy5MbQy7q1oUmhn/lrvmjrTBZJIr8UP2DObFp+3Pc0+KH4
	kekYiSACWb+U7AC4S45G2T1YWGllVcp0aLuDIgctY0XufJNa/wpupG7pT45VJcKxZS49KfFcTkaDI
	jwcm1AtvOGFSUaUTIf2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUk5T-0003gc-K4; Thu, 06 Dec 2018 03:12:27 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUk5Q-0003ft-ON
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:12:26 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so20769467otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XmTNi32rN9pRyRU2vCHXFXjQ81AuBxzem2x3A9alD6Q=;
 b=hMsRq722pT6la2BjKDBF879r8WpamVWOMLculSpJOwj102dHWt/k0qHapbR8bcNZCg
 3vMv2bsSENTiQjFUrQhaBxFzmFv7uvBRo7lQXV+t4gQYkXR2JLgbE1/Hxv28N0rw72E3
 o0mKVgZpC3K7vLHQq9wmjpbY7CUECI+IM6PbWu1q3oIZ283+2QyWv4vXDTjsKgLevxuD
 0vUOfHhjZUTsxZhjyDPPLbCUbMMRGj3Ni97vOnIt0GOyw+bjAmUxXsY5Bw+CwZ7Ycy02
 ho1IhRqYYl867d/ji9SvO24wZXF+/KWkaWITToO0/L+sk3KZvpUXWP1wTU2r/twEHoOn
 Ee3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XmTNi32rN9pRyRU2vCHXFXjQ81AuBxzem2x3A9alD6Q=;
 b=CS5fSj0kq4tHuc8ykTlyJdv9Hc6I/6J+Y6yBeCoRw7SKc/fP3YACPYgEe7R2BbpZkG
 YnhS/MiCdKnZHqlWqRGat923Z67vr+mutNgym/PjBacBHIB/M9Y/PsaIDXMbf8XeeFYS
 q/k7JdM+MbzCax7Mxb+K7hXNGHm0I6jH0IMPpe1BnKJJDNGDq7zZMH7+o0J0icM2O6WL
 y44pCSFHHc6WcXxerMgu2DtEE1fmQppcvJO3Y1yiTnPY0TPbkJ+JPv+oIrM3S90ib30E
 b/yrcSunDS1M/7Nii25nNCG11GAGJredsibDbQ2tnwDNvIm4efqaqsDI24oaLXOzhyd8
 56ug==
X-Gm-Message-State: AA+aEWaRsbrwvv/17lT+CC2+z7YjyxRROH1BnTxjoDw/5W//vUXYnx35
 n4dY8jBHZ4c5qbAv2Z4txddc9kOPIJAV9dljgp4=
X-Google-Smtp-Source: AFSGD/VTKMNB149I5gCjAOtC5SNApDeyyxvqTkDGG910KrEPGjssz/lpez9REIv98OHPNlMYz6OfkrGUBOIP1+ZLg2o=
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr17522835otn.335.1544065932561; 
 Wed, 05 Dec 2018 19:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com>
 <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
 <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
In-Reply-To: <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 6 Dec 2018 08:42:00 +0530
Message-ID: <CANAwSgQPcfAjyZEXfkWc6E4+N_k4nC3EPs96BpFkaTuQQ3FC6Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_191224_837523_0E9A1801 
X-CRM114-Status: GOOD (  34.67  )
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
 devicetree <devicetree@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On Wed, 5 Dec 2018 at 21:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 5 Dec 2018 at 17:11, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Thanks for your review.
> > .
> > On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > > during system suspend and also support changing the regulator operating
> > > > mode during runtime and when the system enter sleep mode.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > Tested on Odroid U3+
> > > > ---
> > > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 2caa3132f34e..837713a2ec3b 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -285,6 +285,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > >
> > > Driver does not support suspend_enable so this will be noop. We could
> > > add this for DT-correctness (and full description of HW) but then I
> > > need explanation why this regulator has to stay on during suspend.
> > >
> >
> > Well I tried to study the suspend/resume feature from
> > *arch/arm/boot/dts/exynos4412-midas.dtsi*
> > and them I tried to apply the same with this on Odroid-U3 boards and
> > test these changes.
>
> Midas DTSI clearly has bugs then.
>
> >
> > > >                         };
> > > >
> > > >                         ldo3_reg: LDO3 {
> > > > @@ -292,6 +295,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > The same but with suspend_disable.
> > >
> > > I am not saying that these are wrong but I would be happy to see
> > > explanations why you chosen these particular properties.
> > >
> >
> > Well I was not aware on the regulator-always-on cannot be set to off
> > in suspend mode.
> > Will drop this in the future patch where regulator-always-on; is set.
> >
> > > >                         };
> > > >
> > > >                         ldo4_reg: LDO4 {
> > > > @@ -299,6 +305,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo5_reg: LDO5 {
> > > > @@ -307,6 +316,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo6_reg: LDO6 {
> > > > @@ -314,6 +326,9 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo7_reg: LDO7 {
> > > > @@ -321,18 +336,27 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo8_reg: LDO8 {
> > > >                                 regulator-name = "VDD10_HDMI_1.0V";
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo10_reg: LDO10 {
> > > >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo11_reg: LDO11 {
> > > > @@ -340,6 +364,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo12_reg: LDO12 {
> > > > @@ -348,6 +375,9 @@
> > > >                                 regulator-max-microvolt = <3300000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo13_reg: LDO13 {
> > > > @@ -356,6 +386,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo14_reg: LDO14 {
> > > > @@ -364,6 +397,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo15_reg: LDO15 {
> > > > @@ -372,6 +408,9 @@
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo16_reg: LDO16 {
> > > > @@ -380,6 +419,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo20_reg: LDO20 {
> > > > @@ -387,6 +429,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo21_reg: LDO21 {
> > > > @@ -394,6 +439,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > >
> > > That's unusual setting... enabled in suspend but not necessarily
> > > during work (no always-on).
> > >
> >
> > I kept the regulator required for emmc/sd card in
> > regulator-on-in-suspend in suspend mode.
> >
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo22_reg: LDO22 {
> > > > @@ -411,6 +459,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck1_reg: BUCK1 {
> > > > @@ -419,6 +470,9 @@
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > This is seriously wrong so I have doubts whether you tested the
> > > changes or you know what is happening with them. If you turn off
> > > memory bus regulator off, how the memory will work in
> > > Suspend-to-Memory mode?
> > >
> >
> > Well I did not find any issue in my testing but I might be wrong.
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
>
> It worked fine because regulator-off-in-suspend is noop for buck1 but
> it is clearly wrong from logical point of view. Do you think that
> memory should be off in Suspend to RAM?
>
My bad setting this for buck setting I will drop this in the future patch.
> > > >                         };
> > > >
> > > >                         buck2_reg: BUCK2 {
> > > > @@ -427,6 +481,9 @@
> > > >                                 regulator-max-microvolt = <1350000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck3_reg: BUCK3 {
> > > > @@ -435,6 +492,9 @@
> > > >                                 regulator-max-microvolt = <1050000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > >
> > > Looks suspicious as well.
> >
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
> >
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> > Well I have tested this patch as following
> > with only one issue, before enable suspend number of On-line cpu is 4
> > after resume number of On-line cpu is 1.
>
> If before your change number of resumed CPUs was 4, then you
> apparently break some things.
>
> Best regards,
> Krzysztof

Ok I will double check that I do not break any feature.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
