Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E17C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C79F2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZLPHnuGt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lJjNQ1VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C79F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M98Qqpnt8ZUxquYaobOYdJGngYK9ONujzgVBTOk5Iyg=; b=ZLPHnuGt2Pst8Q650ImtEG5AI
	fDq+OZ+k3NovktGkscPn13qgUYURbTpuCtY/udYfuq3EFjPr3uJ3hoAqvozF8JXHyGb+uNm/r7mTI
	THGAOGzL0R8xFKaBeZx71PHNNQN8SXUip+0kA+isnVCQ3dv8JRENL22r0regrvdIL6JB/LOznHduT
	cjz0FC0Q1wzjqmquf2ucEtY13a1wcrbgAT4errnDEBoygofdSHQDkax0HNPkeo/9IVNZ9L2AR9DMN
	+LAOuA9AufpRQ2fwNJL01c8KVXQ09aKOjw8WtXV/nqeWXAdMfDQ3Qr7JOJQVrA/Qftz3wBUeFEO+9
	D61M58CIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxU4-0007Q2-7Z; Sun, 10 Feb 2019 22:21:56 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxTy-0007Ov-Q0; Sun, 10 Feb 2019 22:21:52 +0000
Received: by mail-ot1-x344.google.com with SMTP id 32so14435444ota.12;
 Sun, 10 Feb 2019 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AdoNSob177L31r3KUHrqyxvfDROGvKI6dmmHVkyG6PU=;
 b=lJjNQ1VFmtCgWvEQj/lCcLa2FWeXQlU9sc12GR03KUiA19YLK1cNkEe4Gzpf2vYSko
 P2Go5oGQTxdISMFwlk5XJ6Kf2sF7fSQlnpDniYzg1/1fPq/GoNi6cTvAUmJxQZU92+ft
 c7xZ0jDmg/tTZ9KhSQ6KEkGT13liKAL2Ifllv5CSYul/5y8bIDIP01lUlF+B6GdnOUzR
 TU0cRH1rqI/rwUy7q0bqlsawLrZ5P96B8Eg3Ak4nV0Hlu4PEqVRxZN2b1mo5kzUXdZwJ
 Avyv8Znqoc1VPpZ8/XBuqsqIniEtTUnbv0xo8Vpea40h6RgfvIqWC25imoYWXmtBuBwY
 hN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AdoNSob177L31r3KUHrqyxvfDROGvKI6dmmHVkyG6PU=;
 b=sqAwzmrCZEukIq1k5dcGCUgRDmdNOcj/n+SmFBQbq+K87yQnA/9EK54fuhIsnuyXnY
 gEbSPPYFonciN7HiWsrAvMoSFyFjzv9pV/KARq6uV4AivDoZWZihHXsEhsOCr4zzXCa3
 6ZmQyYe+eSIPzqtBH5LibiEHDzx7lom66nExybfOjbwQO2FLcMpsEzmCu4AdmlO+PBXe
 U0mZpL3ei/fQ/ZaINYEX4b2Gaya/soYyYRcSS64DvZG1VhGTW9/wL2gT4kG56jx6+t1E
 UKBtxgW56rpVATqhxFiYAIjXY3QvCA9oA8HL1L7DP51SIfC/iJXznWQqfaP2P7DrI16d
 S7Eg==
X-Gm-Message-State: AHQUAubkb19bitYDvwbj6G/XWDngZsYGoRhyjECSWrzs3jSyKfsi5Y0L
 TH83IMOLZX3Vqw/JX2ANQafwS0iW6I++5v90bDM=
X-Google-Smtp-Source: AHgI3IYqImZcEVjHaDdTwo9jf08MmMfx3OmNGuIhpms8Pi5HvYZuyIdWIHNMj2MLy6nKkLDwmpSXxgo7BaICKx7h4EU=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr25719918otf.131.1549837307094; 
 Sun, 10 Feb 2019 14:21:47 -0800 (PST)
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
In-Reply-To: <CANAwSgSQRwF+_VR1jJFg=Q9wSdanEH0GmnFaeegt=hRMXiHX3Q@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 10 Feb 2019 23:21:36 +0100
Message-ID: <CAFBinCBwDg21t+HT6w7CcUgH_aDuwh-UgoPs7GuZo9rABvPDig@mail.gmail.com>
Subject: Re: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies
 for phy
To: Anand Moon <linux.amoon@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002656590581919e73"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_142150_868987_A83C863E 
X-CRM114-Status: GOOD (  24.12  )
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

--0000000000002656590581919e73
Content-Type: text/plain; charset="UTF-8"

Hi Anand,

