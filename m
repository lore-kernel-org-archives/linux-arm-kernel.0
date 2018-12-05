Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D614C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5262084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lr1AiBn8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK/oiRM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5262084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MCzmR1fbTsGZ/8ibXPMooe2nWGeMWkiUADRsCB39qcY=; b=lr1AiBn8A7KbSW
	yrDcE2TkBNxLJ7mbfFaYYL3i4dQbhumUbrIYaMT/bCvYevnAhqjLRZdZUDOc1ZcUBoGZv7bKeiqOJ
	6d2soRY6Y6EhqF6TRJpHvPsHSUhSG6divpmKYMca3ID4KlwY4TABjnZ3RVTu4FtVJBucdHX1hoMur
	9QIorj7dUrnFK8mDMoPGVHxLnbd/brnrPthnOu7UDzmx551DwYxUiKftPFKLjS4NtwSSkueKUtG2z
	zDmItuTZIyU7PdOIDgmT3LhS7FOa9m9kOLy3xjSVjmKr8up1SKabN89em0s0TneuZ3WbvjavrCxmI
	E+agdE2GwgWc6rP+2/jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZm5-0000TP-Qw; Wed, 05 Dec 2018 16:11:45 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZm2-0000GE-Je
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:11:44 +0000
Received: by mail-oi1-x241.google.com with SMTP id c206so18019887oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RM0jifnXc+G3NF8Fp9TP8tFcZPa719v9l8BRJVmH86o=;
 b=AK/oiRM5Yk9KocpLRVCRLC5iOhoAJ6bODTrF5Jf9XwiqHoA/X3+A6hBQuMLXoeseP3
 obdJCKQTq9iM43kxBuy5SAyQUKeWlEAjWVu7bXWcIjfI6x22CMDY9CxqNnDHsYIMLEfk
 YnM6uklEdPmwBtJhPtm36dHpl79CRErstWWGrRbOL813yrU2KYsiuUehLlaC9Og5JyRd
 C5sMwDvH2NPwcr6Uo9W62PgsaSbHCBy4cOGjhUQnEqwJo9EvFQaF/nCu0vcMJUbhO3LK
 pwsTtshHT1F8dw1gz+WYl4NiL0IuEiIJ7T4GaH15zNbKBWVeGsquXRBAu8gzB6ORS3b5
 wdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RM0jifnXc+G3NF8Fp9TP8tFcZPa719v9l8BRJVmH86o=;
 b=pdZTQwOdhtXmMnkIuRyjsM1PLH9r57EZuwUqCGdtJ+Ww2JsBPFhBF0p9aMM5/6exq4
 PPRXcBVLySxm6U1asLAS+y8/t7lP1/DtIkV0DaekReT+lBJ+JTejJDZOgY0/yUhu8d9+
 rkw+zjRuOKveSby38JhRi5+hfpuCHAM65btUixuGhRczPvmkklY2vJY0Qpqc23AdiyTa
 ZsM9OGSTK3806CzAEZ9notPKxGmlNtOS8Sxg8AQznfpbuhn9FFmKi7Re6ZKWhnUc1qNm
 UtDU9OcN8GSOAD5Nf2CYp1g1+wzus4BS3Q6PJnBSvF6mfdYtzppDSDVuB6zTWVKgLAJh
 CWrw==
X-Gm-Message-State: AA+aEWZpHkBCditPNrw851k4Lh46apC32J3JwEyZVJEHe63MY7MNBs3s
 e5GXb+P5RvN1V7c07rMFb6Bmgn/9cdl9v4M93iU=
X-Google-Smtp-Source: AFSGD/VR5nmDnxBw8CMXD1NnWp5ZSpKNVHYpVp6+3OSn6Uibe+S3aUuo0SC71/FK244i7ZpaOp+uwS30vIFqb0MpiuE=
X-Received: by 2002:aca:915:: with SMTP id 21mr15587827oij.163.1544026291486; 
 Wed, 05 Dec 2018 08:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com>
 <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
In-Reply-To: <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 5 Dec 2018 21:41:19 +0530
Message-ID: <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081142_673685_8E22FAB8 
X-CRM114-Status: GOOD (  29.50  )
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

