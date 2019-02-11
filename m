Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394E5222B9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dox30vuC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5Ep3Fan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E5222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oiKozLcZR22UWUODThGSmayFapgZqd0iGlxbzv0l0lo=; b=dox30vuCiei9zl
	RFCWVavkJNLzQ3rlyAx4oWQoVPpGITF0VU6bOeI/hX3KJqZ32X9ldeJAQAKfoB8v6pzKFXpkSmgcr
	vyMmK8xyG61NKkCX3/wUlSJDj1h9HE/3+9gSYbNuLJLN4jLiGlDHlJtiijyn0ru32HE5OXpyziiuk
	VV2SH+dFudiTSTlEC9TR2v3gGJNoIpa8HHWvWKO0PKFK/uvF2Frept32xBPtspfuRyrsxnMrSwWwU
	ymNU83lcF6hU0gXQsoVYVE7i7dZ3Ar1aP/meV4XlE12Z2bTCaDFD5veTAmyBIQKnCOMnzuHdYBI4o
	VQoIxBrOWEXrReV/6EjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDCs-00044h-F7; Mon, 11 Feb 2019 15:09:14 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDCp-000446-3O; Mon, 11 Feb 2019 15:09:12 +0000
Received: by mail-ot1-x32f.google.com with SMTP id u16so17948408otk.8;
 Mon, 11 Feb 2019 07:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hjKCVZ/bmZGTdwmuQtnAdZRdYCaqe6ccuR6GBolul7w=;
 b=e5Ep3FansPOAsgIaCOmRCbFrWWk7rxtXm9UXtEwj6YUkmty+RYm6R3wmmXFezLitLt
 wj5t9JV/T79tJmF84OHMDOtmwDHbvNh+EhN47eoTOYnV1+Cwv/MAFLt70Fj51jwEZLUW
 nVHLpIrj+e2mvPQgnxLFHCjZ1HPtVWlR5R8Fnro03IsfaBBNVbOUSeCO57AyWGg95PUX
 DcQhknbgp27sq+VwvB0vT3GrWmL88Oa29tZ6vpxkrW5+CKLXpc345Pf5jbLji5e6VKHM
 tmDofEp+P/xoyMVdAJm+EMynzp5dNMZmhxaUlDh5kdLy/UxxNlVCw2vMed+ejTSg/DUj
 J7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hjKCVZ/bmZGTdwmuQtnAdZRdYCaqe6ccuR6GBolul7w=;
 b=Dj7h7BSrgdPrD7B/eRJt4ydXgq2rQpYUOFhMZNIJawkoLJoV5aPiZaiOej4KHksJZI
 OP/AcjXwVXV5Hpe8d8agMdwG/Wq/xKbIvaFED5vDShygnr83LtVTve0Mkn2f89fFC58P
 FyJwXY04Y23EuagJejTQ6sNYRX1yNmmMreNLf5GsEvJe5F8LA5zQUCSzBLgwscaWn+rC
 ayJyd7n6Oegg3NvjWYTd5kDZ92LjvdttOa8gyaDO5nl6k2znfwTlmVALZ99frBSxWX1d
 N15BI4ZTuDtHeYfal3bXHcU9OrTggvVSWmujuPpw3TmsLk8hcBYsgs3MnjPp3RcVxZ4h
 wzyA==
X-Gm-Message-State: AHQUAuYVY+zVlq6fGHP0Ooskr1d5zO/NwopVg+Mwxl+KvpH+LArol0iN
 7RAfaf/KbrI9XrRky2LXoJ0/1wBwLm1I35EqO7o=
X-Google-Smtp-Source: AHgI3IYYRJsrxvUATL+z3YdUmabO7s/9sWTypwNrKCSsht6wag/Nd08ZOTwco99M583xcTNNctqFGPZTDmJePpC4e48=
X-Received: by 2002:a9d:3bc7:: with SMTP id k65mr28869547otc.11.1549897749441; 
 Mon, 11 Feb 2019 07:09:09 -0800 (PST)
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
 <CANAwSgSQRwF+_VR1jJFg=Q9wSdanEH0GmnFaeegt=hRMXiHX3Q@mail.gmail.com>
 <CAFBinCBwDg21t+HT6w7CcUgH_aDuwh-UgoPs7GuZo9rABvPDig@mail.gmail.com>
In-Reply-To: <CAFBinCBwDg21t+HT6w7CcUgH_aDuwh-UgoPs7GuZo9rABvPDig@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 11 Feb 2019 20:38:57 +0530
Message-ID: <CANAwSgRKgWCyNoDUxrK4asjZ_6z77Rew2nGCg1Yq9m3pi0Amrw@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_070911_166312_686AE31F 
X-CRM114-Status: GOOD (  25.82  )
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