On Sat, Feb 9, 2019 at 6:55 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > But this dose not work setting the usb1_phy to use vbus-supply.
> > >
> > >  &usb1_phy {
> > >         status = "okay";
> > > +       vbus-supply = <&usb_vbus>;
> > >  };
> > >
> > > I am attaching a small patch for testing.
> > > [0] usbvbus.patch
> > indeed, this is not working for me either.
> > I checked my old notes at [0] -> it works for me when setting
> > "vbus-supply" at the usb controller (not the PHY).
> >
> > with the following snippet:
> >   &usb1 {
> >     status = "okay";
> >     vbus-supply = <&usb_vbus>;
> >   };
> > I get:
> > # cat /sys/kernel/debug/regulator/regulator_summary | grep -i usb
> >    c90c0000.usb                  1                                 0mA
> >     0mV     0mV
> >    c90c0000.usb                  1                                 0mA
> >     0mV     0mV
> >    USB_VBUS                      1    1      0 unknown  5000mV     0mA
> >  5000mV  5000mV
> >       c90c0000.usb               1                                 0mA
> >     0mV     0mV
> >
> > can you please try this on your board as well?
> >
> > > Here is the summary of the above patch.
> > >
> > > 1. hot-plugins of usb device is not working.
> > > 2. only cold/warm boot let the device come up.
> > > 3. not power is supplied to the usb ports.
> > > 4. no power module is registered with the regulator summary.
> > with "vbus-supply" moved to the usb1 node I get the following result:
> > 1. same: hot-plugins of usb device is not working
> > 2. different: a reboot doesn't make devices come up
> > 3. same: no power is supplied to the USB ports (in my case this causes
> > #2, but it's not clear why there's no power...)
> > 4. different: the regulator is registered with the USB controller in debugfs
> >
> Here the the logs after I applied the above changes
>
> [1] https://pastebin.com/rVa8gxNG
can you please provide the .dts patch for this log?
I can see the following message in your log:
[    1.977367] USB_VBUS: disabling

I have tried it with the attached patch, then I get:
# dmesg | grep VBUS
#
# cat /sys/kernel/debug/regulator/regulator_summary
regulator                      use open bypass  opmode voltage current
    min     max
---------------------------------------------------------------------------------------
regulator-dummy                  4    3      0 unknown     0mV     0mA
    0mV     0mV
   c90c0000.usb                  1                                 0mA
    0mV     0mV
   c90c0000.usb                  1                                 0mA
    0mV     0mV
   VCCK                          1    1      0 unknown   860mV     0mA
  860mV  1140mV
      cpu0                       0                                 0mA
  860mV   860mV
P5V0                             3    4      0 unknown  5000mV     0mA
 5000mV  5000mV
   VCC1V8                        2    2      0 unknown  1800mV     0mA
 1800mV  1800mV
      c1108680.adc               1                                 0mA
    0mV     0mV
      c1108e00.mmc               1                                 0mA
 1800mV  1950mV
   VCC3V3                        2    3      0 unknown  3300mV     0mA
 3300mV  3300mV
      c1108e00.mmc               1                                 0mA
 3300mV  3400mV
      VDD_RTC                    0    0      0 unknown   900mV     0mA
  900mV   900mV
      TFLASH_VDD                 1    1      0 unknown  3300mV     0mA
 3300mV  3300mV
         c1108c20.mmc:slot@1     1                                 0mA
 3300mV  3400mV
   DDR_VDDC                      0    0      0 unknown  1500mV     0mA
 1500mV  1500mV
   USB_VBUS                      1    1      0 unknown  5000mV     0mA
 5000mV  5000mV
      c90c0000.usb               1                                 0mA
    0mV     0mV
TF_IO                            0    1      0 unknown  3300mV     0mA
 1800mV  3300mV
   c1108c20.mmc:slot@1           0                                 0mA
    0mV     0mV

(my kernel build includes two more changes on top of Kevin's v5.1/dt
branch which add two new regulators: it enables the RTC and the SDHC
MMC controller, but these are not related to USB at all)

USB ist still not working for me, but I believe my problem is
different to yours.


Regards

Martin

--0000000000002656590581919e73
Content-Type: application/x-patch; name="vbus-supply.patch"
Content-Disposition: attachment; filename="vbus-supply.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrzgyt8b0>
X-Attachment-Id: f_jrzgyt8b0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lkYzEuZHRzIGIvYXJj
aC9hcm0vYm9vdC9kdHMvbWVzb244Yi1vZHJvaWRjMS5kdHMKaW5kZXggMGYwYTQ2ZGRmM2ZmLi40
NGI5ZTZjYmUyZWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lk
YzEuZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21lc29uOGItb2Ryb2lkYzEuZHRzCkBAIC0x
MTgsNiArMTE4LDIyIEBACiAJCQkgIDE4MDAwMDAgMT47CiAJfTsKIAorCXVzYl92YnVzOiByZWd1
bGF0b3ItdXNiLXZidXMgeworCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7CisKKwkJ
cmVndWxhdG9yLW5hbWUgPSAiVVNCX1ZCVVMiOworCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9
IDw1MDAwMDAwPjsKKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47CisKKwkJ
dmluLXN1cHBseSA9IDwmcDV2MD47CisKKwkJLyoKKwkJICogc2lnbmFsIG5hbWUgZnJvbSBzY2hl
bWF0aWNzOiBQV1JFTgorCQkgKi8KKwkJZ3BpbyA9IDwmZ3Bpb19hbyBHUElPQU9fNSBHUElPX0FD
VElWRV9ISUdIPjsKKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOworCX07CisKIAl2Y2NfMXY4OiByZWd1
bGF0b3ItdmNjLTF2OCB7CiAJCS8qCiAJCSAqIFJJQ0hURUsgUlQ5MTc5IGNvbmZpZ3VyZWQgZm9y
IGEgZml4ZWQgb3V0cHV0IHZvbHRhZ2Ugb2YKQEAgLTI5OSw0ICszMTUsNSBAQAogCiAmdXNiMSB7
CiAJc3RhdHVzID0gIm9rYXkiOworCXZidXMtc3VwcGx5ID0gPCZ1c2JfdmJ1cz47CiB9Owo=
--0000000000002656590581919e73
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--0000000000002656590581919e73--

