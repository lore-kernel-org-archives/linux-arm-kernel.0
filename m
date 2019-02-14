Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7389EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:09:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3566B222DC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L9Ds3rTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3566B222DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C5vz6QCV7IcvlniApI5Oz+kzwgJQYI9plh1sjDL7zWM=; b=L9Ds3rTe8M/nMO
	4B/6/5AQWDwwSSwfcC/1SA+/5H0sLAf7F4XAk/MbjxzZwv9iNK0eDbmBxLTevFniFb6wqc+1IymVG
	KjzuHjZGFONmEdXcu9DP7udH31iUpAFq7lB1KzFJpnYSQz/mr8gvefy5vg7rMmxVzapCtWzMHIRIM
	si0PIoJp63lrRDN4EgAY9BfNX6imx8f5Wpe0fExo++Jm3sAH5FldexgK9/Ua2Dqr0T39IR5rwKPLx
	zAYm6iTtojtQHZgr8klsIVrYGRfhMyiy+dsiXwUDUqjudfVELmTOGLW90XOy0HQbX0hXg2dWppPHm
	uCarw7oGedx2fQb1Uz/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJZl-0006Os-Pu; Thu, 14 Feb 2019 16:09:25 +0000
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]
 helo=mtlfep01.bell.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJZi-0006OS-BW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:09:24 +0000
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net with ESMTP
 id <20190214160919.ZTVT28651.mtlfep01.bell.net@mtlspm01.bell.net>
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:09:19 -0500
Received: from [192.168.0.138] (really [64.231.92.241])
 by mtlspm01.bell.net with ESMTP
 id <20190214160918.YRND17436.mtlspm01.bell.net@[192.168.0.138]>;
 Thu, 14 Feb 2019 11:09:18 -0500
To: linux-arm-kernel@lists.infradead.org
From: John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Subject: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
Message-ID: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
Date: Thu, 14 Feb 2019 11:09:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=QLaHfkDL c=1 sm=0 tr=0
 a=jJmVOGxBrKxWvcjqaG+oVg==:17 a=IkcTkHD0fZMA:10 a=CFTnQlWoA9kA:10
 a=FBHGMhGWAAAA:8 a=Smh3QeV1BTCWqJYcBNAA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_080922_537645_33F3C204 
X-CRM114-Status: UNSURE (   6.87  )
X-CRM114-Notice: Please train this message.
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

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.0.0-rc6+ (root@espressobin) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #1 SMP PREEMPT Wed Feb 13
16:17:46 EST 2019
[    0.000000] Machine model: Globalscale Marvell ESPRESSOBin Board
[    0.000000] earlycon: ar3700_uart0 at MMIO 0x00000000d0012000 (options '')
[    0.000000] printk: bootconsole [ar3700_uart0] enabled
[    3.219693] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    3.225349] Modules linked in:
[    3.228489] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #1
[    3.234936] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
[    3.241568] pstate: 20000005 (nzCv daif -PAN -UAO)
[    3.246505] pc : dma_direct_map_page+0x48/0x1d8
[    3.251159] lr : mv_xor_channel_add+0x3b0/0xb28
[    3.255812] sp : ffffff8010033a60
[    3.259217] x29: ffffff8010033a60 x28: ffffffc03befec80
[    3.264682] x27: ffffff8010e97068 x26: 0000000000000000
[    3.270148] x25: 0000000000000029 x24: 0000000000000083
[    3.275613] x23: 0000000000000000 x22: 0000000000000002
[    3.281079] x21: 0000000000000080 x20: ffffff8010ecd000
[    3.286544] x19: 0000000000000000 x18: ffffffffffffffff
[    3.292010] x17: 00000000f8f63085 x16: 0000000074242664
[    3.297476] x15: ffffff8010ecd6c8 x14: ffffffc03bed9e83
[    3.302941] x13: ffffffc03bed9e82 x12: 0000000000000038
[    3.308407] x11: 0000000000001fff x10: 0000000000000001
[    3.313872] x9 : 0000000000000000 x8 : ffffff8010dbe000
[    3.319338] x7 : ffffff8010fbe000 x6 : ffffffbf00000000
[    3.324804] x5 : 0000000000000000 x4 : 0000000000000002
[    3.330269] x3 : 0000000000000002 x2 : 0000000000000eac
[    3.335735] x1 : ffffffbf00efbf80 x0 : 0000000000000000
[    3.341202] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    3.348100] Call trace:
[    3.350612]  dma_direct_map_page+0x48/0x1d8
[    3.354912]  mv_xor_channel_add+0x3b0/0xb28
[    3.359213]  mv_xor_probe+0x20c/0x4b8
[    3.362978]  platform_drv_probe+0x50/0xb0
[    3.367097]  really_probe+0x1fc/0x2c0
[    3.370860]  driver_probe_device+0x58/0x100
[    3.375160]  __driver_attach+0xd8/0xe0
[    3.379016]  bus_for_each_dev+0x68/0xc8
[    3.382957]  driver_attach+0x20/0x28
[    3.386631]  bus_add_driver+0x108/0x228
[    3.390572]  driver_register+0x60/0x110
[    3.394515]  __platform_driver_register+0x44/0x50
[    3.399357]  mv_xor_driver_init+0x18/0x20
[    3.403477]  do_one_initcall+0x58/0x170
[    3.407419]  kernel_init_freeable+0x190/0x234
[    3.411900]  kernel_init+0x10/0x108
[    3.415482]  ret_from_fork+0x10/0x1c
[    3.419157] Code: 2a0403f6 934cfc00 aa0503f7 7100047f (f9412663)
[    3.425438] ---[ end trace f62a451df663a071 ]---
[    3.430228] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    3.438060] SMP: stopping secondary CPUs
[    3.442093] Kernel Offset: disabled
[    3.445676] CPU features: 0x002,2000200c
[    3.449706] Memory Limit: none
[    3.452846] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

The same error occurs with linux-net 5.0.0-rc5 (91986ee166cf0816ae92668476ea7872d51b0c6e).  v4.20.x
boots okay.  Seems to be a hard failure.

Dave
-- 
John David Anglin  dave.anglin@bell.net

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
