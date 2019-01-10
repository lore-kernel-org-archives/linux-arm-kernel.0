Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6098F206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6YDyEzW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3z1Z/Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6098F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n0Ff4RcXu/bZOp9VTpcIWyZWSoVPxDb1HIFLhqz7XKA=; b=O6YDyEzWAFVJ/P
	BGfN+oXUq6fWz8rvYWeBFD8juc3eREQQnok+L6frvawNTfXLbR/4iZrU0TJ3+KiBOvTKNb76z4B6I
	HnEnLAsJGzgesyfMeYB7dV+N6A2Q7yQnDbcSJjjRIabdfdeLCyc0gC22ybhJ6tGpHfpSaKdOasFpK
	syEEy/i36/NCeZOtpMKFP9PNluuGKqifF2Wg0b4mfX+cQ8U33er0KuV4WBlNEyx3+B/xmJR4bwv/+
	PnTkGBF7wmnd0sIBOqW5q7aJoHmsNfh4dI6kVWeuBXnfXaym89SKwG2RWozqUSKeQZ1cVlvVyA26o
	cXgXr6XctEgj+XNA9BIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghSbI-00089e-6q; Thu, 10 Jan 2019 05:09:52 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghSbE-00087g-Ku; Thu, 10 Jan 2019 05:09:50 +0000
Received: by mail-wr1-x442.google.com with SMTP id l9so9820492wrt.13;
 Wed, 09 Jan 2019 21:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JnaidOhiGb9hgR9XG+fQTCkiRC3SFac82cW9ZLPIGpc=;
 b=c3z1Z/MzG/+WmOJNyHD+q1T0Q/CYTM14Q/VPGZ1J4R0sIWgGzTGJYbNHSKIGkbICXm
 9/T4i5ZKVEfNoZ6sZfWA8M07e8WoYdaKo+lGfWB+EkbbDw8ZbPDGs22Zvu9bcaQGmfZm
 JoTD93/9OjwPZwzWpOGlAzolv3XJzuXl67fwxZdv60pBi481W3ksN3w4pUAkpEeuuGj/
 jaTIiBAiGU81c//8eh33LiGfRw533r7iTaJmgR/k+MVGjakvSFVqlVMhknFHe/fpweh3
 GyvQf+JUwlhO9mTFqcIeAKw/syGIaKxj4uCQuOPcbKRNHhPCZ9cJwt6SPeTwt/+eQbG3
 iQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JnaidOhiGb9hgR9XG+fQTCkiRC3SFac82cW9ZLPIGpc=;
 b=E32Jga3+ksVKCLBMGveUz8QvL/7fOPM9dnVQGFY57kB603c8i4lBA7vGl7Wm/7kXdV
 TPb4tVn6Y6IxE4HALi1AFCB0DzacZGkAqteVh4s/dprIllzl0qlvsaVqaJlABZX1AlVy
 ZXW315jw8zivYjKwUGB34gO32DNMvRIqAY1Ql4DnxIp1wUW3sEaYNyh4yaQ4nio9DhAB
 dsB0rVvkl9qv1yEp7p7ECka04WG4W3cLcZZReUG5F+01VTP3qZmeb5Bpio2QLI7bYLF3
 JzRnQR3AYMfuosmArgJGjvlTpytG1CO3v7p6r8hw1h7VyoIUu6C4D4ZqN+1yAqngrAwE
 NC/Q==
X-Gm-Message-State: AJcUukchkA9f7G0p1GzJVxvIW0AnGEX6ZIGp1eLiO0LUt1WKvRg3dLGQ
 xovXF+JFXt5eT/gtMTiGuih+x0ysCRT76Xr1RRo=
X-Google-Smtp-Source: ALg8bN5I/DuRfI8IJ6nyujwBThQSKzR6fPshvkmraecLmgb0CTC6rURr0ii98C8vqeykLxMOJbWuBo9SBDxZK9ZQ0Rk=
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr7161573wre.244.1547096984265; 
 Wed, 09 Jan 2019 21:09:44 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
In-Reply-To: <389675377.186771.1546942833612@email.ionos.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 10 Jan 2019 05:09:30 +0000
Message-ID: <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_210948_722817_E011DACE 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: devel@driverdev.osuosl.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 mikebrady@eircom.net, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

> > > But why didn't you applied the series which was actually applied to mainline?
> > > Did you apply the rest of Phil's DT series as mentioned in the cover letter?
> >
> > I'm fairly certain I have Phil's "Improve VCHIQ cache line size
> > handling" patch series applied if that's the one you mean, I will
> > check (I'm currently dealing with 4 different kernels for maintenance
> > so I'm sorry if my memory isn't exact).
>
> That's correct. Btw you will need a recent raspberrypi-firmware (iirc since 10/2018), too.

