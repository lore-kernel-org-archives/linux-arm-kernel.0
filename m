Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7DB214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Af8vFlLa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC87115X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7DB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LbTVGC46UL9c5vn6zkdSypgqcJYY8j0kcn9M2gDWibE=; b=Af8vFlLaepNquZ
	GZzwLBQ5LMbcZnairOHm+m7dNH7TSwur3H3FNB3EXlu+dioITMsetqHu9aP/rABTgrdx3MBR0ORnJ
	EWke4pFKuZBL0kMSaOQ0LFIXP/lb52F/qyFU5vY2NGsavijzhQ81GnvkOOfwFK9v6AYifW2YR2s40
	y0VeOSSPC5nworgsh/n9rcwneWssc8+6QZ6V8Hb4w504ZsazT7l+im8pbONutdaEYid99S9KtWn9c
	91AW2pvQLJMlbZau9pBadqsTexyWs5Fc+M6/YOZ5RuDEg/to84DMKrZ+GowGH6P7E3ZGdkjiy8qj8
	JxH35rXDBZgelAELnTiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWrD-0006an-HA; Sat, 09 Feb 2019 17:56:03 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWr9-0006aL-7P; Sat, 09 Feb 2019 17:56:01 +0000
Received: by mail-ot1-x334.google.com with SMTP id i20so11287358otl.0;
 Sat, 09 Feb 2019 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5wXDbDF+rSaG8F0j/SLCia3zuSR/ZN9edFM70vnb2ZM=;
 b=AC87115XbfpbZSwoG1lZdmRzHjSl24TmUB+OJB8XiQmMnfZh98DN0CujBXWbVjl3QM
 1X1eYlET0+UjNdtdLINrJrJKhGNBZ24k37VYXKuX0tJJ3xWfH/Z0qKCNuEll1s766IeP
 cLlpo6cwP08eHTZ+P/4IfZVrIIDtOjBgbUVVcVOKIhGsy/PiW74tXo2uKUU/kN33kO5w
 6h/iiGZvlWkX78YTC9cg+ec60OD7pjF4iwShQdYwbApzfhQBhXBM/KdXiaPl+L2ke0at
 /YJ6IydPsu7BqjTx9UjE8hKSoDEq9ZAfo4L0VrwTw7F1OxP52qcoNK5KrFqLAWpo7eDE
 +brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5wXDbDF+rSaG8F0j/SLCia3zuSR/ZN9edFM70vnb2ZM=;
 b=m9BbSPWgeeFci+Xk7QKZANqi5vt+PwCltZlFIGrw9cKucVsPUnGLKXWT59on23t8r+
 YZTytixHbMBi4jae3NamkUTHQ4xjEQGStAbXFwqWfLzq2iInZ17jzNJSIwAFevtQAHmV
 y0hOinnJR1fN5GIQAa4zF4iBUJB9/B4Dd+N/7bs1PrasJvwICXoj3nL/iz6KGiO62lO4
 ODLZ1sp9h/LEm6nS8c+IlyWqXs229pDA/12ssI09n3vXxjV9f/hIxOW/g9ZZAyNs6g31
 Zs+PeT7PjPpuVQKnWm0IbK3n9r08FCQoWUgHoG2+6h+8AWRzDGcCajYLVhdyEN5ML1b/
 XaNw==
X-Gm-Message-State: AHQUAuaXerKNZAM21Ra3kMX5oqemjiNTi91pqsKds88zDfoIDAFPmK9C
 rWIt/Ns6A4SfnCZ3g+qqwJSsnCprev9Vy/KgXH8ryA==
X-Google-Smtp-Source: AHgI3IbtV2vntu3pVrM0baEn7yhZA/wqZCEaSt8mVnGgiMLt1bVjuHLZ6i4/gdoSDuTTt7vqk+i4hu81GfE9u6b072k=
X-Received: by 2002:a9d:3424:: with SMTP id v33mr18580201otb.167.1549734958211; 
 Sat, 09 Feb 2019 09:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
 <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
 <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
 <CANAwSgRtBWzKiFLUV6twxv+TnvjLdHXv=U8+ppQ7=9uBBLEH+Q@mail.gmail.com>
 <CAFBinCD_Pddu+pBEKwMS6467J5nxKF4T5-LxVo06nFvyUSLpew@mail.gmail.com>
