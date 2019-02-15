Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D7F218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rD9mk01f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7s10oKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D7F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CWddKyDKNrG9qjGaEIMtYyXEhMeN483klxaDHvWvt5M=; b=rD9mk01f8kqleL
	BxEIixl+7fV7cZqT0U7ghf39yrDMrvALGKBBEJtXGYcShxE/dADN/IKGI0sS5f0D6n28rXSguoSYk
	cd88NuKnQrdEHnzmiI4XzWb97lJnhVIOtetvOIbQaMCKv7kSv08eLJAHSMLq9V476xn9CJz6W5kDP
	nYM+qUe5Ck4ZqP89hxQMjm+Pv7edmomMk9Tvra7vvB52c1uqCW9W7wCo0ZIAq/Bh/SXdHLKY62sYX
	GprbymtKUhI42SmJiH5T0VA16vxFTGoJSfFkgkGsiRdCpCbMwCo4bHbIaEnAVkmgP6x7YYxinLnKW
	m1c+vjF7rLI75loLJ/uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gue0a-0007rG-Vg; Fri, 15 Feb 2019 13:58:29 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gue0X-0007qt-9N
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:58:27 +0000
Received: by mail-ot1-x343.google.com with SMTP id v62so7778463otb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dHYLTJe+JQ+Aanabt0LnmERhNeq9TlVTYryTPgEnjxE=;
 b=t7s10oKyzY4l75YhxeBZhSQLUPOskRXc/Axfbh2bvvqktv+Ic64tMhb/6VQyfKwA38
 HgWBT2/BNika3YfN87sgqbNSDTt7WJeF7/3CvfIiPHPYfbfLy12XJ8S6Sd0u+mx2dD7e
 ThL5JUvkcnCQxCa4lK767WbV50DH0bDin+qt7i5dR05J/2s+P8IdiDGbKlGDva3/5ZLm
 +aTyiyQtI3n+SgZRYeCkB3HAU4zPTLP0OWizW8AqZW1R+FaOkDxf6Y8KAfqtrBUQYNS5
 5vo7ZiFObQdvaknaLbqejjO81Dx3OfvYlrlDOf+kJYJBxe1r5rIDvh4Q7fEfwRDaXe8X
 MPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dHYLTJe+JQ+Aanabt0LnmERhNeq9TlVTYryTPgEnjxE=;
 b=lePvR/B1Y82xoDmWli4RUOH2DbtcwlWtl+jVoAWf9vuPbdFD4pIEV3jZ1QVCuygOcq
 UBmy5n6DcGS7j77zzzBI6L8a+LJmhDX1Fh55ewn6AkKATlhymy9M3atSDSsqSal4HlIO
 4rAXkzFXgicLVwHVEyn3owE0KQAVf7ZOb5TFWZwDr6AvSaeMhepw4v0HrYRMwpDY6tWC
 NHxA3Ef7lOh63/15avXHqFo5MtdViayZ2dsAbrcJ29RkqQaX0YjzGzYgv4keGRZp+RKS
 XXc8DdzUB57OyHZIJeO+xH9BfxCIg7I4kngObXEc+izlmABm8LdUOzQroGQNm5Bwp3KM
 MIsQ==
X-Gm-Message-State: AHQUAuZdtg5hKsQmJa8JpfPmK+7+BQ++s7aX05WcOIxqZuye4Fn8h53Z
 flfIehstn0X0X1y/XFIGRhmb3Yrj791YILZwymJrFpY/
X-Google-Smtp-Source: AHgI3IbP6mJhK7fCyjCmDPeX1G+VOkmeF1JK0rbGXFIjbTn4RAR9T1omsLKAyfaau3KZMTs6bBQuC0IYjvOmEeHyfDw=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr5885362oig.163.1550239104269; 
 Fri, 15 Feb 2019 05:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-2-linux.amoon@gmail.com>
 <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
 <CANAwSgQB-=iwX1L0m6N=dbe6jbfUMYyjgna_QMmJyggj6rxzwQ@mail.gmail.com>
 <CAJKOXPcrkVEgsaTFrQbCvn=gx3h6av7zvaXcfroNMYk6qgs8mQ@mail.gmail.com>