For reference I was using 1ea8781 from 18/12/2018, I noticed there's a
new one that fixes colour issues with the cameres.

Given I couldn't work out exactly which random patch set I had for the
test kernel I've now moved to a 4.20.1 with cacheline and this patch
series. I still get the same series of crash there from just running
qv4l2. I get a blank OpenGL window (could be something unrelated with
the vc4 driver), and the same issue with cheese.

[   74.723451] bcm2835_audio bcm2835_audio: vchi message timeout, msg=5
[  118.512917] bcm2835-v4l2: Failed enabling camera, ret -2
[  118.518379] bcm2835-v4l2: Failed to enable camera
[  118.523228] ------------[ cut here ]------------
[  118.528002] WARNING: CPU: 3 PID: 1470 at
drivers/media/common/videobuf2/videobuf2-core.c:1471
vb2_start_streaming+0xb4/0x12c [videobuf2_common]
[  118.541098] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables cmac ip6table_filter ip6_tables bnep sunrpc
vfat fat vc4 snd_soc_core ac97_bus bcm2835_v4l2(C) snd_pcm_dmaengine
snd_bcm2835(C) videobuf2_vmalloc snd_seq videobuf2_memops
videobuf2_v4l2 snd_seq_device videobuf2_common snd_pcm v4l2_common
videodev snd_timer snd media brcmfmac soundcore drm_kms_helper
brcmutil drm hci_uart cfg80211 fb_sys_fops btqca syscopyarea btbcm
joydev sysfillrect btintel sysimgblt bluetooth raspberrypi_hwmon
ecdh_generic rfkill bcm2835_thermal bcm2835_rng bcm2835_wdt vchiq(C)
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block dwc2 sdhci_iproc
sdhci_pltfm udc_core
[  118.541261]  gpio_raspberrypi_exp crc32_arm_ce sdhci pwm_bcm2835
bcm2835 i2c_bcm2835 bcm2835_dma phy_generic
[  118.639009] CPU: 3 PID: 1470 Comm: qv4l2 Tainted: G         C
 4.20.1-200.fc29.armv7hl #1
[  118.647828] Hardware name: BCM2835
[  118.651296] [<c03127a4>] (unwind_backtrace) from [<c030cbf0>]
(show_stack+0x18/0x1c)
[  118.659156] [<c030cbf0>] (show_stack) from [<c0b14f80>]
(dump_stack+0x80/0xa0)
[  118.666488] [<c0b14f80>] (dump_stack) from [<c03507b4>] (__warn+0xdc/0xf8)
[  118.673466] [<c03507b4>] (__warn) from [<c0350b28>]
(warn_slowpath_null+0x40/0x4c)
[  118.681168] [<c0350b28>] (warn_slowpath_null) from [<bf70a2d4>]
(vb2_start_streaming+0xb4/0x12c [videobuf2_common])
[  118.691810] [<bf70a2d4>] (vb2_start_streaming [videobuf2_common])
from [<bf70b78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  118.704152] [<bf70b78c>] (vb2_core_streamon [videobuf2_common])
from [<bf6aaa34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  118.715546] [<bf6aaa34>] (__video_do_ioctl [videodev]) from
[<bf6ab19c>] (video_usercopy+0x508/0x5d4 [videodev])
[  118.725923] [<bf6ab19c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  118.734487] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  118.741990] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  118.749495] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  118.757259] Exception stack(0xd940dfa8 to 0xd940dff0)
[  118.762382] dfa0:                   d47c8700 b5f1e000 0000000c
40045612 befb42a0 00000001
[  118.770678] dfc0: d47c8700 b5f1e000 40045612 00000036 b5e81e40
0000000c b6f41508 00000000
[  118.778970] dfe0: befb42a0 befb4290 b5f07804 b5bdb1f0
[  118.784155] ---[ end trace 4c04f89544a1aee9 ]---
[  132.329586] bcm2835-v4l2: Failed enabling camera, ret -2
[  132.335008] bcm2835-v4l2: Failed to enable camera
[  132.339826] ------------[ cut here ]------------
[  132.344555] WARNING: CPU: 3 PID: 1470 at
drivers/media/common/videobuf2/videobuf2-core.c:1471
vb2_start_streaming+0xb4/0x12c [videobuf2_common]
[  132.357629] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables cmac ip6table_filter ip6_tables bnep sunrpc
vfat fat vc4 snd_soc_core ac97_bus bcm2835_v4l2(C) snd_pcm_dmaengine
snd_bcm2835(C) videobuf2_vmalloc snd_seq videobuf2_memops
videobuf2_v4l2 snd_seq_device videobuf2_common snd_pcm v4l2_common
videodev snd_timer snd media brcmfmac soundcore drm_kms_helper
brcmutil drm hci_uart cfg80211 fb_sys_fops btqca syscopyarea btbcm
joydev sysfillrect btintel sysimgblt bluetooth raspberrypi_hwmon
ecdh_generic rfkill bcm2835_thermal bcm2835_rng bcm2835_wdt vchiq(C)
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block dwc2 sdhci_iproc
sdhci_pltfm udc_core
[  132.357792]  gpio_raspberrypi_exp crc32_arm_ce sdhci pwm_bcm2835
bcm2835 i2c_bcm2835 bcm2835_dma phy_generic
[  132.455510] CPU: 3 PID: 1470 Comm: qv4l2 Tainted: G        WC
 4.20.1-200.fc29.armv7hl #1