In-Reply-To: <CAFBinCD_Pddu+pBEKwMS6467J5nxKF4T5-LxVo06nFvyUSLpew@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 9 Feb 2019 23:25:47 +0530
Message-ID: <CANAwSgSQRwF+_VR1jJFg=Q9wSdanEH0GmnFaeegt=hRMXiHX3Q@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_095559_277149_F2E0BFAF 
X-CRM114-Status: GOOD (  29.37  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Sat, 9 Feb 2019 at 06:06, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Feb 7, 2019 at 7:33 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin,
> >
> > On Wed, 6 Feb 2019 at 16:58, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Anand,
> > >
> > > On Tue, Feb 5, 2019 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > [...]
> > > > > my interpretationfor the Amlogic SoCs is:
> > > > > - vusb_a and vusb_d are generated internally, not sure if there's an
> > > > > external fixed regulator
> > > > > - there is no phy-supply (the PHY itself is powered by clock-gating
> > > > > using the CLKID_USB clock)
> > > > > - usb0 VBUS is controlled by GPIOAO_5
> > > > >
> > > >
> > > > But as per the device tree binding
> > > >
> > > > [0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> > > > [1] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt
> > > >
> > > > its uses phy-supply to enable power to usb phy which seem to be correct option.
> > > phy-bindings.txt states that "phy-supply" is a "Phandle to a regulator
> > > that provides power to the PHY".
> > > I have written the example in meson8b-usb2-phy.txt and I think it's
> > > wrong (back when I wrote it I didn't know about the "vbus-supply"
> > > property on the controller and I didn't know about the VBUS
> > > constraints).
> > >
> > > I believe that the phy-supply property is intended for PHYs which need
> > > an external power supply (for example because they are not embedded
> > > into a SoC or if the SoC has separate voltage inputs for the PHY).
> > > I'm not aware of any PHY supply voltage on the Amlogic SoCs (I believe
> > > this is done internally within the SoC). instead they use clock gating
> > > to power down the PHY.
> > >
> > > as far as I understand the VBUS signal it depends on the USB mode:
> > > - host provides VBUS
> > > - peripheral devices are powered using this voltage
> > > - with OTG VBUS needs to be turned on or off depending on the current
> > > mode (host or peripheral)
> > > with the "phy-supply" property there's no way to manage the regulator
> > > depending on the USB mode (host or peripheral), it will always be
> > > "on".
> > >
> > >
> > > Regards
> > > Martin
> >
> > Thanks for the clarification.
> > But this dose not work setting the usb1_phy to use vbus-supply.
> >
> >  &usb1_phy {
> >         status = "okay";
> > +       vbus-supply = <&usb_vbus>;
> >  };
> >
> > I am attaching a small patch for testing.
> > [0] usbvbus.patch
> indeed, this is not working for me either.
> I checked my old notes at [0] -> it works for me when setting
> "vbus-supply" at the usb controller (not the PHY).
>
> with the following snippet:
>   &usb1 {
>     status = "okay";
>     vbus-supply = <&usb_vbus>;
>   };
> I get:
> # cat /sys/kernel/debug/regulator/regulator_summary | grep -i usb
>    c90c0000.usb                  1                                 0mA
>     0mV     0mV
>    c90c0000.usb                  1                                 0mA
>     0mV     0mV
>    USB_VBUS                      1    1      0 unknown  5000mV     0mA
>  5000mV  5000mV
>       c90c0000.usb               1                                 0mA
>     0mV     0mV
>
> can you please try this on your board as well?
>
> > Here is the summary of the above patch.
> >
> > 1. hot-plugins of usb device is not working.
> > 2. only cold/warm boot let the device come up.
> > 3. not power is supplied to the usb ports.
> > 4. no power module is registered with the regulator summary.
> with "vbus-supply" moved to the usb1 node I get the following result:
> 1. same: hot-plugins of usb device is not working
> 2. different: a reboot doesn't make devices come up
> 3. same: no power is supplied to the USB ports (in my case this causes
> #2, but it's not clear why there's no power...)
> 4. different: the regulator is registered with the USB controller in debugfs
>
Here the the logs after I applied the above changes

[1] https://pastebin.com/rVa8gxNG

with below message.

[   14.793044] usb 1-1.3: reset high-speed USB device number 3 using dwc2
[   18.253011] usb 1-1.3: reset high-speed USB device number 3 using dwc2
[   21.643017] usb 1-1.3: reset high-speed USB device number 3 using dwc2
[   25.033012] usb 1-1.3: reset high-speed USB device number 3 using dwc2
[   28.412995] usb 1-1.3: reset high-speed USB device number 3 using dwc2

So this is not correct solution to the problem.

>
> Regards
> Martin
>
>
> [0] https://lkml.org/lkml/2019/1/18/960

Best Regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
