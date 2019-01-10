Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7221C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A597820657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ii8AZJ1b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWiHu74X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A597820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yYBY+c9ZdkRl5CWupJP7gBeIomIf7vIV9cW9Y5miajc=; b=Ii8AZJ1bMP/oAY
	yudb8j6j7hDCdvFXms9kxeuosM1G+CEkR8WjiM3HCm7QzHpcw2CZyU6sU6jh8lTb4MgR8A6JhXjxp
	UmBjL8jPMlwedIHCGfU74BoZaIQzXxSiw/JBFWcGHOtMfrpSW/5TN1i+DDKGf4yiBojUofCHIeJ7D
	HtEVxtO6PjHwSQ0kw144aE0NvuReD9OW9LRdxhScDRhBfYj28+cGliOx7IGvJLSzi5vgLsXyiUG3e
	UZXqeE6vCDsCEyOhS4KMiuCYs2bcCdMa4IPV7I/XMmYQfnlHn+zKEjtTjNfbMxLWEw2+Q1wNjRUcc
	wlqTij6qBVZYJQRSKrxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUPN-0001Ub-OJ; Thu, 10 Jan 2019 07:05:41 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUPJ-0001U5-GP; Thu, 10 Jan 2019 07:05:39 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so10071653wra.6;
 Wed, 09 Jan 2019 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mpbsgn3w8p9zXJCd57n/3W1Sd7O4KtTN2ExuRO+aA1c=;
 b=NWiHu74Xhr7jGonsEUS6Q/0xm5tZ+aH8VzIFNe4d83TMfZpfUuE0aDkWbmnLafThj1
 V6tr7fdB0qTa62SWGiD/zHJ59IoU9C25XHL1xVc8jUvsU+G28hi/Wp0gs9SAVy9OSvbw
 w5rH+0siDgHU4yT8bRh2RYXb/hJ5En7WuNDxUVQq9/ykPj/L+IcpvqLtAusakGJqE6b/
 vle4NUrm/2e1qy1hRG5b5Cu8AGDyR7SRglWL5c2A1sFvpjUif3My59cuPwfhtF+/vhDL
 9C9MwEIHFWkm0lk8pbETg6U9KRwRAFRh86zvcWcLi8EkIN7zXWATizlxAF0rOURHTGA7
 WEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mpbsgn3w8p9zXJCd57n/3W1Sd7O4KtTN2ExuRO+aA1c=;
 b=ZOoJW7Ow0EyOGDegLHpWHNOqP6Cq0P3FFH79bqrV5dDRw0peQNDHXvekFEzbOpSD1A
 wYAFSXnSM/jFc9wcfQQ1OY08dKEM9FWa1+Tiqws4aCO/jK6vrk34y3M1o28TYpruvN5n
 HUuGADReySbUJZ/2g9RZAAAhNOJ4kwWs5hU73QOro1Otme67gl/xS0ixeiieqrijsD2l
 f/q/bi9Ip81ALeoCeGHl0Yr8hcw7ONO+XzZnCSgCIPbCRUPTJXeTEN2kqu0guvY1GXkF
 lg5wmqy+DYHlrUKRI/vsgM0yao13r36V+5Ug+Oe5saSOJtWy5O5VZYPSkweNkUEMopgs
 0WCQ==
X-Gm-Message-State: AJcUukeYjC8McJSmcJ2VJ7EydfkJeWF44zToLMcf0yyHPJ8tSEpIm2NS
 jz8Cb3T+CIZduWtDb7rxUhgA3nNU4VfzqXCpypI=
X-Google-Smtp-Source: ALg8bN4ojphochaZ37BQILrukvLHP/BFE/c+xKheHBwXBP4TQp+vGZEx7N+VnUaee7o10Vz63nL6QLijNwA5c6YDcjY=
X-Received: by 2002:adf:c108:: with SMTP id r8mr8136299wre.233.1547103935687; 
 Wed, 09 Jan 2019 23:05:35 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
 <2090321804.324042.1547101471247@email.ionos.de>
