Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:36:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2E121841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ks0HSKv7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kAiCBo4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2E121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uT9/k7IRz6BECswXxFdlytlKqvjotnuN1d+wkB+skPQ=; b=Ks0HSKv7DTc3g7
	c1eLVSvsQh/uzlri3y3LVAUfgTGnQIPPX0Q+8HdmTf7UZDRENc8mx7y8mpo6S9CFGcNZRKdm6FrY3
	S+OCgaFAcufbV0Vob6YFUR3HkqLfP/voVhIjmhzarRoZ2H7+2xo74G2jb5f6GK1JhxUNDvmRfjndu
	q5n9q1ZH5o5h8XLOEJZ4FB/UDkHBAWU3CaOPJQzN+BeI4yqz9OJmF1FUZTQYILx6QZyE2atMKjep3
	IQ4nEhEoyvjSrkam7GBsAkAjrGGRtSr8bf+SMvbSCUH7OQeuNiNH7TJms5Nj3eJpCH8VUwlgCIqN8
	HGp3Uxgkf5keZwuBLJiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGdW-0001ZY-GX; Sat, 09 Feb 2019 00:36:50 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGdS-0001Yo-T0; Sat, 09 Feb 2019 00:36:48 +0000
Received: by mail-ot1-x342.google.com with SMTP id w25so8844464otm.13;
 Fri, 08 Feb 2019 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XSyFFD1tXOyt7+5H9xdZxTpu5l3Skgu7KUaohJNSucA=;
 b=kAiCBo4uG16Tw8YgQTCoNeBgeKffRP1RYeGrFIcXXS9xQoU/MK0GItFB+PwTst/AYw
 z8CDLuwxn2YfBPU332A/12autb/ZlZcl1++2U5I5f9xIEzgbeptkopmWcI8Zr98xpjkE
 ADRR6DD6WNvQqQwzZx8Ti+Nrdm2qY3TSzt3aU8ArTKn/vuIPO7rynpWQYCi0vH/e85xF
 uj+oRN1PodmCi0X7GfZ2yB3CUR748uu1MJRbijkjgIuBGMVRRvSjZK+s/wA8bJZC29dw
 UEvMqXirJ8zOsHWbM4OKICwKdqHCWbAL4pSxcVcgGoyZXm3CfRF5vfjMRwpBE1iMrIso
 HPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XSyFFD1tXOyt7+5H9xdZxTpu5l3Skgu7KUaohJNSucA=;
 b=tWSxCeWtiyEefj41TKWs7bgBPdbVgkrG//bjBOzl3Xd+5TlFOcZfqzXExviAOzw5Uy
 IH5MVz/K1jvrfBfXZ3FZNabDNMjCcHlpHQwGi8hGIKW58S9UwrHij/fnCxeIWXotfERv
 iR/geE3pCl0tvPPVoFfXM62v7J5cJKsomEnGVmATBTE3CU6uCcje3CHXSureIh7xmGT7
 9kLdSz0c5KoU873FQR4gxOCHlLCZWOMWSRglHT7P2tF0p/CGQlwWuh6dMzQ3sB6S6die
 BIOkAlHo9FiTB1eLDZs7Cilb+GqEaBEKGgJizFvNjLQXL6sGgWtJItvUSFaqw+yvizXE
 eu4Q==
X-Gm-Message-State: AHQUAuY/tdmujIIrytSktYe3L+jf49qSt+KkvwD+NejSXFid/7aEdbHe
 YLOkFB4N8Bqxyi/arpTwQHgaNyAnvO6zsOJRhqk=
X-Google-Smtp-Source: AHgI3IbXu+EiU25KtcaqSaHn9gtbnvIAR3IbyX0cVi0mpy3HUlbb29LwfKW5wGNAB2E6mnoE6Yst139B5iK/s5eoanE=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr4543027otl.342.1549672605967; 
 Fri, 08 Feb 2019 16:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
 <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
 <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
 <CANAwSgRtBWzKiFLUV6twxv+TnvjLdHXv=U8+ppQ7=9uBBLEH+Q@mail.gmail.com>
