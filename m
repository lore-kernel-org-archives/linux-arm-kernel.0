Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3721421773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELB0RDuN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSBjkDI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3721421773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MR6WHgnhQp6TFSyFWXSpUQyPGStCwl7HHuchCUHw+OU=; b=ELB
	0RDuNad3yg+zkrqCOrgKeKn4uY2peeYj2i9EX24eUTkmNvp2SK9vadt+lbxdVE8H54dS9hG58B4O9
	jHXsDXkyyI0WG/z9DxQOZ2fyFJ9sfnctmcCQbpNl/nUv3vpoHLKyxyi48cFAlfb+v2zy7NO65dHKb
	NJS83na0JxILp/5c0r3JORMKdILK7Y70yZvvT8sD5MEpx6gFgZFBA0clf8PTLfOBtYcN74qJ/v7RG
	5rPIuByafIeQRAYNoupyoUecSU5g50rAJKTi8X+hm0ejHQcojA5dKEXZ+LrIuPdRDY1rzOSpb2Cia
	eW+g2AotrevzpDgV2Ucpj4NuOQJFVrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8ar-0003M7-Sk; Tue, 19 Feb 2019 16:50:05 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8an-0002qP-3p
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:50:02 +0000
Received: by mail-pl1-x641.google.com with SMTP id d15so3558617plr.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=B2VKAD0UxqNA8Steehxbgu6qDZa4biIz9/CEmlJKQN8=;
 b=mSBjkDI3USrO6pu1VpmMXcUL/UC54E7Mmpf+HwgmxmOG3LXt03KaH6zHQwVGmYj9Fz
 Nbm0/qHjqdrVJxCwxQEFV+oKXTzANTJewQg3nLhA88C1N4u9fxPhL3Cpg+wxfrsupam9
 0y+su0YB2GoTl/RP6xSutzxdLy2A6u57VYoPJ5suzXv9ES4ze2NYAWm85axGw5JWHzVw
 MuzmLJl0J+FPMkFJrE2Ww7N91wvnYqQHMPYID22po9tcd6RGJrBc8Mer3yAHStd6EDkx
 K13zWt1d3B/6IgkPCvJ+I3O7STeVSbLqTzkIkrT+LUqtI5ILmVrUF0Vqb3NGfsSoUyoF
 YjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=B2VKAD0UxqNA8Steehxbgu6qDZa4biIz9/CEmlJKQN8=;
 b=E+SUwWa9QAeeKnmHEiPKzaSul4C93qo5TIeVfqCwFZ8bqUwDCaxY28+PeN0AbDrDXa
 jslrIIfssKfGWcyJe05RYPUq1bxawyANarI3F69UergrpngCIbAU/6cfRuuTxh+bpwR6
 d9NIU+fFvTIRThhxfO9yww0xnpcf/6ufcSp2PEia4HzccCohpgget+YCFNSNo9aWs7Zc
 jJZ0zbthTvNmG8U+k7guwl36cwUv2xEKvLMpNR/h6bSQ83m4UJpi0CWSZ4KQrZV9eONs
 HxMHRWs2P78QWherlNBzjZlHoDhGpjORKXNZG/IR7mIWDF9aMp8e1GYONrHT/WjQRdNl
 d8tQ==
X-Gm-Message-State: AHQUAuYYBU+TpfkBwB/tZFMq/p4sr5qsl1RiBOm8bvlZ3nHsbIoH3F2X
 gyr/WggJB4NrJtMdfhdVpzlXdhpE
X-Google-Smtp-Source: AHgI3Ib3vn54919FgTLq8OaDOFUnwF49IgCjjOCeu/shK+Saw2cs1q27jT8WX1GDUT2pWSw96p03vQ==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr23276419pla.44.1550594998657; 
 Tue, 19 Feb 2019 08:49:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o26sm17516313pfk.139.2019.02.19.08.49.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 08:49:57 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] xsysace: Fix error handling in ace_setup
Date: Tue, 19 Feb 2019 08:49:56 -0800
Message-Id: <1550594996-11453-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_085001_205236_D9665D9A 
X-CRM114-Status: GOOD (  15.49  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If xace hardware reports a bad version number, the error handling code
in ace_setup() calls put_disk(), followed by queue cleanup. However, since
the disk data structure has the queue pointer set, put_disk() also
cleans and releases the queue. This results in blk_cleanup_queue()
accessing an already released data structure, which in turn may result
in a crash such as the following.

[   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
[   10.681826] Faulting instruction address: 0xc0431480
[   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
[   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
[   10.682387] Modules linked in:
[   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
[   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
[   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
[   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
[   10.683236] DEAR: 00000040 ESR: 00000000
[   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000
[   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000
[   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000
[   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800
[   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
[   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
[   10.684602] Call Trace:
[   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
[   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
[   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
[   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
[   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
[   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
[   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
[   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
[   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
[   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
[   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
[   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
[   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
[   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
[   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
[   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
[   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
[   10.687188] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
[   10.687349] Instruction dump:
[   10.687435] 3863ffd4 4bfffd70 9421ffd0 7c0802a6 93c10028 7c9e2378 93e1002c 38810008
[   10.687637] 7c7f1b78 90010034 4bfffc25 813f008c <81290040> 75290100 4182002c 80810008
[   10.688056] ---[ end trace 13c9ff51d41b9d40 ]---

Fix the problem by setting the disk queue pointer to NULL before calling
put_disk(). A more comprehensive fix might be to rearrange the code
to check the hardware version before initializing data structures,
but I don't know if this would have undesirable side effects, and
it would increase the complexity of backporting the fix to older kernels.

Fixes: 74489a91dd43a ("Add support for Xilinx SystemACE CompactFlash interface")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/block/xsysace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 87ccef4bd69e..32a21b8d1d85 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1090,6 +1090,8 @@ static int ace_setup(struct ace_device *ace)
 	return 0;
 
 err_read:
+	/* prevent double queue cleanup */
+	ace->gd->queue = NULL;
 	put_disk(ace->gd);
 err_alloc_disk:
 	blk_cleanup_queue(ace->queue);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
