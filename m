Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06272147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EjX7eQZz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc685sSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06272147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SpR88yGzWj27rrp3p1n91nSB/0zGR7l9TcVWwQ5cwrQ=; b=EjX7eQZzQJjA7YXWTc25H8dgJ
	JX8ZrUTH+gz2Y2dJVleKQZII7MCwz+Vam8oGZ4JwNW0oys9diWGXYSr8jN5B5SVbk8Mv/RWW+c2B3
	1da/VM9qUQ3wAPcI3TzQqbRMnXTQJzjH8UUDwf8e6LwycnQ1xR4zoq7d10GOWs4OeJ/nnHT8ClmDd
	sYYq/qGe2iyC1f1yh3EYrMji/z4wrrgp9xcFCZxzUallZC724QCxissbFIvPWXtOZdWbuNgd7s/gE
	T0sNt4tqiC22vdP2K/OkLcBGiBg4vAztQPaYWAdc3Svs5h/Jy7o94os9ofxpbvu+3bokAhJR+/MSR
	IOTAtthyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grdFG-0000vR-Fs; Thu, 07 Feb 2019 06:33:10 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grdFC-0000uj-HL; Thu, 07 Feb 2019 06:33:08 +0000
Received: by mail-ot1-x341.google.com with SMTP id t5so16548521otk.1;
 Wed, 06 Feb 2019 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=beTA1+Ni5K2DwY8rS6WrG30pXb5m1gpjpD8E2sNsXRQ=;
 b=lc685sSnrmkS/mr3ZZ7+q5Qkb38Slz2FFG9te46CoicfnVXKFhhxSA8Yo1Dme9fs6r
 g7mzc7R2MVszRBFEDa/rmRzej0wviz/KgqJve+0SnaJtk8bX8N6s6VXqFDM2/VlpimBv
 TGP1hTtO95fgUPe8+pasJNf9oRhE3L3w2KDC8V4tH8Y2IAT0A0YfLFGVIPt9TjOgI6al
 S/4c1pf97QbsI1jidLfiTNXJXHurW1j9rUBqtbyXAW68crGbw34Ua2ZOOpeXETrs88Fl
 cXW2lJSpLiZZA6l4f5MbnB1+q/ZX9Q+4hTyAeKYtxWFxmWE7OhYsuDk+clVmUsTTfuW6
 v6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=beTA1+Ni5K2DwY8rS6WrG30pXb5m1gpjpD8E2sNsXRQ=;
 b=jsUUb9wLIIu0kVi2CIm5xMvFBnL8FG/bWYPKF/M0BiIbTR6CRCnNjGapUTtenDfaZO
 /CwMH6Z9cGbLphDrnaqUeCqzvDr+LOvfhZZ4aACoD5T9jNoy5XermiHpfeBdtyl3PZK/
 +bGchuVEXdUF485Cq4ypuSsy4uF/Hbfcyzobw1f2Ww6UKjOsEM6xeulzSB94vwTpIAB3
 hY/ljnHUWOx+r8lgdAilqQ4FW7NolcJG56Lln+/27vtT2+pipNszjzQ18+BkwN/bhqcl
 xvZXdr0Bu3u39vixXzJFDgt7vyOWPV6T02UnnQ7leS0dRQ4oai3Mo2Zce/5v2TrhqcOC
 UTGg==
X-Gm-Message-State: AHQUAua395iqJHmy4/JMcQaJsEHQN0EdKYWh5bKf906a1G10cYmkszf3
 0knu4brEEjdMJruvxWY286oqJnmbC3y0+D6b7oo=
X-Google-Smtp-Source: AHgI3IYgqjHgQE7DDLY4k7qcIntCFya7m9CvA9N3i4eocEg+XN3FbnQA8z4wdHaygHH9bbmukkDVs48lGSAEpwz/CfA=
X-Received: by 2002:a54:4113:: with SMTP id l19mr1762913oic.142.1549521183769; 
 Wed, 06 Feb 2019 22:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-3-linux.amoon@gmail.com>
 <CAFBinCAdf0rtt-7tON_LRNH_cpvGJXX3LX8g-i4xsC3wahZSVA@mail.gmail.com>
 <CANAwSgQ4=Vn6RM4Kpd20UWkQNW81=mfg-qB0G73dsRem3qwjcA@mail.gmail.com>
 <CAFBinCB=3kmuFb_xXzhW+m8dTasVrCHQp2wti+=5UjrAHk5TTg@mail.gmail.com>
 <CANAwSgQnMkXECkCVjFKwNKB+2JoiPtVPQbateppmtgfPYCutZg@mail.gmail.com>
 <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
In-Reply-To: <CAFBinCCFoBkbf-HvEoMk7mTYTBV27nJ9TF1X-DrLuHR9qDVDSA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 7 Feb 2019 12:02:50 +0530
Message-ID: <CANAwSgRtBWzKiFLUV6twxv+TnvjLdHXv=U8+ppQ7=9uBBLEH+Q@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: multipart/mixed; boundary="000000000000bb3a4b05814803ef"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_223306_604291_42960C1C 
X-CRM114-Status: GOOD (  24.79  )
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--000000000000bb3a4b05814803ef
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