Thanks for your review.
.
On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add suspend-to-mem node to regulator core to be enabled or disabled
> > during system suspend and also support changing the regulator operating
> > mode during runtime and when the system enter sleep mode.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Tested on Odroid U3+
> > ---
> >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 2caa3132f34e..837713a2ec3b 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -285,6 +285,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
>
> Driver does not support suspend_enable so this will be noop. We could
> add this for DT-correctness (and full description of HW) but then I
> need explanation why this regulator has to stay on during suspend.
>

Well I tried to study the suspend/resume feature from
*arch/arm/boot/dts/exynos4412-midas.dtsi*
and them I tried to apply the same with this on Odroid-U3 boards and
test these changes.

> >                         };
> >
> >                         ldo3_reg: LDO3 {
> > @@ -292,6 +295,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> The same but with suspend_disable.
>
> I am not saying that these are wrong but I would be happy to see
> explanations why you chosen these particular properties.
>

Well I was not aware on the regulator-always-on cannot be set to off
in suspend mode.
Will drop this in the future patch where regulator-always-on; is set.

> >                         };
> >
> >                         ldo4_reg: LDO4 {
> > @@ -299,6 +305,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo5_reg: LDO5 {
> > @@ -307,6 +316,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo6_reg: LDO6 {
> > @@ -314,6 +326,9 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo7_reg: LDO7 {
> > @@ -321,18 +336,27 @@
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo8_reg: LDO8 {
> >                                 regulator-name = "VDD10_HDMI_1.0V";
> >                                 regulator-min-microvolt = <1000000>;
> >                                 regulator-max-microvolt = <1000000>;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo10_reg: LDO10 {
> >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo11_reg: LDO11 {
> > @@ -340,6 +364,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo12_reg: LDO12 {
> > @@ -348,6 +375,9 @@
> >                                 regulator-max-microvolt = <3300000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo13_reg: LDO13 {
> > @@ -356,6 +386,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo14_reg: LDO14 {
> > @@ -364,6 +397,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo15_reg: LDO15 {
> > @@ -372,6 +408,9 @@
> >                                 regulator-max-microvolt = <1000000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo16_reg: LDO16 {
> > @@ -380,6 +419,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo20_reg: LDO20 {
> > @@ -387,6 +429,9 @@
> >                                 regulator-min-microvolt = <1800000>;
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         ldo21_reg: LDO21 {
> > @@ -394,6 +439,9 @@
> >                                 regulator-min-microvolt = <2800000>;
> >                                 regulator-max-microvolt = <2800000>;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
>
> That's unusual setting... enabled in suspend but not necessarily
> during work (no always-on).
>

I kept the regulator required for emmc/sd card in
regulator-on-in-suspend in suspend mode.

> > +                               };
> >                         };
> >
> >                         ldo22_reg: LDO22 {
> > @@ -411,6 +459,9 @@
> >                                 regulator-max-microvolt = <1800000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck1_reg: BUCK1 {
> > @@ -419,6 +470,9 @@
> >                                 regulator-max-microvolt = <1100000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
> > +                               };
>
> This is seriously wrong so I have doubts whether you tested the
> changes or you know what is happening with them. If you turn off
> memory bus regulator off, how the memory will work in
> Suspend-to-Memory mode?
>

Well I did not find any issue in my testing but I might be wrong.
Ok I will drop this changes in the next version of the patch where
regulator-always-on is set.

> >                         };
> >
> >                         buck2_reg: BUCK2 {
> > @@ -427,6 +481,9 @@
> >                                 regulator-max-microvolt = <1350000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-on-in-suspend;
> > +                               };
> >                         };
> >
> >                         buck3_reg: BUCK3 {
> > @@ -435,6 +492,9 @@
> >                                 regulator-max-microvolt = <1050000>;
> >                                 regulator-always-on;
> >                                 regulator-boot-on;
> > +                               regulator-state-mem {
> > +                                       regulator-off-in-suspend;
>
> Looks suspicious as well.

Ok I will drop this changes in the next version of the patch where
regulator-always-on is set.

>
> Best regards,
> Krzysztof
>

Well I have tested this patch as following
with only one issue, before enable suspend number of On-line cpu is 4
after resume number of On-line cpu is 1.

# lscpu
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               0
Model name:          Cortex-A9
Stepping:            r3p0
CPU max MHz:         1704.0000
CPU min MHz:         200.0000
BogoMIPS:            48.00
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
#
# echo 1 > /sys/power/pm_debug_messages
# echo +30 > /sys/class/rtc/rtc0/wakealarm
#  echo -n mem > /sys/power/state
[   86.584147] PM: suspend entry (deep)
[   86.584684] PM: Syncing filesystems ... done.
[   86.735819] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   86.742319] OOM killer disabled.
[   86.744018] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[   86.751479] printk: Suspending console(s) (use no_console_suspend to debug)
[   86.792770] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   86.821751] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   86.822560] dwc2 12480000.hsotg: new device is full-speed
[   86.822666] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   86.822682] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   86.824507] wake enabled for irq 119
[   86.824592] BUCK9: No configuration
[   86.824672] BUCK8_P3V3: No configuration
[   86.824706] BUCK7_2.0V: No configuration
[   86.824738] BUCK6_1.35V: No configuration
[   86.824770] VDDQ_CKEM1_2_1.2V: No configuration
[   86.826766] LDO26: No configuration
[   86.826802] VDDQ_LCD_1.8V: No configuration
[   86.826834] LDO24: No configuration
[   86.826866] LDO23: No configuration
[   86.826898] LDO22_VDDQ_MMC4_2.8V: No configuration
[   86.826930] TFLASH_2.8V: No configuration
[   86.826962] LDO20_1.8V: No configuration
[   86.826994] LDO19: No configuration
[   86.827026] LDO18: No configuration
[   86.827057] LDO17: No configuration
[   86.827516] VDDQ_C2C_W_1.8V: No configuration
[   86.828324] VDDQ_MIPIHSI_1.8V: No configuration
[   86.828359] LDO9: No configuration
[   86.828818] VDDQ_MMC1_3_1.8V: No configuration
[   86.828851] VDDQ_MMC2_2.8V: No configuration
[   86.828884] VDDQ_EXT_1.8V: No configuration
[   86.828935] VDD_ALIVE_1.0V: No configuration
[   86.839760] usb3503 0-0008: switched to STANDBY mode
[   86.840336] wake enabled for irq 123
[   86.855834] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt mask: 0xfbfff7ff
[   86.871661] Disabling non-boot CPUs ...
[   87.016430] Enabling non-boot CPUs ...
[   88.009557] CPU1: failed to boot: -110
[   88.010324] Error taking CPU1 up: -110
[   89.009841] CPU2: failed to boot: -110
[   89.011290] Error taking CPU2 up: -110
[   90.009615] CPU3: failed to boot: -110
[   90.010258] Error taking CPU3 up: -110
[   90.012152] s3c-i2c 13860000.i2c: slave address 0x00
[   90.012174] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[   90.012208] s3c-i2c 13870000.i2c: slave address 0x00
[   90.012225] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[   90.012257] s3c-i2c 13880000.i2c: slave address 0x00
[   90.012274] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[   90.012306] s3c-i2c 138e0000.i2c: slave address 0x00
[   90.012323] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[   90.028694] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[   90.029174] usb usb1: root hub lost power or was reset
[   90.032911] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   90.033064] wake disabled for irq 123
[   90.041886] usb3503 0-0008: switched to HUB mode
[   90.127583] wake disabled for irq 119
[   90.127865] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   90.429505] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   90.781458] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   91.366725] OOM killer enabled.
[   91.369869] Restarting tasks ... done.
[   91.419515] PM: suspend exit
# [   92.229649] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex,
lpa 0xC5E1
# lscpu
Architecture:         armv7l
Byte Order:           Little Endian
CPU(s):               4
On-line CPU(s) list:  0
Off-line CPU(s) list: 1-3
Thread(s) per core:   1
Core(s) per socket:   1
Socket(s):            1
Vendor ID:            ARM
Model:                0
Model name:           Cortex-A9
Stepping:             r3p0
CPU max MHz:          1704.0000
CPU min MHz:          200.0000
BogoMIPS:             24.00
Flags:                half thumb fastmult vfp edsp neon vfpv3 tls vfpd32

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
