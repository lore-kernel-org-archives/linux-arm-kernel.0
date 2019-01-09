Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC8BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348A621726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z15bo7dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348A621726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0FlqWQw+/2UelDSlzrB2gnaeNf6Zj3yLEHKNeXosUDE=; b=Z15bo7dK6qv/Hk
	7a1WGrAkxQe9h0nHwZ9w2owearWCAfrzLcljhJDRDZ0YfYE7z1HUfwrPSPfzf4nIN8Qtt+JZ+4OI+
	75KYpNjE1svaVBxXFje32AqywP18sLuhoJ262DUACmmG/MnNN7FQx6s1M7noGwDHrimbu9yqzDFae
	yck5KbzGgdWpkVFbeKNJpjFQJKrQPQY13ARFHRnuCFG8//iDrDo4XzQWtLikoeFefyWmQApi6u2af
	FqgMl66Sh4B+d/WLa18HbVOmoyvRtacCAuJkklLKCze/3iDCt1Qbka0DKPDt6vApeYW6P/NCuxHMa
	+kcuAvuWnm4pe37ZgRtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh9JC-00010K-1q; Wed, 09 Jan 2019 08:33:54 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh9J8-0000zg-PX; Wed, 09 Jan 2019 08:33:52 +0000
Received: from oxbsltgw08.schlund.de ([212.227.220.152]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQMi7-1gu7ik1AsT-00MI3i; Wed, 09 Jan 2019 09:33:39 +0100
Date: Wed, 9 Jan 2019 09:33:36 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Peter Robinson <pbrobinson@gmail.com>
Message-ID: <537778454.382280.1547022816273@email.ionos.de>
In-Reply-To: <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <CAAoAYcNJdzJW9X=hr5+5oAFWcVUexwY9zGQ_-T9X-M89jpnipQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Originating-Client: open-xchange-appsuite
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Provags-ID: V03:K1:L3lCpqJRvFQI8X/1zaFHpa4hkX2jUAmolpqR4egUYpgxna9Kxry
 Y7PlI5QVmLT3QcXg28G2JgI4z2J9m5b8VJtcqGDXYIAzjdQcshD2Ywa8XNwTDrgT/u4zjOh
 8nfSvl5B1O4UpGeKXBeaSNqzGLRgwBGEAMtymOos+NKWEL8MgjI/F+tjofbaT6EmzoznZm7
 H0LmTLF+Kmc5FAf8kMs6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wi072jfmW+o=:10IWK5d5Yb+BRnX3kR4I5e
 gJMjQlV/HFTia1Kj1Ci5tosmr529ahcqVIH5VQDoyn6j2Hiik9Cy5PfcY77j4XH/jgCtlJsm0
 1lfWxT1E/cjqthvQPNRbo971pvP1P2WOE8KC+GrS3OZIffPSlW3xFfmBkcVqevymnZD9SXSPB
 KYu1eHldJz+Vo++EaJgy4rHETBLXOtaD1p7FGArc8Scdj/CA92Wbw1JYSWtownE2FML7FBMAN
 77EtZyZpeA6u+0KIFLxMxJyTQJ/mSO5Ek596c41N/DEInTH+ZyD4fwMGmfHu/j03JRONRt6Tn
 UOn4y3rJ+FweCAXjrhkdKsMCajaCeaIv5sgTHojGPKwqaFNg2dVYM2w6mlkNWh/56uPsXD7Y/
 7gk4I39VUyE13sqzjGGmRGwX2I8qPUjBSmHpRjMqQKNn1K7Ry6USvLENvKSbnQvFzHzGaiAgv
 B6H11uSpp5PS9g/40a6M93zFp5tO9dNHfORxMQ3yZb1fyG1ghBR83BkVa5/SBO/ZV6I/A303A
 +GfJlnDjTvKN8ACkEd1gNL5rtOzyuW5VVCeX5NgiBCCNjOpq3zE9dkRYLxyeg01QL+J6UeE2m
 wkYmMhogTzr75ib1UlJOxH/q992rf4tpFiX+E5JkAQnnQ3q8LPK8r3ix8ahlz6kgOJVAGZ+8O
 2us09u79PKv/3b+BfnnNRdlQQ1/+eJ5QMwJxTLLICtz3SwlOdNiZdIlzHgnIH/bSNjDT9muW8
 bYc4HQImMM66/R5jDOetW10+LckE10f2ZgBDEOjI1em0gqrBMlVq+CvRnh4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_003351_132804_D886A771 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, tiwai@suse.de,
 Greg KH <gregkh@linuxfoundation.org>, mikebrady@eircom.net,
 Eric Anholt <eric@anholt.net>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

[add Arnd]

> Dave Stevenson <dave.stevenson@raspberrypi.org> hat am 8. Januar 2019 um 18:10
> geschrieben:
> 
> 
> Hi Peter
> 
> On Tue, 8 Jan 2019 at 07:21, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Stefan,
> >
> > > This patch series improves the load/unload of bcm2835 camera and audio
> > > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> > >
> > > This series based on current linux-next and Phil Elwell's series ("Improve
> > > VCHIQ
> > > cache line size handling"). After Nicolas' series ("staging:
> > > vc04_services:
> > > Some dead code removal") has been applied, i will rebase my series.
> >
> > I tried testing this series applied to 4.20 with the camera module. I
> > tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> > gstreamer. I basically get the same crash for both options. Desktop is
> > LXDE on 32 bit Fedora 29.
> >
> > I've not yet tried with 5.0-rc1 but it looks like it has this patch
> > series and some other bits for the vchiq drivers in staging.
> 
> I'm trying to sort the patches I have on our kernel tree and get them
> in a shape to get merged to staging.
> I've built for 5.0.0-rc1 and also see the same error using:
> v4l2-ctl -v width=640,height=480,pixelformat=YU12
> v4l2-ctl --stream-mmap=3 --stream-to=/dev/null --stream-count=300
> 

i wasn't able to reproduce this issue yet (Raspberry Pi 3, Firmware:
2018-12-18 + 2018-11-12). qv4l2 and cheese from recent Raspbian shows an greenish image but
works.