In-Reply-To: <CAJKOXPcrkVEgsaTFrQbCvn=gx3h6av7zvaXcfroNMYk6qgs8mQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 15 Feb 2019 19:28:11 +0530
Message-ID: <CANAwSgR43=p-YitdHm1q9rQTHYYH31pnUqJgavRe3vQ6Zjb1qw@mail.gmail.com>
Subject: Re: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_055825_352365_1782BF29 
X-CRM114-Status: GOOD (  31.09  )
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
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On Fri, 15 Feb 2019 at 13:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 14 Feb 2019 at 19:35, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > hi Krzysztof,
> >
> > Thanks fro your review comments.
> >
> > On Thu, 14 Feb 2019 at 18:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hi Anand,
> > >
> > > Thanks for the patch. See comments below.
> > >
> > > On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > > during system suspend and also support changing the regulator operating
> > > > mode during runtime and when the system enter sleep mode.
> > > >
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > >
> > > > Changes from previos patch
> > > > [0] https://patchwork.kernel.org/patch/10712549/
> > > >
> > > > Set all the WAKEUP source regulator in suspend-on state.
> > > > LD04, LD012, LD015, LD020, LD022
> > > > Set all the non used regulator in suspend-odd state
> > > > LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
> > > >
> > > > BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
> > > >
> > > > Tested on microSD card and it resumes correcly after suspend.
> > > > eMMC is not able to resume after entering into suspend state,
> > > > which need to be investigated and how to debug more.
> > > > ---
> > > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
> > > >  arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
> > > >  2 files changed, 66 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 08d3a0a7b4eb..e984461c37d9 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -288,6 +288,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > I see my comment from previous patch was not addressed.
> >
> > I left this unchanged since this regulator is not active linked and used.
> > Ok I will change this to regulator-on-in-suspend,
>
> Why?
>
> Previous patch was setting this to "on". I said that this is noop and
> if you want to add it, I need explanation why this regulator has to
> stay on during suspend.
>
> So you changed to "off"... which is still noop... and you did not
> provide explanation. Now you replied that you will change to "on"...
> so this will be circle. Still without explanation.
>
------------------------------------------------------------------------------------------------
I have added some debug prints to get more inputs.

Here is the boot logs for sdcard suspend resume

[1] https://pastebin.com/wvJvJidp

[root@archl-u3m ~]# rtcwake -d /dev/rtc0 -m mem -s 10
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Feb 15 13:28:06 2019
[   97.165349] PM: suspend entry (deep)
[   97.165846] PM: Syncing filesystems ... done.
[   97.344436] Freezing user space processes ... (elapsed 0.006 seconds) done.
[   97.354738] OOM killer disabled.
[   97.356028] Freezing remaining freezable tasks ... (elapsed 0.004
seconds) done.
[   97.413453] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   97.423227] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   97.444346] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   97.446728] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   97.451287] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   97.457742] dwc2 12480000.hsotg: new device is full-speed
[   97.465766] wake enabled for irq 119
[   97.466979] BUCK9: No configuration
[   97.470417] BUCK8_P3V3: No configuration
[   97.474131] BUCK7_2.0V: No configuration
[   97.477954] BUCK6_1.35V: No configuration
[   97.481946] VDDQ_CKEM1_2_1.2V: No configuration
[   97.487930] BUCK4: regulator suspend disable supported
[   97.491964] BUCK3: regulator suspend disable supported
[   97.497184] BUCK1: regulator suspend disable supported
[   97.501838] LDO26: No configuration
[   97.505383] LDO24: No configuration
[   97.508761] LDO23: No configuration
[   97.512368] LDO19: No configuration
[   97.515706] LDO18: No configuration
[   97.519178] LDO17: No configuration
[   97.523076] LDO16: regulator suspend disable supported
[   97.528154] LDO15: regulator suspend disable supported
[   97.533367] LDO14: regulator suspend disable supported
[   97.538447] LDO12: regulator suspend disable supported
[   97.543603] LDO11: regulator suspend disable supported
[   97.548308] LDO9: No configuration
[   97.552107] LDO7: regulator suspend disable supported
[   97.557064] LDO6: regulator suspend disable supported
[   97.562251] LDO2: regulator suspend disable supported
[   97.566769] VDD_ALIVE_1.0V: No configuration
[   97.581717] usb3503 0-0008: switched to STANDBY mode
[   97.582496] wake enabled for irq 123
[   97.602770] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   97.623616] Disabling non-boot CPUs ...
[   97.681453] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   97.681743] wake disabled for irq 123
[   97.692569] usb3503 0-0008: switched to HUB mode
[   97.801553] wake disabled for irq 119
[   97.802087] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   98.080458] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   98.432321] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   98.970441] usb 1-3.3: reset high-speed USB device number 4 using exynos-ehci
[   99.135835] OOM killer enabled.
[   99.135940] Restarting tasks ... done.
[   99.140760] PM: suspend exit
[root@archl-u3m ~]# [   99.877843] smsc95xx 1-2:1.0 eth0: link up,
100Mbps, full-duplex, lpa 0xC5E1