[  132.464329] Hardware name: BCM2835
[  132.467798] [<c03127a4>] (unwind_backtrace) from [<c030cbf0>]
(show_stack+0x18/0x1c)
[  132.475658] [<c030cbf0>] (show_stack) from [<c0b14f80>]
(dump_stack+0x80/0xa0)
[  132.482986] [<c0b14f80>] (dump_stack) from [<c03507b4>] (__warn+0xdc/0xf8)
[  132.489962] [<c03507b4>] (__warn) from [<c0350b28>]
(warn_slowpath_null+0x40/0x4c)
[  132.497663] [<c0350b28>] (warn_slowpath_null) from [<bf70a2d4>]
(vb2_start_streaming+0xb4/0x12c [videobuf2_common])
[  132.508273] [<bf70a2d4>] (vb2_start_streaming [videobuf2_common])
from [<bf70b78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  132.520619] [<bf70b78c>] (vb2_core_streamon [videobuf2_common])
from [<bf6aaa34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  132.532012] [<bf6aaa34>] (__video_do_ioctl [videodev]) from
[<bf6ab19c>] (video_usercopy+0x508/0x5d4 [videodev])
[  132.542387] [<bf6ab19c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  132.550949] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  132.558452] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  132.565956] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  132.573718] Exception stack(0xd940dfa8 to 0xd940dff0)
[  132.578838] dfa0:                   d47c8700 b5f1e000 0000000c
40045612 befb4368 00000001
[  132.587132] dfc0: d47c8700 b5f1e000 40045612 00000036 b5e81e40
0000000c b6f41508 00000000
[  132.595424] dfe0: befb4368 befb4358 b5f07804 b5bdb1f0
[  132.600568] ---[ end trace 4c04f89544a1aeea ]---
[  155.048886] list_add corruption. prev->next should be next
(ea7793e0), but was 00000000. (prev=d97cde78).
[  155.058671] ------------[ cut here ]------------
[  155.063361] kernel BUG at lib/list_debug.c:28!
[  155.067864] Internal error: Oops - BUG: 0 [#1] SMP ARM
[  155.073071] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables cmac ip6table_filter ip6_tables bnep sunrpc
vfat fat vc4 snd_soc_core ac97_bus bcm2835_v4l2(C) snd_pcm_dmaengine
snd_bcm2835(C) videobuf2_vmalloc snd_seq videobuf2_memops
videobuf2_v4l2 snd_seq_device videobuf2_common snd_pcm v4l2_common
videodev snd_timer snd media brcmfmac soundcore drm_kms_helper
brcmutil drm hci_uart cfg80211 fb_sys_fops btqca syscopyarea btbcm
joydev sysfillrect btintel sysimgblt bluetooth raspberrypi_hwmon
ecdh_generic rfkill bcm2835_thermal bcm2835_rng bcm2835_wdt vchiq(C)
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block dwc2 sdhci_iproc
sdhci_pltfm udc_core
[  155.073205]  gpio_raspberrypi_exp crc32_arm_ce sdhci pwm_bcm2835
bcm2835 i2c_bcm2835 bcm2835_dma phy_generic
[  155.170889] CPU: 1 PID: 1470 Comm: qv4l2 Tainted: G        WC
 4.20.1-200.fc29.armv7hl #1
[  155.179708] Hardware name: BCM2835
[  155.183162] PC is at __list_add_valid+0x44/0x84
[  155.187754] LR is at __list_add_valid+0x44/0x84
[  155.192344] pc : [<c069bec0>]    lr : [<c069bec0>]    psr: 600f0093
[  155.198694] sp : d940dda0  ip : 00000000  fp : 00000001
[  155.203988] r10: 600f0013  r9 : ea7793e0  r8 : ea7793e8
[  155.209282] r7 : d9534c00  r6 : d9534e78  r5 : d97cde78  r4 : ea779358
[  155.215898] r3 : ef74fcb0  r2 : 2e60e000  r1 : ef74c548  r0 : 0000005d
[  155.222516] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[  155.229837] Control: 10c5383d  Table: 1944c06a  DAC: 00000051
[  155.235661] Process qv4l2 (pid: 1470, stack limit = 0x56c02967)
[  155.241661] Stack: (0xd940dda0 to 0xd940e000)
[  155.246079] dda0: ea779358 bf7ab20c ede0a800 d9534c00 ede0ae24
bf6a6a08 ede0ab80 d940de78
[  155.254373] ddc0: bf6c3200 bf7a622c d9534c00 00000000 00000001
ede0ad28 d9534c00 bf70a278
[  155.262667] dde0: ede0ad28 00000000 ede0a858 bf6a6a08 ede0ab80
bf70b78c 40045612 bf6aaa34
[  155.270961] de00: d940de2c c04babdc ef8cfd24 bf7ac1f4 df58fc00
00000000 e9587240 df58fc00
[  155.279256] de20: c124f850 00000004 d940de7c c04c0b90 d940de78
c031691c d940de78 00000000
[  155.287549] de40: d940de78 00000000 bf6aa6d8 40045612 00000000
00000004 00000000 bf6ab19c
[  155.295843] de60: 0007ffff 00000000 00000000 befb4368 e9587240
00000001 00000001 00000001
[  155.304136] de80: 00000000 00002003 00000000 00000000 00000000
00000000 00000000 00000000
[  155.312429] dea0: 00000000 00000000 00000001 00240000 000c0000
00000000 00000000 00000000
[  155.320723] dec0: 00002000 00000000 ac2ef000 e535ae40 e95c6198
e95c6190 ac2ef000 c049bad0
[  155.329019] dee0: 00000001 00000003 000c0000 c0b2a8b4 00000000
c0b2a8b4 c2ee6570 befb4368
[  155.337315] df00: c2ee6570 e9587240 40045612 befb4368 0000000c
00000036 00000000 c04ffae8
[  155.345612] df20: befb4368 c0500308 00000001 00000056 00000012
d940df48 00000001 ef2ac910
[  155.353908] df40: c29c4660 d9405612 d940df0b d940df3c 00400100
00000000 d940df58 c126ab28
[  155.362204] df60: e9587240 40045612 00000000 e9587240 e9587241
40045612 befb4368 0000000c
[  155.370500] df80: 00000036 c0500b0c d47c8700 b5f1e000 40045612
00000036 c0301204 d940c000
[  155.378797] dfa0: 00000036 c0301000 d47c8700 b5f1e000 0000000c
40045612 befb4368 00000001
[  155.387093] dfc0: d47c8700 b5f1e000 40045612 00000036 b5e81e40
0000000c b6f41508 00000000
[  155.395386] dfe0: befb4368 befb4358 b5f07804 b5bdb1f0 400f0010
0000000c 00000000 00000000
[  155.403716] [<c069bec0>] (__list_add_valid) from [<bf7ab20c>]
(vchiq_mmal_submit_buffer+0x4c/0x74 [bcm2835_v4l2])
[  155.414189] [<bf7ab20c>] (vchiq_mmal_submit_buffer [bcm2835_v4l2])
from [<bf7a622c>] (buffer_queue+0x58/0x90 [bcm2835_v4l2])
[  155.425602] [<bf7a622c>] (buffer_queue [bcm2835_v4l2]) from
[<bf70a278>] (vb2_start_streaming+0x58/0x12c [videobuf2_common])
[  155.437005] [<bf70a278>] (vb2_start_streaming [videobuf2_common])
from [<bf70b78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  155.449348] [<bf70b78c>] (vb2_core_streamon [videobuf2_common])
from [<bf6aaa34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  155.460740] [<bf6aaa34>] (__video_do_ioctl [videodev]) from
[<bf6ab19c>] (video_usercopy+0x508/0x5d4 [videodev])
[  155.471115] [<bf6ab19c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  155.479680] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  155.487184] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  155.494689] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  155.502451] Exception stack(0xd940dfa8 to 0xd940dff0)
[  155.507573] dfa0:                   d47c8700 b5f1e000 0000000c
40045612 befb4368 00000001
[  155.515866] dfc0: d47c8700 b5f1e000 40045612 00000036 b5e81e40
0000000c b6f41508 00000000
[  155.524160] dfe0: befb4368 befb4358 b5f07804 b5bdb1f0
[  155.529283] Code: e59f0040 e1a02001 e1a0100c ebf448dd (e7f001f2)
[  155.535464] ---[ end trace 4c04f89544a1aeeb ]---

> > > > I basically get the same crash for both options. Desktop is
> > > > LXDE on 32 bit Fedora 29.
> > > >
> > > > I've not yet tried with 5.0-rc1 but it looks like it has this patch
> > > > series and some other bits for the vchiq drivers in staging.
> > >
> > > Please try 5.0-rc1 which would be more helpful.
> >
> > Yes, it's on my list.

I get difference results with 5.0-rc1 but neither of the above apps
work either, will follow up based on the rest of the thread there.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