On Wed, 6 Feb 2019 at 16:58, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Feb 5, 2019 at 8:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > my interpretationfor the Amlogic SoCs is:
> > > - vusb_a and vusb_d are generated internally, not sure if there's an
> > > external fixed regulator
> > > - there is no phy-supply (the PHY itself is powered by clock-gating
> > > using the CLKID_USB clock)
> > > - usb0 VBUS is controlled by GPIOAO_5
> > >
> >
> > But as per the device tree binding
> >
> > [0] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> > [1] https://elixir.bootlin.com/linux/v5.0-rc5/source/Documentation/devicetree/bindings/phy/phy-bindings.txt
> >
> > its uses phy-supply to enable power to usb phy which seem to be correct option.
> phy-bindings.txt states that "phy-supply" is a "Phandle to a regulator
> that provides power to the PHY".
> I have written the example in meson8b-usb2-phy.txt and I think it's
> wrong (back when I wrote it I didn't know about the "vbus-supply"
> property on the controller and I didn't know about the VBUS
> constraints).
>
> I believe that the phy-supply property is intended for PHYs which need
> an external power supply (for example because they are not embedded
> into a SoC or if the SoC has separate voltage inputs for the PHY).
> I'm not aware of any PHY supply voltage on the Amlogic SoCs (I believe
> this is done internally within the SoC). instead they use clock gating
> to power down the PHY.
>
> as far as I understand the VBUS signal it depends on the USB mode:
> - host provides VBUS
> - peripheral devices are powered using this voltage
> - with OTG VBUS needs to be turned on or off depending on the current
> mode (host or peripheral)
> with the "phy-supply" property there's no way to manage the regulator
> depending on the USB mode (host or peripheral), it will always be
> "on".
>
>
> Regards
> Martin

Thanks for the clarification.
But this dose not work setting the usb1_phy to use vbus-supply.

 &usb1_phy {
        status = "okay";
+       vbus-supply = <&usb_vbus>;
 };

I am attaching a small patch for testing.
[0] usbvbus.patch

Here is the summary of the above patch.

1. hot-plugins of usb device is not working.
2. only cold/warm boot let the device come up.
3. not power is supplied to the usb ports.
4. no power module is registered with the regulator summary.

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage
current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  4    3      0 unknown     0mV
0mA     0mV     0mV
    c90c0000.usb                  1
0mA     0mV     0mV
    c90c0000.usb                  1
0mA     0mV     0mV
    VCCK                          1    1      0 unknown   860mV
0mA   860mV  1140mV
       cpu0                       0
0mA   860mV   860mV
 P5V0                             2    4      0 unknown  5000mV
0mA  5000mV  5000mV
    VCC1V8                        1    1      0 unknown  1800mV
0mA  1800mV  1800mV
       c1108680.adc               1
0mA     0mV     0mV
    VCC3V3                        1    2      0 unknown  3300mV
0mA  3300mV  3300mV
       VDD_RTC                    0    0      0 unknown   900mV
0mA   900mV   900mV
       TFLASH_VDD                 1    1      0 unknown  3300mV
0mA  3300mV  3300mV
          c1108c20.mmc:slot@1     1
0mA  3300mV  3400mV
    DDR_VDDC                      0    0      0 unknown  1500mV
0mA  1500mV  1500mV
    USB_VBUS                      0    0      0 unknown  5000mV
0mA  5000mV  5000mV
 TF_IO                            0    1      0 unknown  3300mV
0mA  1800mV  3300mV
    c1108c20.mmc:slot@1           0
0mA     0mV     0mV

*So from my side phy-supply is the correct option.*

Best Regards
-Anand

--000000000000bb3a4b05814803ef
Content-Type: application/octet-stream; name="usbvbus.patch"
Content-Disposition: attachment; filename="usbvbus.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jru8vqpf0>
X-Attachment-Id: f_jru8vqpf0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lkYzEuZHRzIGIvYXJj
aC9hcm0vYm9vdC9kdHMvbWVzb244Yi1vZHJvaWRjMS5kdHMKaW5kZXggNTg2NjlhYmRhMjU5Li5h
MDRmNTYzM2FkY2YgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lk
YzEuZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lkYzEuZHRzCkBAIC04
Myw2ICs4MywyMCBAQAogCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKIAl9
OwogCisJdXNiX3ZidXM6IHJlZ3VsYXRvci11c2ItdmJ1cyB7CisJCWNvbXBhdGlibGUgPSAicmVn
dWxhdG9yLWZpeGVkIjsKKworCQlyZWd1bGF0b3ItbmFtZSA9ICJVU0JfVkJVUyI7CisJCXJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+OworCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9s
dCA9IDw1MDAwMDAwPjsKKwkJLyoKKwkJICogc2lnbmFsIG5hbWUgZnJvbSBzY2hlbWF0aWNzOiBQ
V1JFTgorCQkgKi8KKwkJZ3BpbyA9IDwmZ3Bpb19hbyBHUElPQU9fNSBHUElPX0FDVElWRV9ISUdI
PjsKKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOworCQl2aW4tc3VwcGx5ID0gPCZwNXYwPjsKKwl9Owor
CiAJdGZsYXNoX3ZkZDogcmVndWxhdG9yLXRmbGFzaF92ZGQgewogCQkvKgogCQkgKiBzaWduYWwg
bmFtZSBmcm9tIHNjaGVtYXRpY3M6IFRGTEFTSF9WRERfRU4KQEAgLTI5Nyw2ICszMTEsNyBAQAog
CiAmdXNiMV9waHkgewogCXN0YXR1cyA9ICJva2F5IjsKKwl2YnVzLXN1cHBseSA9IDwmdXNiX3Zi
dXM+OwogfTsKIAogJnVzYjEgewo=
--000000000000bb3a4b05814803ef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000bb3a4b05814803ef--

