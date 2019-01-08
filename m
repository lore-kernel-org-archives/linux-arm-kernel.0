Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:11:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02B620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M8W/xTYO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="nQfiIM6V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="OvVhZGfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02B620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EBbPRKkvyevsdsoGfJr9OBS3vjhnwxWJC7d30Lu+vZ8=; b=M8W/xTYO+kbeio
	BrlENLY6DOYEKJTeow7bbXV6z4Ka9tnVONVLgwyjYbtvAy9Ley6yga5k2yTN9igEOVjdH3UuZhBld
	eY/hUWSg4Xzhbt4ZAtptO+X4gpzg38NlNfC4CHVcTsz9t3oSgwrbSZUEVO2f3+6V9MOX2MwUmvCTI
	9qQyllJ9fu4yXoz7panb9KRHdIxRXX0APvO/xql1Awh2XoOU1RwYtKViETHa36/6d61nr1fhh47yH
	mrOvh+GfDcGGh1O/CLuLs/1u4kBkIz6UAKYnIr7fswhq1+/9q9rRExv+w1tCMO7NujrLFBwSpdgZo
	y9p4nhiHeo5ugC92MsoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguuH-00034n-Mf; Tue, 08 Jan 2019 17:11:13 +0000
Received: from mx08-00252a01.pphosted.com ([91.207.212.211])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguuB-0002xI-ND
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:11:11 +0000
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
 by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x08H8X8p018186
 for <linux-arm-kernel@lists.infradead.org>; Tue, 8 Jan 2019 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pp; bh=k24f+EivTpiKzokBhaHG7XiehfmIkMYLGyOyQ6G5ZAU=;
 b=nQfiIM6VEhTKfThcQDFU7Ss8hSNwm9rNVdYoqHPCRja/uuOqVujrJ23s1NOokv3XY964
 Jm5YcGatdBhiw0C6oW7heegADZMB3mJGJORXuKC/bqDeiaIWknOO6yW4kpiMQBfS8cu9
 tZfN1pk9x1RMB+GykSvkujw5BYpWDxw+G1kXi4KVgDCkyfj+pbsxA+5vM4D3/CnHflH/
 ItBVTQap2LHc0EJf1LUGK8hGZnz8cEyv+yOJYsaSVF5Q/TogbQH9oKPZc8sBdwZbp9+M
 PNLVKYvLtlG3XsvWRmwREDVuqbo/pVFeq+aw/HTGkj2XKjvT5D5JIAj2V+AN6X5G+hCp 3g== 
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx08-00252a01.pphosted.com with ESMTP id 2ptjuu9m5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <linux-arm-kernel@lists.infradead.org>; Tue, 08 Jan 2019 17:11:02 +0000
Received: by mail-pg1-f199.google.com with SMTP id q62so2384010pgq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 09:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k24f+EivTpiKzokBhaHG7XiehfmIkMYLGyOyQ6G5ZAU=;
 b=OvVhZGflclL/ajrlVTPtzXx1vIYYp7dI1Fl14RaqAL04qsW1IE2fEn2IVhlI5ltftL
 OqhCUI0ai8WDBDC1lR0YErvph30ccPnE81PHdUHI06wYJoaKs4KdeoxDxYydlcmY9dKr
 UiQwYPyhoU1C1AYJNpq18RC6JUmWfBzWgtC56NmDNMGgjOi66TuqTxBreGC5VDNkZIW4
 96DXmGu248BoXOhxTpkxyD9g35r3aVj/fuKL1JJgT/FTy7op/bYqZqqnqnZ+4TkCnm8a
 6v/6yR2QqwYmvaroChBFmBwkHYNCnEz/VeYciCIjBLes+Xb8IMYkU3yAFoa+7tMlDr0B
 VKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k24f+EivTpiKzokBhaHG7XiehfmIkMYLGyOyQ6G5ZAU=;
 b=mJjnsUeLc0CnUWV0T7qOHS2PJ31taZvvt6B2kYs0dvIGQtu0kT/h9AvSG9B0R9axmE
 tjd2SMAqP6bxjR5eHY6dw8nc7y+wEzXXPFsKv91uf8VMUpJojZfWdqbLDuud049LEvWa
 rbaYIkLrAghJL1bGYLRxN6EQjxMuyeaHWM11HkMVgeL2AYs0V/YL3aDFFSY381+355qo
 zYvBcfvGpYhq/GzAK56Efsajfq+pzxWHMpC9DyaSh1mi30Kxi3IMpjKG+yDvPM/qfPhZ
 ibZFfAs2LyHOBd5zMQ50+5FrkywUmx6rx5cdOUi4rQDYl2OJ19dW4dX4pgM5I/x8S4dG
 pBgg==