------------------------------------------------
Here is the boot log for emmc suspend resume. after disable of emmc regulator.

[2]  https://pastebin.com/Z05K3kj2

rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Feb 15 13:27:26 2019
[   79.775108] PM: suspend entry (deep)
[   79.775462] PM: Syncing filesystems ... done.
[   79.819009] Freezing user space processes ... (elapsed 0.004 seconds) done.
[   79.826300] OOM killer disabled.
[   79.828603] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   79.875967] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   79.959495] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   79.960480] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   79.966431] dwc2 12480000.hsotg: new device is full-speed
[   79.971805] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   79.980568] wake enabled for irq 119
[   79.982195] BUCK9: No configuration
[   79.985540] BUCK8_P3V3: No configuration
[   79.989201] BUCK7_2.0V: No configuration
[   79.993175] BUCK6_1.35V: No configuration
[   79.997099] VDDQ_CKEM1_2_1.2V: No configuration
[   80.002765] BUCK4: regulator suspend disable supported
[   80.007115] BUCK3: regulator suspend disable supported
[   80.012346] BUCK1: regulator suspend disable supported
[   80.016991] LDO26: No configuration
[   80.020467] LDO24: No configuration
[   80.023991] LDO23: No configuration
[   80.027456] LDO19: No configuration
[   80.030858] LDO18: No configuration
[   80.034388] LDO17: No configuration
[   80.038172] LDO16: regulator suspend disable supported
[   80.043410] LDO15: regulator suspend disable supported
[   80.048429] LDO14: regulator suspend disable supported
[   80.053658] LDO12: regulator suspend disable supported
[   80.058670] LDO11: regulator suspend disable supported
[   80.063522] LDO9: No configuration
[   80.067187] LDO7: regulator suspend disable supported
[   80.072290] LDO6: regulator suspend disable supported
[   80.077321] LDO2: regulator suspend disable supported
[   80.081995] VDD_ALIVE_1.0V: No configuration
[   80.096885] usb3503 0-0008: switched to STANDBY mode
[   80.097568] wake enabled for irq 123
[   80.116002] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   80.134695] Disabling non-boot CPUs ...

[snip]

> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > index 2bdf899df436..4ebde09fc51d 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > @@ -82,6 +82,9 @@
> > > >         regulator-name = "LDO22_VDDQ_MMC4_2.8V";
> > > >         regulator-min-microvolt = <2800000>;
> > > >         regulator-max-microvolt = <2800000>;
> > > > +       regulator-state-mem {
> > > > +               regulator-on-in-suspend;
> > >
> > > Why?
> > >
> >
> > I chose not to disable mshc_0 (emmc) regulator,
> > since I could not get suspend resume working on eMMC.
>
> Having "regulator-on-in-suspend" is not the same as not disabling
> regulator during suspend. This property means you will explicitly
> enable it during suspend. To me it looks wrong so I would be happy to
> see explanations.
>

During suspend the driver set the regulator in standby mode until resume.
Opps I understood the regulator in suspend mode enter into

REGULATOR_MODE_STANDBY : MAX77686_OFF_PWRREQ;

[   79.997099] VDDQ_CKEM1_2_1.2V: No configuration
[   80.002765] BUCK4: regulator suspend disable supported
[   80.007115] BUCK3: regulator suspend disable supported
[   80.012346] BUCK1: regulator suspend disable supported
[   80.016991] LDO26: No configuration
[   80.020467] LDO24: No configuration
[   80.023991] LDO23: No configuration
[   80.027456] LDO19: No configuration
[   80.030858] LDO18: No configuration
[   80.034388] LDO17: No configuration
[   80.038172] LDO16: regulator suspend disable supported
[   80.043410] LDO15: regulator suspend disable supported
[   80.048429] LDO14: regulator suspend disable supported
[   80.053658] LDO12: regulator suspend disable supported
[   80.058670] LDO11: regulator suspend disable supported
[   80.063522] LDO9: No configuration
[   80.067187] LDO7: regulator suspend disable supported
[   80.072290] LDO6: regulator suspend disable supported
[   80.077321] LDO2: regulator suspend disable supported

So as per the logs BUCK1 / BUCK3 / BUCK4 successfully entered into suspend mode.

Where as suspend is disabled in groups as per the documentation.
(Group 1)
Buck6-->Buck7-->LD01-->LD011-->LD014
Group 2)
Buck2-->Buck1-->Buck3-->Buck4
Group 3>
LD06-->LD013-->LD08-->LD015-->LD010-->LD016-->LD05-->LD012

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