In-Reply-To: <CANAwSgRtBWzKiFLUV6twxv+TnvjLdHXv=U8+ppQ7=9uBBLEH+Q@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 9 Feb 2019 01:36:35 +0100
Message-ID: <CAFBinCD_Pddu+pBEKwMS6467J5nxKF4T5-LxVo06nFvyUSLpew@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_163646_954602_8727E6AB 
X-CRM114-Status: GOOD (  26.46  )
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

Hi Anand,

On Thu, Feb 7, 2019 at 7:33 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Wed, 6 Feb 2019 at 16:58, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Tue, Feb 5, 2019 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> > > > my interpretationfor the Amlogic SoCs is:
> > > > - vusb_a and vusb_d are generated internally, not sure if there's an
> > > > external fixed regulator
> > > > - there is no phy-supply (the PHY itself is powered by clock-gating
> > > > using the CLKID_USB clock)
> > > > - usb0 VBUS is controlled by GPIOAO_5
> > > >
> > >
> > > But as per the device tree binding
> > >
> > > [0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> > > [1] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt
> > >
> > > its uses phy-supply to enable power to usb phy which seem to be correct option.
> > phy-bindings.txt states that "phy-supply" is a "Phandle to a regulator
> > that provides power to the PHY".
> > I have written the example in meson8b-usb2-phy.txt and I think it's
> > wrong (back when I wrote it I didn't know about the "vbus-supply"
> > property on the controller and I didn't know about the VBUS
> > constraints).
> >
> > I believe that the phy-supply property is intended for PHYs which need
> > an external power supply (for example because they are not embedded
> > into a SoC or if the SoC has separate voltage inputs for the PHY).
> > I'm not aware of any PHY supply voltage on the Amlogic SoCs (I believe
> > this is done internally within the SoC). instead they use clock gating
> > to power down the PHY.
> >
> > as far as I understand the VBUS signal it depends on the USB mode:
> > - host provides VBUS
> > - peripheral devices are powered using this voltage
> > - with OTG VBUS needs to be turned on or off depending on the current
> > mode (host or peripheral)
> > with the "phy-supply" property there's no way to manage the regulator
> > depending on the USB mode (host or peripheral), it will always be
> > "on".
> >
> >
> > Regards
> > Martin
>
> Thanks for the clarification.
> But this dose not work setting the usb1_phy to use vbus-supply.
>
>  &usb1_phy {
>         status = "okay";
> +       vbus-supply = <&usb_vbus>;
>  };
>
> I am attaching a small patch for testing.
> [0] usbvbus.patch
indeed, this is not working for me either.
I checked my old notes at [0] -> it works for me when setting
"vbus-supply" at the usb controller (not the PHY).

with the following snippet:
  &usb1 {
    status = "okay";
    vbus-supply = <&usb_vbus>;
  };
I get:
# cat /sys/kernel/debug/regulator/regulator_summary | grep -i usb
   c90c0000.usb                  1                                 0mA
    0mV     0mV
   c90c0000.usb                  1                                 0mA
    0mV     0mV
   USB_VBUS                      1    1      0 unknown  5000mV     0mA
 5000mV  5000mV
      c90c0000.usb               1                                 0mA
    0mV     0mV

can you please try this on your board as well?

> Here is the summary of the above patch.
>
> 1. hot-plugins of usb device is not working.
> 2. only cold/warm boot let the device come up.
> 3. not power is supplied to the usb ports.
> 4. no power module is registered with the regulator summary.
with "vbus-supply" moved to the usb1 node I get the following result:
1. same: hot-plugins of usb device is not working
2. different: a reboot doesn't make devices come up
3. same: no power is supplied to the USB ports (in my case this causes
#2, but it's not clear why there's no power...)
4. different: the regulator is registered with the USB controller in debugfs


Regards
Martin


[0] https://lkml.org/lkml/2019/1/18/960

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