X-Gm-Message-State: AJcUukeoyZm+30oEtOCM7FvgeL1SIyZUcLIZiMQEz0/29qdwci2ZhoKs
 +ddPyMnDw1R2eG7Ua6AFqOY1uPof7eoyqTG4/69BWyhjc8ZzIgc0PQ+ROh1myC9lulAzRH4P9mP
 dDf0WWIDPkKB78M6WoQBWVjMqakUZwEzbww3bwyYknq28gkrJNg==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr2397082ple.73.1546967460178; 
 Tue, 08 Jan 2019 09:11:00 -0800 (PST)
X-Google-Smtp-Source: ALg8bN56hp58NVBpKWv2slGHZwP9fchdn8EfsazylaLsei08KQosbBj74byIyZVMwLHNNpkICIimHoFWizMC5RLAxr8=
X-Received: by 2002:a17:902:442:: with SMTP id 60mr2397046ple.73.1546967459730; 
 Tue, 08 Jan 2019 09:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
In-Reply-To: <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.org>
Date: Tue, 8 Jan 2019 17:10:46 +0000
Message-ID: <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
To: Peter Robinson <pbrobinson@gmail.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_091108_318660_DC0BED4D 
X-CRM114-Status: GOOD (  22.43  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, mikebrady@eircom.net,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter

On Tue, 8 Jan 2019 at 07:21, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Stefan,
>
> > This patch series improves the load/unload of bcm2835 camera and audio
> > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> >
> > This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
> > cache line size handling"). After Nicolas' series ("staging: vc04_services:
> > Some dead code removal") has been applied, i will rebase my series.
>
> I tried testing this series applied to 4.20 with the camera module. I
> tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> gstreamer. I basically get the same crash for both options. Desktop is
> LXDE on 32 bit Fedora 29.
>
> I've not yet tried with 5.0-rc1 but it looks like it has this patch
> series and some other bits for the vchiq drivers in staging.

I'm trying to sort the patches I have on our kernel tree and get them
in a shape to get merged to staging.
I've built for 5.0.0-rc1 and also see the same error using:
v4l2-ctl -v width=640,height=480,pixelformat=YU12
v4l2-ctl --stream-mmap=3 --stream-to=/dev/null --stream-count=300

It's three independent things:
- The firmware has failed the failed to enable the camera for reasons unknown.
- The error path then hasn't returned all the buffers to videobuf2,
hence the warning from videobuf2-core.c:1468
- The driver has then tried to pass some buffers to MMAL / VCHI which
tries adding them to an invalid list.

I'm investigating why the firmware is failing to enable the camera
initially, and then look at cleaning up the error handling.

  Dave

> Peter
>
> [  231.121704] bcm2835-v4l2: Failed enabling camera, ret -2
> [  231.127168] bcm2835-v4l2: Failed to enable camera
> [  231.132030] ------------[ cut here ]------------
> [  231.136852] WARNING: CPU: 2 PID: 1473 at
> drivers/media/common/videobuf2/videobuf2-core.c:1468
> vb2_start_streaming+0xb4/0x12c [videobuf2_common]
> [  231.149967] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
> nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
> ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
> nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
> ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
> vfat fat brcmfmac brcmutil vc4 cfg80211 snd_soc_core bcm2835_v4l2(C)
> ac97_bus snd_bcm2835(C) videobuf2_vmalloc snd_pcm_dmaengine
> videobuf2_memops snd_seq videobuf2_v4l2 videobuf2_common
> snd_seq_device v4l2_common snd_pcm videodev media snd_timer snd
> soundcore drm_kms_helper drm hci_uart btqca joydev btbcm btintel
> fb_sys_fops syscopyarea bluetooth sysfillrect gpio_raspberrypi_exp
> sysimgblt raspberrypi_hwmon bcm2835_thermal ecdh_generic vchiq(C)
> rfkill bcm2835_wdt bcm2835_rng leds_gpio cpufreq_dt lz4 lz4_compress
> zram hid_logitech_hidpp hid_logitech_dj smsc95xx usbnet mii mmc_block
> dwc2 sdhci_iproc crc32_arm_ce
> [  231.150208]  sdhci_pltfm udc_core sdhci bcm2835 pwm_bcm2835
> i2c_bcm2835 bcm2835_dma phy_generic
> [  231.248013] CPU: 2 PID: 1473 Comm: qv4l2 Tainted: G         C
>  4.20.0-1.fc30.armv7hl #1
> [  231.256663] Hardware name: BCM2835
> [  231.260144] [<c03127a4>] (unwind_backtrace) from [<c030cbf0>]
> (show_stack+0x18/0x1c)
> [  231.268013] [<c030cbf0>] (show_stack) from [<c0b14340>]
> (dump_stack+0x80/0xa0)
> [  231.275357] [<c0b14340>] (dump_stack) from [<c03507b4>] (__warn+0xdc/0xf8)
> [  231.282349] [<c03507b4>] (__warn) from [<c0350b28>]
> (warn_slowpath_null+0x40/0x4c)
> [  231.290067] [<c0350b28>] (warn_slowpath_null) from [<bf4d82d4>]
> (vb2_start_streaming+0xb4/0x12c [videobuf2_common])
> [  231.300747] [<bf4d82d4>] (vb2_start_streaming [videobuf2_common])
> from [<bf4d978c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
> [  231.313166] [<bf4d978c>] (vb2_core_streamon [videobuf2_common])
> from [<bf44ea34>] (__video_do_ioctl+0x35c/0x494 [videodev])
> [  231.324681] [<bf44ea34>] (__video_do_ioctl [videodev]) from
> [<bf44f19c>] (video_usercopy+0x508/0x5d4 [videodev])
> [  231.335120] [<bf44f19c>] (video_usercopy [videodev]) from
> [<c04ffae0>] (vfs_ioctl+0x28/0x3c)
> [  231.343697] [<c04ffae0>] (vfs_ioctl) from [<c0500300>]
> (do_vfs_ioctl+0x8c/0x838)
> [  231.351212] [<c0500300>] (do_vfs_ioctl) from [<c0500b04>]
> (ksys_ioctl+0x58/0x74)
> [  231.358726] [<c0500b04>] (ksys_ioctl) from [<c0301000>]
> (ret_fast_syscall+0x0/0x54)
> [  231.366493] Exception stack(0xd7d53fa8 to 0xd7d53ff0)
> [  231.371623] 3fa0:                   4a1bf700 b5edd000 0000000c
> 40045612 be905378 00000001
> [  231.379930] 3fc0: 4a1bf700 b5edd000 40045612 00000036 b5e40e40
> 0000000c b6f00508 00000000
> [  231.388230] 3fe0: be905378 be905368 b5ec6804 b5b9a1f0
> [  231.393434] ---[ end trace c5943cec7bb25669 ]---
> [  237.695591] list_add corruption. prev->next should be next
> (ea4493e0), but was efeb6638. (prev=e126fa78).
> [  237.705362] ------------[ cut here ]------------
> [  237.710056] kernel BUG at lib/list_debug.c:28!
> [  237.714569] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [  237.719785] Modules linked in: fuse ip6t_rpfilter ip6t_REJECT
> nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat nf_nat_ipv6
> ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4
> nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink
> ebtable_filter ebtables ip6table_filter ip6_tables cmac bnep sunrpc
> vfat fat brcmfmac brcmutil vc4 cfg80211 snd_soc_core bcm2835_v4l2(C)
> ac97_bus snd_bcm2835(C) videobuf2_vmalloc snd_pcm_dmaengine
> videobuf2_memops snd_seq videobuf2_v4l2 videobuf2_common
> snd_seq_device v4l2_common snd_pcm videodev media snd_timer snd
> soundcore drm_kms_helper drm hci_uart btqca joydev btbcm btintel
> fb_sys_fops syscopyarea bluetooth sysfillrect gpio_raspberrypi_exp
> sysimgblt raspberrypi_hwmon bcm2835_thermal ecdh_generic vchiq(C)
> rfkill bcm2835_wdt bcm2835_rng leds_gpio cpufreq_dt lz4 lz4_compress
> zram hid_logitech_hidpp hid_logitech_dj smsc95xx usbnet mii mmc_block
> dwc2 sdhci_iproc crc32_arm_ce
> [  237.720008]  sdhci_pltfm udc_core sdhci bcm2835 pwm_bcm2835
> i2c_bcm2835 bcm2835_dma phy_generic
> [  237.817717] CPU: 1 PID: 1473 Comm: qv4l2 Tainted: G        WC
>  4.20.0-1.fc30.armv7hl #1
> [  237.826365] Hardware name: BCM2835
> [  237.829831] PC is at __list_add_valid+0x44/0x84
> [  237.834426] LR is at __list_add_valid+0x44/0x84
> [  237.839020] pc : [<c069b958>]    lr : [<c069b958>]    psr: 600f0093
> [  237.845377] sp : d7d53da0  ip : 00000000  fp : 00000001
> [  237.850676] r10: 600f0013  r9 : ea4493e0  r8 : ea4493e8
> [  237.855979] r7 : eb773000  r6 : eb773278  r5 : e126fa78  r4 : ea449358
> [  237.862602] r3 : ef707cb0  r2 : 2e5c6000  r1 : ef704548  r0 : 0000005d
> [  237.869226] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [  237.876555] Control: 10c5383d  Table: 17d0406a  DAC: 00000051
> [  237.882390] Process qv4l2 (pid: 1473, stack limit = 0xdf044251)
> [  237.888394] Stack: (0xd7d53da0 to 0xd7d54000)
> [  237.892823] 3da0: ea449358 bf55f20c ea31f800 eb773000 ea31fe24
> bf44aa08 ea31fb80 d7d53e78
> [  237.901130] 3dc0: bf467200 bf55a22c eb773000 00000000 00000001
> ea31fd28 eb773000 bf4d8278
> [  237.909435] 3de0: ea31fd28 00000000 ea31f858 bf44aa08 ea31fb80
> bf4d978c 40045612 bf44ea34
> [  237.917738] 3e00: d7d53e2c c04babd4 ef8eb210 bf5601f4 ecf68f00
> 00000000 d7c51900 ecf68f00
> [  237.926042] 3e20: c124f850 00000004 d7d53e7c c04c0b88 d7d53e78
> c031691c d7d53e78 00000000
> [  237.934345] 3e40: d7d53e78 00000000 bf44e6d8 40045612 00000000
> 00000004 00000000 bf44f19c
> [  237.942648] 3e60: 0007ffff 00000000 00000000 be9052b0 d7c51900
> 00000001 00000001 00000001
> [  237.950949] 3e80: 00000000 00002003 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  237.959251] 3ea0: 00000000 00000000 00000001 00240000 000c0000
> 00000000 00000000 00000000
> [  237.967560] 3ec0: 00002000 00000000 ac5f2000 ec4171e0 ed793cd8
> ed793cd0 ac5f2000 c049bac8
> [  237.975863] 3ee0: 00000001 00000003 000c0000 c0b29c74 00000000
> c0b29c74 c2c46570 be9052b0
> [  237.984167] 3f00: c2c46570 d7c51900 40045612 be9052b0 0000000c
> 00000036 00000000 c04ffae0
> [  237.992470] 3f20: be9052b0 c0500300 00000001 00000056 00000012
> d7d53f48 00000001 ef1fee10
> [  238.000775] 3f40: ee4e3660 d7d55612 d7d53f0b d7d53f3c 00400100
> 00000000 d7d53f58 c126aa48
> [  238.009079] 3f60: d7c51900 40045612 00000000 d7c51900 d7c51901
> 40045612 be9052b0 0000000c
> [  238.017383] 3f80: 00000036 c0500b04 4a1bf700 b5edd000 40045612
> 00000036 c0301204 d7d52000
> [  238.025686] 3fa0: 00000036 c0301000 4a1bf700 b5edd000 0000000c
> 40045612 be9052b0 00000001
> [  238.033990] 3fc0: 4a1bf700 b5edd000 40045612 00000036 b5e40e40
> 0000000c b6f00508 00000000
> [  238.042293] 3fe0: be9052b0 be9052a0 b5ec6804 b5b9a1f0 400f0010
> 0000000c 00000000 00000000
> [  238.050651] [<c069b958>] (__list_add_valid) from [<bf55f20c>]
> (vchiq_mmal_submit_buffer+0x4c/0x74 [bcm2835_v4l2])
> [  238.061170] [<bf55f20c>] (vchiq_mmal_submit_buffer [bcm2835_v4l2])
> from [<bf55a22c>] (buffer_queue+0x58/0x90 [bcm2835_v4l2])
> [  238.072618] [<bf55a22c>] (buffer_queue [bcm2835_v4l2]) from
> [<bf4d8278>] (vb2_start_streaming+0x58/0x12c [videobuf2_common])
> [  238.084053] [<bf4d8278>] (vb2_start_streaming [videobuf2_common])
> from [<bf4d978c>] (vb2_core_streamon+0x110/0x138 [videobuf2_common])
> [  238.096479] [<bf4d978c>] (vb2_core_streamon [videobuf2_common])
> from [<bf44ea34>] (__video_do_ioctl+0x35c/0x494 [videodev])
> [  238.107976] [<bf44ea34>] (__video_do_ioctl [videodev]) from
> [<bf44f19c>] (video_usercopy+0x508/0x5d4 [videodev])
> [  238.118414] [<bf44f19c>] (video_usercopy [videodev]) from
> [<c04ffae0>] (vfs_ioctl+0x28/0x3c)
> [  238.126988] [<c04ffae0>] (vfs_ioctl) from [<c0500300>]
> (do_vfs_ioctl+0x8c/0x838)
> [  238.134502] [<c0500300>] (do_vfs_ioctl) from [<c0500b04>]
> (ksys_ioctl+0x58/0x74)
> [  238.142019] [<c0500b04>] (ksys_ioctl) from [<c0301000>]
> (ret_fast_syscall+0x0/0x54)
> [  238.149787] Exception stack(0xd7d53fa8 to 0xd7d53ff0)
> [  238.154915] 3fa0:                   4a1bf700 b5edd000 0000000c
> 40045612 be9052b0 00000001
> [  238.163219] 3fc0: 4a1bf700 b5edd000 40045612 00000036 b5e40e40
> 0000000c b6f00508 00000000
> [  238.171519] 3fe0: be9052b0 be9052a0 b5ec6804 b5b9a1f0
> [  238.176657] Code: e59f0040 e1a02001 e1a0100c ebf44a37 (e7f001f2)
> [  238.182843] ---[ end trace c5943cec7bb2566a ]---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