On Mon, 11 Feb 2019 at 03:51, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sat, Feb 9, 2019 at 6:55 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > But this dose not work setting the usb1_phy to use vbus-supply.
> > > >
> > > >  &usb1_phy {
> > > >         status = "okay";
> > > > +       vbus-supply = <&usb_vbus>;
> > > >  };
> > > >
> > > > I am attaching a small patch for testing.
> > > > [0] usbvbus.patch
> > > indeed, this is not working for me either.
> > > I checked my old notes at [0] -> it works for me when setting
> > > "vbus-supply" at the usb controller (not the PHY).
> > >
> > > with the following snippet:
> > >   &usb1 {
> > >     status = "okay";
> > >     vbus-supply = <&usb_vbus>;
> > >   };
> > > I get:
> > > # cat /sys/kernel/debug/regulator/regulator_summary | grep -i usb
> > >    c90c0000.usb                  1                                 0mA
> > >     0mV     0mV
> > >    c90c0000.usb                  1                                 0mA
> > >     0mV     0mV
> > >    USB_VBUS                      1    1      0 unknown  5000mV     0mA
> > >  5000mV  5000mV
> > >       c90c0000.usb               1                                 0mA
> > >     0mV     0mV
> > >
> > > can you please try this on your board as well?
> > >
> > > > Here is the summary of the above patch.
> > > >
> > > > 1. hot-plugins of usb device is not working.
> > > > 2. only cold/warm boot let the device come up.
> > > > 3. not power is supplied to the usb ports.
> > > > 4. no power module is registered with the regulator summary.
> > > with "vbus-supply" moved to the usb1 node I get the following result:
> > > 1. same: hot-plugins of usb device is not working
> > > 2. different: a reboot doesn't make devices come up
> > > 3. same: no power is supplied to the USB ports (in my case this causes
> > > #2, but it's not clear why there's no power...)
> > > 4. different: the regulator is registered with the USB controller in debugfs
> > >
> > Here the the logs after I applied the above changes
> >
> > [1] https://pastebin.com/rVa8gxNG
> can you please provide the .dts patch for this log?
> I can see the following message in your log:
> [    1.977367] USB_VBUS: disabling
>
Sorry for the confusion on the logs.
Above logs are generated with below setting.

&usb1 {
   status = "okay";
    vbus-supply = <&usb_vbus>;
 };

> I have tried it with the attached patch, then I get:
> # dmesg | grep VBUS
> #
> # cat /sys/kernel/debug/regulator/regulator_summary
> regulator                      use open bypass  opmode voltage current
>     min     max
> ---------------------------------------------------------------------------------------
> regulator-dummy                  4    3      0 unknown     0mV     0mA
>     0mV     0mV
>    c90c0000.usb                  1                                 0mA
>     0mV     0mV
>    c90c0000.usb                  1                                 0mA
>     0mV     0mV
>    VCCK                          1    1      0 unknown   860mV     0mA
>   860mV  1140mV
>       cpu0                       0                                 0mA
>   860mV   860mV
> P5V0                             3    4      0 unknown  5000mV     0mA
>  5000mV  5000mV
>    VCC1V8                        2    2      0 unknown  1800mV     0mA
>  1800mV  1800mV
>       c1108680.adc               1                                 0mA
>     0mV     0mV
>       c1108e00.mmc               1                                 0mA
>  1800mV  1950mV
>    VCC3V3                        2    3      0 unknown  3300mV     0mA
>  3300mV  3300mV
>       c1108e00.mmc               1                                 0mA
>  3300mV  3400mV
>       VDD_RTC                    0    0      0 unknown   900mV     0mA
>   900mV   900mV
>       TFLASH_VDD                 1    1      0 unknown  3300mV     0mA
>  3300mV  3300mV
>          c1108c20.mmc:slot@1     1                                 0mA
>  3300mV  3400mV
>    DDR_VDDC                      0    0      0 unknown  1500mV     0mA
>  1500mV  1500mV
>    USB_VBUS                      1    1      0 unknown  5000mV     0mA
>  5000mV  5000mV
>       c90c0000.usb               1                                 0mA
>     0mV     0mV
> TF_IO                            0    1      0 unknown  3300mV     0mA
>  1800mV  3300mV
>    c1108c20.mmc:slot@1           0                                 0mA
>     0mV     0mV
>
> (my kernel build includes two more changes on top of Kevin's v5.1/dt
> branch which add two new regulators: it enables the RTC and the SDHC
> MMC controller, but these are not related to USB at all)
>
> USB ist still not working for me, but I believe my problem is
> different to yours.
>
>
> Regards
>
> Martin

Can we have other people who can test both the approach for
*vbus-supply* vs *phy-supply* setting.
Then we can conclude on the correct approach.

Honestly I am using power supply from dc jack rather than power via usb otg.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
