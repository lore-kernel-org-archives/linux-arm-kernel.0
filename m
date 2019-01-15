Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EDF20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mv8DveYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EDF20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEwarfXFsv0iWQxtk43Mf73WhT7B2oryEzSEgGCo+SA=; b=mv8DveYWbiuqVR
	h4jN1xcJNKC2wrtc1MGa6URVVIXsBzLNtPqtK8cWKG8Pwn/HGDd1gQZTDYiTO/g52d0ZdliyLHGR1
	g66dnTinLjArBfJf5UPpRqm/pcyZGkgB3NeZlv9uIup8ORRAxWHjLbK54/2gxc2DE2A0gGHwlA1il
	nUXCIdnHQQsuouBfWGhxjPsvacrrHIpj+pFjiJCNDD3i1h92QsQL5GXlcDJpfRfwFfLfB6To33I5D
	PrmZmjggG56YQx8vbBuK35hXZ/hvjh/pcY3iPZWDLQnJTX7Jg6Vylmgi2in9XF86msHZ5HT0uCh+n
	OeQNeyWG/L5imefrMZsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjR5O-0005FN-O8; Tue, 15 Jan 2019 15:57:06 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjR5K-0005EG-9S
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:57:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C503F20A7D; Tue, 15 Jan 2019 16:56:58 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id 92A82209BC;
 Tue, 15 Jan 2019 16:56:48 +0100 (CET)
Date: Tue, 15 Jan 2019 09:23:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main
 pin controller
Message-ID: <20190115082333.be4rbnviczkujnt4@flea>
References: <20190115024543.12928-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115024543.12928-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_075702_604473_C8546B58 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 10:45:43AM +0800, Chen-Yu Tsai wrote:
> The H6 main pin controller has four banks of interrupt-triggering pins.
> The driver as originally submitted only specified three, but had pin
> descriptions referencing a fourth bank. This results in a out-of-bounds
> access into .irq_array of struct sunxi_pinctrl. This however did not
> result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
> data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
> region returned by devm_kcalloc(). The increase likely moved the
> out-of-bounds access into the next, unmapped page.
> 
> With KASAN on, the bug is quite clear:
> 
>     BUG: KASAN: slab-out-of-bounds in sunxi_pinctrl_init_with_variant+0x49c/0x12b8
>     Write of size 4 at addr ffff80002c680280 by task swapper/0/1
> 
>     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1-00016-gc480a5e6a077 #3
>     Hardware name: OrangePi Lite2 (DT)
>     Call trace:
>      dump_backtrace+0x0/0x220
>      show_stack+0x14/0x20
>      dump_stack+0xac/0xd4
>      print_address_description+0x60/0x25c
>      kasan_report+0x14c/0x1ac
>      __asan_store4+0x80/0xa0
>      sunxi_pinctrl_init_with_variant+0x49c/0x12b8
>      h6_pinctrl_probe+0x18/0x20
>      platform_drv_probe+0x6c/0xc8
>      really_probe+0x244/0x4b0
>      driver_probe_device.part.4+0x11c/0x164
>      __driver_attach+0x120/0x190
>      bus_for_each_dev+0xe8/0x158
>      driver_attach+0x30/0x40
>      bus_add_driver+0x308/0x318
>      driver_register+0xbc/0x1d0
>      __platform_driver_register+0x7c/0x88
>      h6_pinctrl_driver_init+0x18/0x20
>      do_one_initcall+0xd4/0x208
>      kernel_init_freeable+0x230/0x2c8
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x1c
> 
>     Allocated by task 1:
>      kasan_kmalloc.part.0+0x4c/0x100
>      kasan_kmalloc+0xc4/0xe8
>      kasan_slab_alloc+0x14/0x20
>      __kmalloc_track_caller+0x130/0x238
>      devm_kmalloc+0x34/0xd0
>      sunxi_pinctrl_init_with_variant+0x1d8/0x12b8
>      h6_pinctrl_probe+0x18/0x20
>      platform_drv_probe+0x6c/0xc8
>      really_probe+0x244/0x4b0
>      driver_probe_device.part.4+0x11c/0x164
>      __driver_attach+0x120/0x190
>      bus_for_each_dev+0xe8/0x158
>      driver_attach+0x30/0x40
>      bus_add_driver+0x308/0x318
>      driver_register+0xbc/0x1d0
>      __platform_driver_register+0x7c/0x88
>      h6_pinctrl_driver_init+0x18/0x20
>      do_one_initcall+0xd4/0x208
>      kernel_init_freeable+0x230/0x2c8
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x1c
> 
>     Freed by task 0:
>     (stack is not available)
> 
>     The buggy address belongs to the object at ffff80002c680080
>      which belongs to the cache kmalloc-512 of size 512
>     The buggy address is located 0 bytes to the right of
>      512-byte region [ffff80002c680080, ffff80002c680280)
>     The buggy address belongs to the page:
>     page:ffff7e0000b1a000 count:1 mapcount:0 mapping:ffff80002e00c780 index:0xffff80002c683c80 compound_mapcount: 0
>     flags: 0x10200(slab|head)
>     raw: 0000000000010200 ffff80002e003a10 ffff80002e003a10 ffff80002e00c780
>     raw: ffff80002c683c80 0000000000100001 00000001ffffffff 0000000000000000
>     page dumped because: kasan: bad access detected
> 
>     Memory state around the buggy address:
>      ffff80002c680180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      ffff80002c680200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     >ffff80002c680280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 		       ^
>      ffff80002c680300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff80002c680380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> Correct the number of IRQ banks so there are no more mismatches.
> 
> Fixes: c8a830904991 ("pinctrl: sunxi: add support for the Allwinner H6
> 		      main pin controller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
