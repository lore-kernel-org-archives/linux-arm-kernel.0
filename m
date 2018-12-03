Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153ACC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3D1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uP23gc4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3D1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8g3D51P/0dAmekAuOBHAXMRaxfiF2WwQJJ5kcwtWczg=; b=uP23gc4N3DFFNN
	+aSpmEll8FQWuaPASEZLP1xvq8syvh/icuS0XfApAQvD9KLhX1FyMZEAF/drIIrGByqphEXYiBUNf
	K7TGLA1cye6jpr5gqIGMa5O/ysxH4/q8eVlH2WDqbHkHpnugWkAOpyjyQE5z9dhYBo5xj14030vxF
	4NRGjS6HUf0Ug4rGfi/bhVYZMosfdnlS6EQ4bF9pOy4O7DMNnemhImfXq+yrxlGxoZStqmQIG3MPf
	GRtq20ygcFS5/9cdQBdyrRLgzaX3X4Gi7DyrJtYWkDgASfUGwvhRwvnqGBqfegI3rUw/FUQXiJ/Sp
	kZOcFbzRgZHQ7wnBFu+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmsc-0007Ii-4Y; Mon, 03 Dec 2018 11:59:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmsY-0007I3-PQ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:59:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD81165C;
 Mon,  3 Dec 2018 03:58:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F2A3F59C;
 Mon,  3 Dec 2018 03:58:52 -0800 (PST)
Date: Mon, 3 Dec 2018 11:58:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: Re: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe
 support for NXP LX SoCs
Message-ID: <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_035910_839190_E6CED166 
X-CRM114-Status: GOOD (  19.32  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 06, 2018 at 01:19:03PM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is aim to refactor the Mobiveil driver and add
> PCIe support for NXP LX series SoCs.
> 
> Hou Zhiqiang (23):
>   PCI: mobiveil: uniform the register accessors
>   PCI: mobiveil: format the code without function change
>   PCI: mobiveil: correct the returned error number
>   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: replace the resource list iteration function
>   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
>   PCI: mobiveil: correct the inbound/outbound window setup routine
>   PCI: mobiveil: fix the INTx process error
>   PCI: mobiveil: only fixup the Class Code field
>   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
>   PCI: mobiveil: move irq chained handler setup out of DT parse
>   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
>   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
>   PCI: mobiveil: refactor the Mobiveil driver
>   PCI: mobiveil: continue to initialize the host upon no PCIe link
>   PCI: mobiveil: disabled IB and OB windows set by bootloader
>   PCI: mobiveil: add Byte and Half-Word width register accessors
>   PCI: mobiveil: change prototype of function mobiveil_host_init
>   dt-bindings: pci: Add NXP LX SoCs PCIe controller
>   PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
>   arm64: dts: freescale: lx2160a: add pcie DT nodes
> 
>  .../devicetree/bindings/pci/lx-pci.txt        |  52 ++
>  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
>  MAINTAINERS                                   |  10 +-
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++
>  drivers/pci/controller/Kconfig                |  11 +-
>  drivers/pci/controller/Makefile               |   2 +-
>  drivers/pci/controller/mobiveil/Kconfig       |  34 +
>  drivers/pci/controller/mobiveil/Makefile      |   5 +
>  drivers/pci/controller/mobiveil/pci-lx.c      | 222 +++++
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 622 +++++++++++++
>  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
>  .../pci/controller/mobiveil/pcie-mobiveil.c   | 245 +++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 221 +++++
>  drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
>  14 files changed, 1625 insertions(+), 873 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
>  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
>  create mode 100644 drivers/pci/controller/mobiveil/Makefile
>  create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
>  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c

Subrahmanya,

for the records, this is the driver *you* are maintaining, aren't you ?

We ask developers to be added to the MAINTAINERS list in order to hold
them accountable, merging a driver upstream means that you need to
actively maintain it, which in turn means reviewing series affecting
its code, like this one.

I will have a look too but it is your responsibility to review these
patches and ACK them accordingly.

So I strongly suggest you start doing it please.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