I tried to capture a video with cheese but this seems to hang and after some
time i terminated cheese and got this kernel output:

[  238.330187] bcm2835_v4l2: timed out waiting for sync completion
[  238.330202] bcm2835-v4l2: Failed disabling camera, ret -62
[  238.330206] bcm2835-v4l2: Failed to disable camera
[  238.330211] ------------[ cut here ]------------
[  238.330239] WARNING: CPU: 3 PID: 1259 at
drivers/media/common/videobuf2/videobuf2-core.c:1852
__vb2_queue_cancel+0x1d8/0x24c [videobuf2_common]
[  238.330242] Modules linked in: cmac bcm2835_v4l2(C) v4l2_common
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
media snd_bcm2835(C) brcmfmac sha256_generic sha256_arm vc4 snd_soc_core
ac97_bus snd_pcm_dmaengine snd_pcm snd_timer cfg80211 snd crc32_arm_ce
raspberrypi_hwmon soundcore brcmutil hci_uart btbcm bluetooth bcm2835_thermal
ecdh_generic vchiq(C) phy_generic microchip lan78xx
[  238.330328] CPU: 3 PID: 1259 Comm: v4l2src1:src Tainted: G         C
       5.0.0-rc1-g3bd6e94be #2
[  238.330331] Hardware name: BCM2835
[  238.330359] [<c031234c>] (unwind_backtrace) from [<c030cd64>]
(show_stack+0x10/0x14)
[  238.330373] [<c030cd64>] (show_stack) from [<c0e33830>]
(dump_stack+0x8c/0xa0)
[  238.330388] [<c0e33830>] (dump_stack) from [<c0345e00>] (__warn+0xe0/0xf8)
[  238.330401] [<c0345e00>] (__warn) from [<c0345f30>]
(warn_slowpath_null+0x40/0x48)
[  238.330421] [<c0345f30>] (warn_slowpath_null) from [<bf4f60b0>]
(__vb2_queue_cancel+0x1d8/0x24c [videobuf2_common])
[  238.330466] [<bf4f60b0>] (__vb2_queue_cancel [videobuf2_common]) from
[<bf4f7a0c>] (vb2_core_queue_release+0x18/0x38 [videobuf2_common])
[  238.330490] [<bf4f7a0c>] (vb2_core_queue_release [videobuf2_common]) from
[<bf5059e8>] (_vb2_fop_release+0x74/0x84 [videobuf2_v4l2])
[  238.330533] [<bf5059e8>] (_vb2_fop_release [videobuf2_v4l2]) from
[<bf4be428>] (v4l2_release+0x94/0xd8 [videodev])
[  238.330571] [<bf4be428>] (v4l2_release [videodev]) from [<c0480054>]
(__fput+0x84/0x1c8)
[  238.330588] [<c0480054>] (__fput) from [<c03640a0>] (task_work_run+0xa8/0xcc)
[  238.330604] [<c03640a0>] (task_work_run) from [<c0349984>]
(do_exit+0x3a4/0xa90)
[  238.330618] [<c0349984>] (do_exit) from [<c034af30>]
(do_group_exit+0x3c/0xd0)
[  238.330634] [<c034af30>] (do_group_exit) from [<c03563a0>]
(get_signal+0x24c/0x6d8)
[  238.330647] [<c03563a0>] (get_signal) from [<c030c184>]
(do_work_pending+0x150/0x5a8)
[  238.330659] [<c030c184>] (do_work_pending) from [<c030106c>]
(slow_work_pending+0xc/0x20)
[  238.330665] Exception stack(0xe589ffb0 to 0xe589fff8)
[  238.330674] ffa0:                                     ab203ea0 00000002
00000000 00000000
[  238.330685] ffc0: 00000008 00000002 ab203ea0 00000150 00000000 009bfd80
ffffffff ffffffff
[  238.330695] ffe0: ab1fe54c ab1fe558 00000000 b6155d68 80000010 ab203ea0
[  238.330701] ---[ end trace 38eb902c180397fe ]---
[  238.330710] videobuf2_common: driver bug: stop_streaming operation is leaving
buf a00b2206 in active state
[  238.330717] videobuf2_common: driver bug: stop_streaming operation is leaving
buf c6a3f306 in active state
[  238.330723] videobuf2_common: driver bug: stop_streaming operation is leaving
buf d3723ebf in active state
[  238.330728] videobuf2_common: driver bug: stop_streaming operation is leaving
buf fd514935 in active state

But i noticed a regression introduced in 5.0-rc1, which might be related. I
tried to run "vchiq_test -f 1" and it never completes. After reverting commit
852b2876a8a8 ("staging: vchiq: rework remove_event handling") vchiq_test [1]
works as expected again.

Regards
Stefan

[1] -
https://github.com/raspberrypi/userland/blob/master/interface/vchiq_arm/vchiq_test.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
