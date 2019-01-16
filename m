Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA864C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864CB20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tZ5AK0vx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdQpeuIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864CB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CFUWy3h63ICN14cjmIAuUc4+jdf7EV/RZTBCflB3yhg=; b=tZ5
	AK0vxVW9gbRHyC8pzR5SHmAY9ln66z8BNepSeR/qpdsTkHFLuFnPvxC4KDPOHX8d7U3NoIgkrkBj0
	UcCp+apvzPOVoiXjLZ94EMPAF7kziUf+ru9BJ1+7reB5IxggtnfxdaXlmDSMJ8chKiZ+HO60AYCBq
	2d+s0BvjqfCKIEKbOT0lCUbGz8sWnMPr/V2sFJRmj4f0Y2aCLrqTcA/s3lx1RLw8mW5eyEhWv3pVR
	quBjT466nIRmtURMyUFHRVQQnsUwCddeR+0JdaCebgqC7ueIRLPzg+OXmnYVu82/oX+ycRGDMRDGW
	GY9Tti9o/bHuToKgWwEuXPjC6Df0zTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgwi-0003Ci-4L; Wed, 16 Jan 2019 08:53:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgwe-0003By-Jh
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:53:10 +0000
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F15420896
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547628787;
 bh=rfXvYttg4cT6f4bSX7fa0VUZoRH/KzVfbLos6r3fYmQ=;
 h=From:Date:Subject:To:From;
 b=LdQpeuIa2v9Y58dSjnkQAOMJiadjlkuX45droosi9Nm9/h8mfln3NoT4YVjOVxbqz
 qqD4b4iQwfbnFF8EWFJxaj6f72nL4oCpHUgqFVzWuPNfFkNEYwVe5xA5kAELmHAP9m
 NHdQ+MdR4JjDyrnXroSWKbfdNcFaXXP606I8sHl4=
Received: by mail-lj1-f172.google.com with SMTP id v15-v6so4700919ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 00:53:07 -0800 (PST)
X-Gm-Message-State: AJcUukfykc0ae/TJ0bWt+TzJDlNr9ldZWeyELgxw2Rps70LjqVe/DW2X
 w0gMGFXF6e2am8JrSGJHdIGT10fQLycmhTmQrG0=
X-Google-Smtp-Source: ALg8bN4Eb0ZIFUuVyNcwvhXLDbYBA2Tdv883OUA/iMmBlZ9DukvQ7w87uAuRm6w6jaWgbwsZxh5L/Q9r2cJIenRPREc=
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr5515396ljf.82.1547628785511; 
 Wed, 16 Jan 2019 00:53:05 -0800 (PST)
