Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64959C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3183821848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fzEKMQn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3183821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVvJ4drWbp5g9vrc+ulxIvd7m5oZt5e77fiij87ZNts=; b=fzEKMQn0wQRzpU
	PRCyuTnniZz0JPfnKtNcUglcW/t+vljt8NHuFhoQ7T47mAT1VH+PF0Np0KwsKRzVhCYli4EKN6MA+
	FjZFcjkfD1TeykGW5NzTHXc0rryIZnrywMMQiuGv8CKtssuDJNcsdz4shPLOfGj9PnDD24PWMTSIA
	PgudY4hC65tl3covb0dmHZW9V8j4PlpTgm5eiM0tuT1fRYUoNlzMot1Ayt2/klkCMJXwJigW4FsVQ
	J+chW2cb3KZPSHCvCl/n5DWySSonUYFOPVUEdFtzrfeWP5heSYtsd+qIlyUSS4myBIwuYW2vZ1hCI
	TtVmV0vH9UIRtU+ASY7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0Ch-0007vR-EQ; Tue, 19 Feb 2019 07:52:35 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0Cd-0007ua-BV; Tue, 19 Feb 2019 07:52:33 +0000
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C76BD26DA90;
 Tue, 19 Feb 2019 07:52:27 +0000 (GMT)
Date: Tue, 19 Feb 2019 08:52:24 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 0/5] MTD: Add Initial Hyperbus support
Message-ID: <20190219085212.355921e5@kernel.org>
In-Reply-To: <20190219063607.29949-1-vigneshr@ti.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_235231_658600_9112AC7C 
X-CRM114-Status: GOOD (  21.13  )
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
Cc: devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Arnd Bergmann <arnd@arndb.de>, tudor.ambarus@microchip.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Richard Weinberger <richard@nod.at>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+Sergei and Mason who recently worked on an HyperFlash controller.

On Tue, 19 Feb 2019 12:06:02 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or
> self refresh DRAM(called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
> operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a
> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> This is an early RFC, to know if its okay to use maps framework and existing
> CFI compliant flash support code to support Hyperflash
> Also would like input on different types of HBMC master IPs out there
> and their programming sequences.
> Would appreciate any testing/review.
> 
> Tested on modified TI AM654 EVM with Cypress Hyperflash S26KS512 by
> creating a UBIFS partition and writing and reading files to it.
> Stress tested by writing/reading 16MB flash repeatedly at different
> offsets using dd commmand.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> TI's HBMC controller details at[3]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Vignesh R (5):
>   mtd: cfi_cmdset_0002: Add support for polling status register
>   dt-bindings: mtd: Add binding documentation for Hyperbus memory
>     devices
>   mtd: Add support for Hyperbus memory devices
>   dt-bindings: mtd: Add bindings for TI's AM654 Hyperbus memory
>     controller
>   mtd: hyperbus: Add driver for TI's Hyperbus memory controller
> 
>  .../bindings/mtd/cypress,hyperbus.txt         |   6 +
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt |  27 +++
>  MAINTAINERS                                   |   8 +
>  drivers/mtd/Kconfig                           |   2 +
>  drivers/mtd/Makefile                          |   1 +
>  drivers/mtd/chips/cfi_cmdset_0002.c           |  50 ++++++
>  drivers/mtd/hyperbus/Kconfig                  |  23 +++
>  drivers/mtd/hyperbus/Makefile                 |   4 +
>  drivers/mtd/hyperbus/core.c                   | 167 ++++++++++++++++++
>  drivers/mtd/hyperbus/hbmc_am654.c             | 105 +++++++++++
>  include/linux/mtd/cfi.h                       |   5 +
>  include/linux/mtd/hyperbus.h                  |  73 ++++++++
>  12 files changed, 471 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>  create mode 100644 drivers/mtd/hyperbus/Kconfig
>  create mode 100644 drivers/mtd/hyperbus/Makefile
>  create mode 100644 drivers/mtd/hyperbus/core.c
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
>  create mode 100644 include/linux/mtd/hyperbus.h
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
