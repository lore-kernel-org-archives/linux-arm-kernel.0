Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:31:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237DA20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBFiv2Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237DA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ou35JXOrB2Tw6Q3592KSKqvnR85Jvdvs41lKfMDFIo=; b=sBFiv2SlW7XoNM
	MRCYrvqsk/Q1ZDIhabAp1kPy110USXj/PQXzQKWvnp07N/36+LftwVEJoByAjVuYINMVfiyJySH01
	fB/1CsPLrGlCmTfIU450DdAfPTWBvUwtdWKMJxFmFZS7kYuqfP9cVtb42SlpZY96hiMjgUvv0nDgI
	/Vkm+mtrl5MI727FVSgkWlBicAkN125vKHb2BNvOun6AcME9u3qlxSR+QXDJ4+iF52IHTv1h4XQ+Z
	MMLmzfKB7xjZP1eZPp7HeRek8mNhmP2tMmD0ttW/GFuSAKvJI0leIkRgNc0XZIv72xLxhKjUAxkv6
	8wsiOe5Sf9T/VYHpJ3jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcvyg-0004Fk-Mb; Fri, 28 Dec 2018 17:31:18 +0000
Received: from dliviu.plus.com ([80.229.23.120] helo=smtp.dudau.co.uk)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcvya-0004Es-SR
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 17:31:16 +0000
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
 by smtp.dudau.co.uk (Postfix) with SMTP id F222B41080C1;
 Fri, 28 Dec 2018 17:30:57 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation);
 Fri, 28 Dec 2018 17:30:57 +0000
Date: Fri, 28 Dec 2018 17:30:57 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping in
 get_arch_dma_ops
Message-ID: <20181228173057.GA20342@bart.dudau.co.uk>
References: <20181214150240.26427-1-hch@lst.de> <20181219165502.GA25904@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181219165502.GA25904@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_093113_388130_F17690B8 
X-CRM114-Status: GOOD (  16.46  )
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
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 05:55:02PM +0100, Christoph Hellwig wrote:
> As all maintainers seem to be off to their holidays already I've
> applied this now given that I don't want to leave arm64 in broken
> state in linux-next any longer.

Hi Christoph,

Talking about linux-next being broken, I found out that with
next-20181224 the nvme driver with an HMB NVMe SSD (Toshiba RC-100)
also fails on a RK3399 board (NanoPC T4). It works with v4.20 just fine.

The reason for linking it to your patchset is that I get this on
next-20181224 (the DMA addresses looks the same for the allocated buffers):

.......
[    3.731134] rockchip-pcie f8000000.pcie: Looking up vpcie12v-supply from device tree
[    3.731177] rockchip-pcie f8000000.pcie: Looking up vpcie12v-supply property in node /pcie@f8000000 failed
[    3.731277] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    3.731858] rockchip-pcie f8000000.pcie: Looking up vpcie3v3-supply from device tree
[    3.732021] rockchip-pcie f8000000.pcie: Linked as a consumer to regulator.2
[    3.732661] rockchip-pcie f8000000.pcie: Looking up vpcie1v8-supply from device tree
[    3.732695] rockchip-pcie f8000000.pcie: Looking up vpcie1v8-supply property in node /pcie@f8000000 failed
[    3.732777] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
[    3.733351] rockchip-pcie f8000000.pcie: Looking up vpcie0v9-supply from device tree
[    3.733384] rockchip-pcie f8000000.pcie: Looking up vpcie0v9-supply property in node /pcie@f8000000 failed
[    3.733465] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
[    3.795175] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
[    3.795834] rockchip-pcie f8000000.pcie: Parsing ranges property...
[    3.795910] rockchip-pcie f8000000.pcie:   MEM 0xfa000000..0xfbdfffff -> 0xfa000000
[    3.796628] rockchip-pcie f8000000.pcie:    IO 0xfbe00000..0xfbefffff -> 0xfbe00000
[    3.797781] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
[    3.798384] pci_bus 0000:00: root bus resource [bus 00-1f]
[    3.798956] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
[    3.799580] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
[    3.800431] pci_bus 0000:00: scanning bus
[    3.800516] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
[    3.800819] pci 0000:00:00.0: supports D1
[    3.800835] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    3.800860] pci 0000:00:00.0: PME# disabled
[    3.808046] pci_bus 0000:00: fixups for bus
[    3.808079] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    3.808097] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    3.808847] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    3.809130] pci_bus 0000:01: scanning bus
[    3.809224] pci 0000:01:00.0: [1179:0113] type 00 class 0x010802
[    3.809416] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    3.809647] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    3.810436] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    3.811536] pci 0000:01:00.0: PME# supported from D0 D3hot
[    3.811569] pci 0000:01:00.0: PME# disabled
[    3.811862] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x2 link at 0000:00:00.0 (capable of 15.752 Gb/s with 8 GT/s x2 link)
[    3.820219] pci_bus 0000:01: fixups for bus
[    3.820239] pci_bus 0000:01: bus scan returning with max=01
[    3.820261] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    3.820291] pci_bus 0000:00: bus scan returning with max=01
[    3.820361] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
[    3.820994] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff 64bit]
[    3.821702] pci 0000:00:00.0: PCI bridge to [bus 01]
[    3.822167] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
[    3.823242] pcieport 0000:00:00.0: assign IRQ: got 229
[    3.823281] pcieport 0000:00:00.0: enabling device (0000 -> 0002)

