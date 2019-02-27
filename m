Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF985C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:59:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC5720842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qDnQPA2P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4lPA1II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC5720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wKqlEb5UwxpCS9CKLOiu5v1iDk2Zpk4OXVMRwtYK7eE=; b=qDnQPA2PQRSHgk
	Ibvw/tVSQbejl5d3PFGrnDNYNL0L06lfTQmFliMqHb5BS56ICENLwBoLM0LzGyQCdWIMR4SP7YBhE
	SnTngh8Tm3ObmeiYeu5RkxDd317X7IwzCbbbacYQLm5yBdJnk2qhP5eIGKkjS1Tlb3Pd3jwVXsxFy
	AJ1/l7lJAF1fi4SzTVyDBxRmvPfuGgDO6CC587MoXyT3YNSXBruILrJ+nKzG2VNBuFcyOR/5T0ABi
	uLfqWJo7leZ2lXiHQT/x2eRMbHEUr9x5HrGHFmKFG3GHEME0Z11aUb5MCr6uqw5GRQbOf2KM/tZZ9
	ICp69ikJpDuWx9s4ASHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyw0D-0007BE-8E; Wed, 27 Feb 2019 09:59:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyw09-0007Aj-EU; Wed, 27 Feb 2019 09:59:47 +0000
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06022205F4;
 Wed, 27 Feb 2019 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551261584;
 bh=SEGeeNAdiIiL1sHrk9uRoWVuV4aOBMHFvHuTGNX/sEw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h4lPA1IIGrroPggndXXI023fBc0MTaJSZ4YTw+5nXBFhJ8usA/nOvX/kx+bPjjFaz
 x64Xy9WLAK1T3jBE0zds5yb5GmM5hp3tulBRsknv3nUawdAFI4fMlxht8UlbGbSCRo
 GX0+8t71jwHHmyKXE5kGLfAcuQ29Ok8R0sVqIbs8=
Date: Wed, 27 Feb 2019 10:59:37 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
Message-ID: <20190227105937.527c6573@kernel.org>
In-Reply-To: <3952b327-3aff-a32e-4280-6ab24c32cfd9@ti.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
 <3952b327-3aff-a32e-4280-6ab24c32cfd9@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_015945_524912_0D0FCD48 
X-CRM114-Status: GOOD (  30.27  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Nori, Sekhar" <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 27 Feb 2019 15:22:19 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> On 26/02/19 11:46 PM, Sergei Shtylyov wrote:
> > On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
> >   
> >> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> >> interface between a host system master and one or more slave interfaces.
> >> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> >> devices with random access NOR flash memory(called HyperFlash) or
> >> self refresh DRAM(called HyperRAM).
> >>
> >> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> >> signal and either Single-ended clock(3.0V parts) or Differential clock
> >> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> >> At bus level, it follows a separate protocol described in HyperBus
> >> specification[1].
> >>
> >> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> >> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
> >> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
> >> operates at >166MHz frequencies.
> >> HyperRAM provides direct random read/write access to flash memory
> >> array.
> >>
> >> But, Hyperbus memory controllers seem to abstract implementation details
> >> and expose a simple MMIO interface to access connected flash.
> >>
> >> Add support for registering HyperFlash devices with MTD framework. MTD
> >> maps framework along with CFI chip support framework are used to support
> >> communicate with flash.
> >>
> >> Framework is modelled along the lines of spi-nor framework. HyperBus
> >> memory controller(HBMC) drivers call hb_register_device() to register a
> >> single HyperFlash device. HyperFlash core parses MMIO access
> >> information from DT, sets up the map_info struct, probes CFI flash and
> >> registers it with MTD framework.
> >>
> >> Some HBMC masters need calibration/training sequence[3] to be carried
> >> out, in order for DLL inside the controller to lock, by reading a known
> >> string/pattern. This is done by repeatedly reading CFI Query
> >> Identification String. Calibration needs to be done before try to detect
> >> flash as part of CFI flash probe.
> >>
> >> HyperRAM is not supported atm.
> >>
> >> HyperBus specification can be found at[1]
> >> HyperFlash datasheet can be found at[2]
> >>
> >> [1] https://www.cypress.com/file/213356/download
> >> [2] https://www.cypress.com/file/213346/download
> >> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
> >>     Table 12-5741. HyperFlash Access Sequence
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>  
> > [...]  
> >> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
> >> new file mode 100644
> >> index 000000000000..0aa11458c424
> >> --- /dev/null
> >> +++ b/include/linux/mtd/hyperbus.h
> >> @@ -0,0 +1,73 @@
> >> +/* SPDX-License-Identifier: GPL-2.0
> >> + *
> >> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> >> + */
> >> +
> >> +#ifndef __LINUX_MTD_HYPERBUS_H__
> >> +#define __LINUX_MTD_HYPERBUS_H__
> >> +
> >> +#include <linux/mtd/map.h>
> >> +
> >> +enum hb_memtype {
> >> +	HYPERFLASH,
> >> +	HYPERRAM,
> >> +};
> >> +
> >> +/**
> >> + * struct hb_device - struct representing Hyperbus slave device
> >> + * @map: map_info struct for accessing MMIO Hyperbus flash memory
> >> + * @dev: device pointer of Hyperbus Controller  
> > 
> >    I think we need a separate structure for the HyperBus controller, not just
> > for the slave devices...
> >   
> >> + * @np:	pointer to Hyperbus slave device node
> >> + * @mtd: pointer to MTD struct
> >> + * @ops: pointer to custom Hyperbus ops
> >> + * @memtype: type of memory device: Hyperflash or HyperRAM
> >> + * @needs_calib: flag to indicate whether calibration sequence is needed
> >> + * @registered: flag to indicate whether device is registered with MTD core
> >> + */
> >> +
> >> +struct hb_device {
> >> +	struct map_info map;
> >> +	struct device *dev;
> >> +	struct device_node *np;
> >> +	struct mtd_info *mtd;
> >> +	struct hb_ops *ops;
> >> +	enum hb_memtype memtype;
> >> +	bool needs_calib;
> >> +	bool registered;
> >> +};
> >> +
> >> +/**
> >> + * struct hb_ops - struct representing custom Hyperbus operations
> >> + * @read16: read 16 bit of data, usually from register/ID-CFI space
> >> + * @write16: write 16 bit of data, usually to register/ID-CFI space
> >> + * copy_from: copy data from flash memory
> >> + * copy_to: copy data to flash_memory
> >> + */
> >> +
> >> +struct hb_ops {
> >> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
> >> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
> >> +
> >> +	void (*copy_from)(struct hb_device *hbdev, void *to,
> >> +			  unsigned long from, ssize_t len);
> >> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
> >> +			const void *from, ssize_t len);  
> > 
> >    ... else these methods won't fly if you need to "massage" the controller
> > registers inside them...
> >   
> 
> If accessing controller register is the only need, wouldn't a private
> data pointer within struct hb_device be sufficient to hold pointer to
> controller specific struct?
> 
> struct hb_device {
> 	...
> 	void *priv; /* points to controller's private data */
> };
> 
> 
> Or do you see a need for separate structure for the HyperBus controller?

Sorry to chime in. Just want to share my experience here: properly
splitting the controller/device representation is always a good thing.
When it's not done from the beginning and people start to add their own
controller drivers as if it was a flash device driver it becomes messy
pretty quickly and people add hacks to support that (look at the raw
NAND framework if you need a proof). So, I'd recommend having this
separation now, even if the onle controllers we support have a 1:1
relationship between HB controller and HB device.

> 
> 
> >> +};  
> > [...]
> > 
> > MBR, Sergei
> >   
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
