Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A625C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593CE20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aeSJsENu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593CE20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m1/RjY9TPJrSCRbIRngHxrH8tbVdiTxjSQOeTRfD488=; b=aeSJsENuGGskfN
	ohxfHBT93/lJ0q5aiKV1TYGLsicOLAfwUjhMzDcR8GN2cIzTyAQLHdaZwyntITVYo3zhafbQ2FONE
	pjzKkn4Qy/VQjHk3unXISPK3N8udtje5MN2dO8Aszma4NHQhTLO8aRCFctsXS9wvqD9AutNw4PTFP
	rbeEPsJjwUS/Po7aqdcXzOB3VxuHUqC7tG6nd5LoVAVLH3OarqL2Oct+2lKZ1XQj+EMKNe3k3KtKh
	yVrhCQJc0plqg6+tfNF2P4gMv4nLH1JX6XEM35eaq8GTBWfD/AwCPpUhzGaNtrzrMi8hpFPut22zE
	kMGtjEujiSHSY1UcwCfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjEji-00021l-Qi; Tue, 15 Jan 2019 02:45:54 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjEje-0001zc-Um
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 02:45:52 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id F0B965FCA8; Tue, 15 Jan 2019 10:45:44 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main pin
 controller
Date: Tue, 15 Jan 2019 10:45:43 +0800
Message-Id: <20190115024543.12928-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_184551_256494_3032CDCC 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The H6 main pin controller has four banks of interrupt-triggering pins.
The driver as originally submitted only specified three, but had pin
descriptions referencing a fourth bank. This results in a out-of-bounds
access into .irq_array of struct sunxi_pinctrl. This however did not
result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
region returned by devm_kcalloc(). The increase likely moved the
out-of-bounds access into the next, unmapped page.

With KASAN on, the bug is quite clear:

    BUG: KASAN: slab-out-of-bounds in sunxi_pinctrl_init_with_variant+0x49c/0x12b8
    Write of size 4 at addr ffff80002c680280 by task swapper/0/1

    CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1-00016-gc480a5e6a077 #3
    Hardware name: OrangePi Lite2 (DT)
    Call trace:
     dump_backtrace+0x0/0x220
     show_stack+0x14/0x20
     dump_stack+0xac/0xd4
     print_address_description+0x60/0x25c
     kasan_report+0x14c/0x1ac
     __asan_store4+0x80/0xa0
     sunxi_pinctrl_init_with_variant+0x49c/0x12b8
     h6_pinctrl_probe+0x18/0x20
     platform_drv_probe+0x6c/0xc8
     really_probe+0x244/0x4b0
     driver_probe_device.part.4+0x11c/0x164
     __driver_attach+0x120/0x190
     bus_for_each_dev+0xe8/0x158
     driver_attach+0x30/0x40
     bus_add_driver+0x308/0x318
     driver_register+0xbc/0x1d0
     __platform_driver_register+0x7c/0x88
     h6_pinctrl_driver_init+0x18/0x20
     do_one_initcall+0xd4/0x208
     kernel_init_freeable+0x230/0x2c8
     kernel_init+0x10/0x108
     ret_from_fork+0x10/0x1c

    Allocated by task 1:
     kasan_kmalloc.part.0+0x4c/0x100
     kasan_kmalloc+0xc4/0xe8
     kasan_slab_alloc+0x14/0x20
     __kmalloc_track_caller+0x130/0x238
     devm_kmalloc+0x34/0xd0
     sunxi_pinctrl_init_with_variant+0x1d8/0x12b8
     h6_pinctrl_probe+0x18/0x20
     platform_drv_probe+0x6c/0xc8
     really_probe+0x244/0x4b0
     driver_probe_device.part.4+0x11c/0x164
     __driver_attach+0x120/0x190
     bus_for_each_dev+0xe8/0x158
     driver_attach+0x30/0x40
     bus_add_driver+0x308/0x318
     driver_register+0xbc/0x1d0
     __platform_driver_register+0x7c/0x88
     h6_pinctrl_driver_init+0x18/0x20
     do_one_initcall+0xd4/0x208
     kernel_init_freeable+0x230/0x2c8
     kernel_init+0x10/0x108
     ret_from_fork+0x10/0x1c

    Freed by task 0:
    (stack is not available)

    The buggy address belongs to the object at ffff80002c680080
     which belongs to the cache kmalloc-512 of size 512
    The buggy address is located 0 bytes to the right of
     512-byte region [ffff80002c680080, ffff80002c680280)
    The buggy address belongs to the page:
    page:ffff7e0000b1a000 count:1 mapcount:0 mapping:ffff80002e00c780 index:0xffff80002c683c80 compound_mapcount: 0
    flags: 0x10200(slab|head)
    raw: 0000000000010200 ffff80002e003a10 ffff80002e003a10 ffff80002e00c780
    raw: ffff80002c683c80 0000000000100001 00000001ffffffff 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff80002c680180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     ffff80002c680200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    >ffff80002c680280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
		       ^
     ffff80002c680300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff80002c680380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Correct the number of IRQ banks so there are no more mismatches.

Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6
		      main pin controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
index aa8b58125568..ef4268cc6227 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
@@ -588,7 +588,7 @@ static const unsigned int h6_irq_bank_map[] = { 1, 5, 6, 7 };
 static const struct sunxi_pinctrl_desc h6_pinctrl_data = {
 	.pins = h6_pins,
 	.npins = ARRAY_SIZE(h6_pins),
-	.irq_banks = 3,
+	.irq_banks = 4,
 	.irq_bank_map = h6_irq_bank_map,
 	.irq_read_needs_mux = true,
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