...... (nvme compiled as module, modprobed from shell) .....

[   50.938888] nvme 0000:01:00.0: assign IRQ: got 229
[   50.939441] nvme nvme0: pci function 0000:01:00.0
[   50.940189] pcieport 0000:00:00.0: enabling bus mastering
[   50.940226] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[   50.940784] nvme 0000:01:00.0: enabling bus mastering
[   51.097451] nvme nvme0: allocated 38 MiB host memory buffer.
[   51.097970] nvme nvme0: 0x000000001d8ec924 -> [0xffff000000000000, 0x400]
[   51.098609] nvme nvme0: 0x00000000bd00b691 -> [0xffff000000000000, 0x400]
[   51.099215] nvme nvme0: 0x0000000098e20ad2 -> [0xffff000000000000, 0x400]
[   51.099820] nvme nvme0: 0x000000003a390633 -> [0xffff000000000000, 0x400]
[   51.100423] nvme nvme0: 0x000000001cddf671 -> [0xffff000000000000, 0x400]
[   51.101026] nvme nvme0: 0x000000002587680f -> [0xffff000000000000, 0x400]
[   51.101629] nvme nvme0: 0x00000000bc2c89f9 -> [0xffff000000000000, 0x400]
[   51.102232] nvme nvme0: 0x000000005b3ef3ef -> [0xffff000000000000, 0x400]
[   51.102862] nvme nvme0: 0x000000004ec4a26a -> [0xffff000000000000, 0x400]
[   51.103466] nvme nvme0: 0x00000000ee7f030f -> [0xffff000000000000, 0x200]
[  111.582818] nvme nvme0: I/O 7 QID 0 timeout, disable controller
[  111.599289] nvme nvme0: failed to set host mem (err -4, flags 0x1).
[  111.599862] nvme nvme0: nvme_free_host_mem: nr_host_mem_descs = 10
[  111.616938] nvme nvme0: Removing after probe failure status: -4
[  111.617558] nvme nvme0: nvme_free_host_mem: nr_host_mem_descs = 0
[  111.618270] nvme nvme0: failed to set APST feature (-19)

The extra lines come from me trying to figure out what is going on with this patch:

--8<--------------------------------------------------------------------------------------

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a24d507..73df69385bccd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1881,12 +1881,15 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 {
 	int i;
 
+	dev_info(dev->ctrl.device, "%s: nr_host_mem_descs = %d\n",
+		 __func__, dev->nr_host_mem_descs);
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
 		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
 		size_t size = le32_to_cpu(desc->size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, dev->host_mem_desc_bufs[i],
-				le64_to_cpu(desc->addr));
+		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
+			       le64_to_cpu(desc->addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(dev->host_mem_desc_bufs);
@@ -1952,8 +1955,9 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	while (--i >= 0) {
 		size_t size = le32_to_cpu(descs[i].size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, bufs[i],
-				le64_to_cpu(descs[i].addr));
+		dma_free_attrs(dev->dev, size, bufs[i],
+			       le64_to_cpu(descs[i].addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
@@ -2020,6 +2024,12 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 		dev_info(dev->ctrl.device,
 			"allocated %lld MiB host memory buffer.\n",
 			dev->host_mem_size >> ilog2(SZ_1M));
+		for (ret = 0; ret < dev->nr_host_mem_descs; ret++) {
+			dev_info(dev->ctrl.device,
+				"0x%p -> [0x%llx, 0x%x]\n", dev->host_mem_desc_bufs[ret],
+				le64_to_cpu(dev->host_mem_descs[ret].addr),
+				le32_to_cpu(dev->host_mem_descs[ret].size));
+		}
 	}
 
 	ret = nvme_set_host_mem(dev, enable_bits);

--8<--------------------------------------------------------------------------------------

The change to use dma_free_attrs() instead of dma_free_coherent() is needed otherwise I get
a crash in mm/vmalloc.c (patch sent to ML) or the modprobe hangs and I get the above err -4.


Best regards,
Liviu


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