In-Reply-To: <2090321804.324042.1547101471247@email.ionos.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 10 Jan 2019 07:05:23 +0000
Message-ID: <CALeDE9P89QFB8CsY1xRyT1+bau+Hzkj7tmc81e6-Lq9nEpjJ-w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_230537_576372_FEEF2593 
X-CRM114-Status: GOOD (  11.50  )
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

> > I get difference results with 5.0-rc1 but neither of the above apps
> > work either, will follow up based on the rest of the thread there.
> >
>
> My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
>
> start_x=1
> gpu_mem=128
>
> AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.

OK with that, plus my 4.20.1 kernel (and the 09/01/19 firmware) I'm
starting to get somewhere.

I can get a picture with the qv4l2 app ;-)

If I try with cheese I get the following two crashes, I then tried
with qv4l2 again (no reboot) and got the final crash, basically once
cheese/gstreamer pokes it tht's it and it doesn't come back. The
"Comm: v4l2src0:src" are the cheese/gstreamer crash.

[   26.013706] vchiq: module is from the staging directory, the
quality is unknown, you have been warned.
[   26.040943] vchiq: vchiq_init_state: slot_zero = 415842fa, is_master = 0
[   26.937936] media: Linux media interface: v0.10
[   27.052339] videodev: Linux video capture interface: v2.00
[   27.351732] snd_bcm2835: module is from the staging directory, the
quality is unknown, you have been warned.
[   27.385975] bcm2835_audio bcm2835_audio: card created with 8 channels
[   27.406702] bcm2835_v4l2: module is from the staging directory, the
quality is unknown, you have been warned.
[   28.059932] bcm2835-v4l2: scene mode selected 0, was 0
[   28.061098] bcm2835-v4l2: V4L2 device registered as video0 - stills
mode > 1280x720
[   28.074773] bcm2835-v4l2: Broadcom 2835 MMAL video capture ver 0.0.2 loaded.
[   78.307961] bcm2835_audio bcm2835_audio: vchi message timeout, msg=5
[  138.790296] bcm2835-v4l2: Failed to enable capture port - error -1.
Disabling camera port again
[  138.818456] ------------[ cut here ]------------
[  138.823246] WARNING: CPU: 2 PID: 1464 at
drivers/media/common/videobuf2/videobuf2-core.c:1471
vb2_start_streaming+0xb4/0x12c [videobuf2_common]
[  138.836377] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
vfat fat vc4 snd_soc_core bcm2835_v4l2(C) snd_bcm2835(C)
videobuf2_vmalloc ac97_bus snd_pcm_dmaengine videobuf2_memops
videobuf2_v4l2 snd_seq videobuf2_common snd_seq_device snd_pcm
v4l2_common videodev brcmfmac media snd_timer snd brcmutil soundcore
drm_kms_helper cfg80211 drm hci_uart fb_sys_fops syscopyarea btqca
sysfillrect btbcm joydev sysimgblt btintel bluetooth raspberrypi_hwmon
ecdh_generic rfkill vchiq(C) bcm2835_thermal bcm2835_rng bcm2835_wdt
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block sdhci_iproc dwc2
crc32_arm_ce sdhci_pltfm
[  138.836522]  gpio_raspberrypi_exp udc_core sdhci pwm_bcm2835
i2c_bcm2835 bcm2835 bcm2835_dma phy_generic
[  138.934289] CPU: 2 PID: 1464 Comm: v4l2src0:src Tainted: G
C        4.20.1-200.fc29.armv7hl #1
[  138.943729] Hardware name: BCM2835
[  138.947196] [<c03127a4>] (unwind_backtrace) from [<c030cbf0>]
(show_stack+0x18/0x1c)
[  138.955058] [<c030cbf0>] (show_stack) from [<c0b14f80>]
(dump_stack+0x80/0xa0)
[  138.962390] [<c0b14f80>] (dump_stack) from [<c03507b4>] (__warn+0xdc/0xf8)
[  138.969366] [<c03507b4>] (__warn) from [<c0350b28>]
(warn_slowpath_null+0x40/0x4c)
[  138.977070] [<c0350b28>] (warn_slowpath_null) from [<bf70b2d4>]
(vb2_start_streaming+0xb4/0x12c [videobuf2_common])
[  138.987713] [<bf70b2d4>] (vb2_start_streaming [videobuf2_common])
from [<bf70c78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  139.000054] [<bf70c78c>] (vb2_core_streamon [videobuf2_common])
from [<bf681a34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  139.011453] [<bf681a34>] (__video_do_ioctl [videodev]) from
[<bf68219c>] (video_usercopy+0x508/0x5d4 [videodev])
[  139.021827] [<bf68219c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  139.030391] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  139.037896] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  139.045398] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  139.053160] Exception stack(0xd0b2ffa8 to 0xd0b2fff0)
[  139.058281] ffa0:                   00000000 aa812138 0000001e
40045612 01658708 b590cd10
[  139.066577] ffc0: 00000000 aa812138 ab8af99c 00000036 00000020
b6f388f8 01658700 aa80cc90
[  139.074869] ffe0: b5b4dcec a69fa974 ab8786f4 b590cd1c
[  139.080031] ---[ end trace eed7fb71749a2e2c ]---
[  139.211923] bcm2835-v4l2: vidioc_s_fmt_vid_cap device busy
[  177.331656] bcm2835-v4l2: Failed to enable capture port - error -1.
Disabling camera port again
[  177.362943] ------------[ cut here ]------------
[  177.367736] WARNING: CPU: 1 PID: 1531 at
drivers/media/common/videobuf2/videobuf2-core.c:1471
vb2_start_streaming+0xb4/0x12c [videobuf2_common]
[  177.380847] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
vfat fat vc4 snd_soc_core bcm2835_v4l2(C) snd_bcm2835(C)
videobuf2_vmalloc ac97_bus snd_pcm_dmaengine videobuf2_memops
videobuf2_v4l2 snd_seq videobuf2_common snd_seq_device snd_pcm
v4l2_common videodev brcmfmac media snd_timer snd brcmutil soundcore
drm_kms_helper cfg80211 drm hci_uart fb_sys_fops syscopyarea btqca
sysfillrect btbcm joydev sysimgblt btintel bluetooth raspberrypi_hwmon
ecdh_generic rfkill vchiq(C) bcm2835_thermal bcm2835_rng bcm2835_wdt
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block sdhci_iproc dwc2
crc32_arm_ce sdhci_pltfm
[  177.381107]  gpio_raspberrypi_exp udc_core sdhci pwm_bcm2835
i2c_bcm2835 bcm2835 bcm2835_dma phy_generic
[  177.479003] CPU: 1 PID: 1531 Comm: v4l2src0:src Tainted: G
WC        4.20.1-200.fc29.armv7hl #1
[  177.488452] Hardware name: BCM2835
[  177.491936] [<c03127a4>] (unwind_backtrace) from [<c030cbf0>]
(show_stack+0x18/0x1c)
[  177.499807] [<c030cbf0>] (show_stack) from [<c0b14f80>]
(dump_stack+0x80/0xa0)
[  177.507148] [<c0b14f80>] (dump_stack) from [<c03507b4>] (__warn+0xdc/0xf8)
[  177.514137] [<c03507b4>] (__warn) from [<c0350b28>]
(warn_slowpath_null+0x40/0x4c)
[  177.521863] [<c0350b28>] (warn_slowpath_null) from [<bf70b2d4>]
(vb2_start_streaming+0xb4/0x12c [videobuf2_common])
[  177.532507] [<bf70b2d4>] (vb2_start_streaming [videobuf2_common])
from [<bf70c78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  177.544926] [<bf70c78c>] (vb2_core_streamon [videobuf2_common])
from [<bf681a34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  177.556424] [<bf681a34>] (__video_do_ioctl [videodev]) from
[<bf68219c>] (video_usercopy+0x508/0x5d4 [videodev])
[  177.566859] [<bf68219c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  177.575434] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  177.582949] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  177.590465] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  177.598233] Exception stack(0xc9e49fa8 to 0xc9e49ff0)
[  177.603363] 9fa0:                   00000000 aa9100e8 0000001f
40045612 011a78a0 b59aed10
[  177.611666] 9fc0: 00000000 aa9100e8 ab9c899c 00000036 00000020
b6fda8f8 011a7898 aa907720
[  177.619967] 9fe0: b5befcec a6afa974 ab9916f4 b59aed1c
[  177.625167] ---[ end trace eed7fb71749a2e2d ]---
[  177.761663] bcm2835-v4l2: vidioc_s_fmt_vid_cap device busy
[  218.865174] Unable to handle kernel NULL pointer dereference at
virtual address 00000001
[  218.873455] pgd = 4a1eb2da
[  218.876252] [00000001] *pgd=00000000
[  218.879920] Internal error: Oops: 5 [#1] SMP ARM
[  218.884610] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
vfat fat vc4 snd_soc_core bcm2835_v4l2(C) snd_bcm2835(C)
videobuf2_vmalloc ac97_bus snd_pcm_dmaengine videobuf2_memops
videobuf2_v4l2 snd_seq videobuf2_common snd_seq_device snd_pcm
v4l2_common videodev brcmfmac media snd_timer snd brcmutil soundcore
drm_kms_helper cfg80211 drm hci_uart fb_sys_fops syscopyarea btqca
sysfillrect btbcm joydev sysimgblt btintel bluetooth raspberrypi_hwmon
ecdh_generic rfkill vchiq(C) bcm2835_thermal bcm2835_rng bcm2835_wdt
leds_gpio cpufreq_dt lz4 lz4_compress zram hid_logitech_hidpp
hid_logitech_dj smsc95xx usbnet mii mmc_block sdhci_iproc dwc2
crc32_arm_ce sdhci_pltfm
[  218.884870]  gpio_raspberrypi_exp udc_core sdhci pwm_bcm2835
i2c_bcm2835 bcm2835 bcm2835_dma phy_generic
[  218.982626] CPU: 3 PID: 1552 Comm: qv4l2 Tainted: G        WC
 4.20.1-200.fc29.armv7hl #1
[  218.991458] Hardware name: BCM2835
[  218.994955] PC is at vchiq_mmal_port_enable+0x90/0x138 [bcm2835_v4l2]
[  219.001501] LR is at _cond_resched+0x48/0x50
[  219.005831] pc : [<bf793ec0>]    lr : [<c0b2a8b4>]    psr: 00070013
[  219.012209] sp : c6727d90  ip : 002dc121  fp : 00000001
[  219.017518] r10: bf69a200  r9 : df278004  r8 : dffe6380
[  219.022821] r7 : df278000  r6 : bf79a880  r5 : bf78f600  r4 : df278490
[  219.029443] r3 : 00000001  r2 : df278518  r1 : 00000001  r0 : 00000000
[  219.036069] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  219.043309] Control: 10c5383d  Table: 1276806a  DAC: 00000051
[  219.049145] Process qv4l2 (pid: 1552, stack limit = 0x266508dd)
[  219.055151] Stack: (0xc6727d90 to 0xc6728000)
[  219.059578] 7d80:                                     df278000
df278490 bf78f600 dffe6000
[  219.067885] 7da0: dffe6660 bf79a880 bf67da08 dffe6380 c6727e78
bf69a200 00000001 bf78fa54
[  219.076189] 7dc0: c6727dcc 00000004 d090ee78 00000008 dffe6528
dffe64dc dffe6624 bf70b28c
[  219.084493] 7de0: dffe6528 00000000 dffe6058 bf67da08 dffe6380
bf70c78c 40045612 bf681a34
[  219.092800] 7e00: c6727e2c c04babdc e39a99bc bf7951f4 c328d200
00000000 d6be1b40 c328d200
[  219.101103] 7e20: c124f850 00000004 c6727e7c c04c0b90 c6727e78
c031691c c6727e78 00000000
[  219.109407] 7e40: c6727e78 00000000 bf6816d8 40045612 00000000
00000004 00000000 bf68219c
[  219.117710] 7e60: 0007ffff 00000000 00000000 bedf8368 d6be1b40
00000001 00000001 00000001
[  219.126015] 7e80: 00000000 00002003 00000000 00000000 00000000
00000000 00000000 00000000
[  219.134318] 7ea0: 00000000 00000000 00000001 05cf1000 01efb000
00000000 00000000 00000000
[  219.142623] 7ec0: 00002000 00000000 a1743000 e27e93c0 c3a1d738
c3a1d730 a1743000 c049bad0
[  219.150926] 7ee0: 00000001 00000003 01efb000 c0b2a8b4 00000000
c0b2a8b4 df801c30 bedf8368
[  219.159230] 7f00: df801c30 d6be1b40 40045612 bedf8368 0000000c
00000036 00000000 c04ffae8
[  219.167532] 7f20: bedf8368 c0500308 00000001 00000056 00000012
c6727f48 00000001 e31dd210
[  219.175837] 7f40: c3400bb0 c6725612 c6727f0b c6727f3c 2262e000
00000000 c6727f58 c126ab28
[  219.184141] 7f60: d6be1b40 40045612 00000000 d6be1b40 d6be1b41
40045612 bedf8368 0000000c
[  219.192445] 7f80: 00000036 c0500b0c 47d64200 b5f11000 40045612
00000036 c0301204 c6726000
[  219.200750] 7fa0: 00000036 c0301000 47d64200 b5f11000 0000000c
40045612 bedf8368 00000001
[  219.209053] 7fc0: 47d64200 b5f11000 40045612 00000036 b5e74e40
0000000c b6f34508 00000000
[  219.217357] 7fe0: bedf8368 bedf8358 b5efa804 b5bce1f0 400f0010
0000000c 00000000 00000000
[  219.225785] [<bf793ec0>] (vchiq_mmal_port_enable [bcm2835_v4l2])
from [<bf78fa54>] (start_streaming+0x124/0x1f0 [bcm2835_v4l2])
[  219.237498] [<bf78fa54>] (start_streaming [bcm2835_v4l2]) from
[<bf70b28c>] (vb2_start_streaming+0x6c/0x12c [videobuf2_common])
[  219.249221] [<bf70b28c>] (vb2_start_streaming [videobuf2_common])
from [<bf70c78c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
[  219.261644] [<bf70c78c>] (vb2_core_streamon [videobuf2_common])
from [<bf681a34>] (__video_do_ioctl+0x35c/0x494 [videodev])
[  219.273142] [<bf681a34>] (__video_do_ioctl [videodev]) from
[<bf68219c>] (video_usercopy+0x508/0x5d4 [videodev])
[  219.283585] [<bf68219c>] (video_usercopy [videodev]) from
[<c04ffae8>] (vfs_ioctl+0x28/0x3c)
[  219.292163] [<c04ffae8>] (vfs_ioctl) from [<c0500308>]
(do_vfs_ioctl+0x8c/0x838)
[  219.299678] [<c0500308>] (do_vfs_ioctl) from [<c0500b0c>]
(ksys_ioctl+0x58/0x74)
[  219.307193] [<c0500b0c>] (ksys_ioctl) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  219.314966] Exception stack(0xc6727fa8 to 0xc6727ff0)
[  219.320095] 7fa0:                   47d64200 b5f11000 0000000c
40045612 bedf8368 00000001
[  219.328400] 7fc0: 47d64200 b5f11000 40045612 00000036 b5e74e40
0000000c b6f34508 00000000
[  219.336699] 7fe0: bedf8368 bedf8358 b5efa804 b5bce1f0
[  219.341831] Code: e1a00007 ebfffbd4 e1a01000 ea000007 (e5911000)
[  219.348216] ---[ end trace eed7fb71749a2e2e ]---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