MIME-Version: 1.0
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Jan 2019 09:52:54 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
Message-ID: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
Subject: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount disk
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>, 
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, 
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_005308_697854_181BEC30 
X-CRM114-Status: GOOD (  10.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On today's next-20190116 I see a bug during boot:
[ 6.843308] kernel BUG at ../block/bio.c:1833!
[ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
...
[ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
[ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)

(not much in the calltrace)
On all my boards. Also QEMU-arm fails.

Ultimately the target fails to mount /home from SD card (although root
is from NFSv4):
    Timed out waiting for device dev-disk-by\x2dlabel-home.device.

Full console logs:
https://krzk.eu/#/builders/25/builds/1079/steps/12/logs/serial0
https://krzk.eu/#/builders/1/builds/3031/steps/12/logs/serial0

1. Arch ARM Linux
2. exynos_defconfig
  - All my Odroid boards (ARMv7, Exynos)
  - Odroid HC1, U3, XU3, XU
  - Systemd
3. All boards boot from TFTP with NFS root (NFSv4)

The QEMU arm fails with more information:

[ 0.596078] loop: module loaded
[ 0.601633] virtio_blk virtio0: [vda] 10240 512-byte logical blocks
(5.24 MB/5.00 MiB)
[ 0.603320] Internal error: Oops - undefined instruction: 0 [#1] ARM
[ 0.603504] Modules linked in:
[ 0.603784] CPU: 0 PID: 1 Comm: swapper Tainted: G W
5.0.0-rc2-next-20190116-gcbeb3db #1
[ 0.603905] Hardware name: ARM-Versatile Express
[ 0.604329] PC is at bio_split+0x5c/0x64
[ 0.604461] LR is at blk_queue_split+0x47c/0x5f4
[ 0.604553] pc : [<8036e2c4>] lr : [<80376134>] psr: 60000013
[ 0.604652] sp : 8681f878 ip : 00000000 fp : 8699df00
[ 0.604750] r10: 8681f914 r9 : 00000000 r8 : 0000007e
[ 0.604838] r7 : 00000000 r6 : 8547ac28 r5 : 00000000 r4 : 00000000
[ 0.604937] r3 : 8547b068 r2 : 00600000 r1 : 00000000 r0 : 8699df00
[ 0.605070] Flags: nZCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment none
[ 0.605185] Control: 10c5387d Table: 60004059 DAC: 00000051
[ 0.605338] Process swapper (pid: 1, stack limit = 0x(ptrval))
...
[ 0.619332] [<8036e2c4>] (bio_split) from [<80376134>]
(blk_queue_split+0x47c/0x5f4)
[ 0.619480] [<80376134>] (blk_queue_split) from [<8037bee8>]
(blk_mq_make_request+0x80/0x3bc)
[ 0.619608] [<8037bee8>] (blk_mq_make_request) from [<80371840>]
(generic_make_request+0x1b0/0x364)
[ 0.619733] [<80371840>] (generic_make_request) from [<80371a8c>]
(submit_bio+0x98/0x194)
[ 0.619850] [<80371a8c>] (submit_bio) from [<8020e1b8>]
(submit_bh_wbc.constprop.21+0x154/0x17c)
[ 0.619980] [<8020e1b8>] (submit_bh_wbc.constprop.21) from
[<80210634>] (block_read_full_page+0x3b0/0x3d0)
[ 0.620109] [<80210634>] (block_read_full_page) from [<8019139c>]
(do_read_cache_page+0x180/0x33c)
[ 0.620237] [<8019139c>] (do_read_cache_page) from [<8019156c>]
(read_cache_page+0x14/0x1c)
[ 0.620388] [<8019156c>] (read_cache_page) from [<80383be4>]
(read_dev_sector+0x2c/0xbc)
[ 0.620508] [<80383be4>] (read_dev_sector) from [<80386e7c>]
(read_lba+0x134/0x1b4)
[ 0.620623] [<80386e7c>] (read_lba) from [<80387234>] (efi_partition+0xbc/0x8e8)
[ 0.620741] [<80387234>] (efi_partition) from [<80386114>]
(check_partition+0x11c/0x1e8)
[ 0.620856] [<80386114>] (check_partition) from [<80384298>]
(rescan_partitions+0x94/0x45c)
[ 0.620971] [<80384298>] (rescan_partitions) from [<80213230>]
(__blkdev_get+0x260/0x404)
[ 0.621087] [<80213230>] (__blkdev_get) from [<802134d8>]
(blkdev_get+0x104/0x2f4)
[ 0.621206] [<802134d8>] (blkdev_get) from [<80382f9c>]
(__device_add_disk+0x498/0x4fc)
[ 0.621325] [<80382f9c>] (__device_add_disk) from [<804317f0>]
(virtblk_probe+0x444/0x744)
[ 0.621444] [<804317f0>] (virtblk_probe) from [<803d3df0>]
(virtio_dev_probe+0x258/0x330)
[ 0.621561] [<803d3df0>] (virtio_dev_probe) from [<80415864>]
(really_probe+0xf4/0x2c8)
[ 0.621675] [<80415864>] (really_probe) from [<80415b9c>]
(driver_probe_device+0x60/0x16c)
[ 0.621788] [<80415b9c>] (driver_probe_device) from [<80415d84>]
(__driver_attach+0xdc/0xe0)
[ 0.621911] [<80415d84>] (__driver_attach) from [<80413d3c>]
(bus_for_each_dev+0x68/0xb4)
[ 0.622024] [<80413d3c>] (bus_for_each_dev) from [<80414e04>]
(bus_add_driver+0x100/0x20c)
[ 0.622137] [<80414e04>] (bus_add_driver) from [<804166b0>]
(driver_register+0x78/0x10c)
[ 0.622253] [<804166b0>] (driver_register) from [<8091b5e4>] (init+0x70/0x9c)
[ 0.622403] [<8091b5e4>] (init) from [<801025ec>] (do_one_initcall+0x54/0x194)
[ 0.622525] [<801025ec>] (do_one_initcall) from [<80900e14>]
(kernel_init_freeable+0x12c/0x1c8)
[ 0.622658] [<80900e14>] (kernel_init_freeable) from [<80628c08>]
(kernel_init+0x8/0x110)
[ 0.622776] [<80628c08>] (kernel_init) from [<801010e8>]
(ret_from_fork+0x14/0x2c)
[ 0.622887] Exception stack(0x8681ffb0 to 0x8681fff8)
[ 0.623021] ffa0: 00000000 00000000 00000000 00000000
[ 0.623242] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[ 0.623438] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 0.623747] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
[ 0.624241] ---[ end trace 925652e8270d42ae ]---
[ 0.624904] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b

https://pastebin.com/tKqNv033
QEMU setup:
1. Yocto Linux
2. Custom VF50 defconfig
3. Machine: Vexpress A9
4. DTB: vexpress-v2p-ca9
5. Memory: 128 MB

Let me know if you need any more data.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
