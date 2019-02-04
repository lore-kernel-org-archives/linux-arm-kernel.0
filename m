Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EB020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JYK6Alfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EB020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2tcrcjoNaBpaFgrl3lFMTj0WdAgVwJs9ZLQO+NjL5z0=; b=JYK6Alfrvr8+5N
	4HwznhdwCSXkvs/Ccksjl9Zppg9poEt2/n8/p3TkVYwpPrQsIXyK5PvX8YK27c6m+/whj//lrU8BH
	L+xTzEOHD1g1vKcqrlGRLpyZcMsTepnxHFMykcFa03JBfQLqB6QH0Eo3qL3GyBuqwZ6GUUS0Phts0
	CYpsYGDZHEvjhXE7tzFMXq6QxHsdRG8JfqCz0qFPGkFn5UBU3NfKsf3nFzZRG+0pUHgx/Gxmxg9iH
	9kUHocZ5OIgdgMHNvMTOkSvltDrJQTPDl5fHPt62mIW33wswcCAfyCt+pexDxPTcyqhojMieIms5M
	tWIbliMGTVmBW6ZC2AOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhIz-0007Wh-OM; Mon, 04 Feb 2019 16:41:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhIw-0007WN-VD
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:41:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF41EBD;
 Mon,  4 Feb 2019 08:41:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807313F589;
 Mon,  4 Feb 2019 08:41:03 -0800 (PST)
Date: Mon, 4 Feb 2019 16:40:54 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/24] Add support for PCIe RC and EP mode in TI's AM654
 SoC
Message-ID: <20190204164054.GA21488@e107981-ln.cambridge.arm.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_084107_013405_497F8C70 
X-CRM114-Status: GOOD (  22.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Rob Herring <robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 06:54:00PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> in keystone2 with certain modification. Hence AM654 will use the same
> pci wrapper driver pci-keystone.c
> 
> This series was initially part of [1]. This series only includes patches
> that has to be merged via Lorenzo's tree. The PHY patches and dt patches
> will be sent separately.
> 
> This series is created over my keystone MSI cleanup series [2] and EPC
> features series [3].

Hi Kishon,

so I would suggest we merge those series first, starting from the MSI
clean-up.

I will mark this series as awaiting upstream, it is on my radar but
we have to get the two others done first.

Thanks,
Lorenzo

> This series:
> *) Cleanup pci-keystone driver so that both RC mode and EP mode of
>    AM654 can be supported
> *) Modify epc-core to support allocation of aligned buffers required for
>    AM654
> *) Fix ATU unroll identification
> *) Add support for both host mode and device mode in AM654    
> 
> [1] -> https://lore.kernel.org/patchwork/cover/989487/
> [2] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1883081.html
> [3] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899011.html
> 
> Kishon Vijay Abraham I (24):
>   PCI: keystone: Add start_link/stop_link dw_pcie_ops
>   PCI: keystone: Cleanup error_irq configuration
>   dt-bindings: PCI: keystone: Add "reg-names" binding information
>   PCI: keystone: Perform host initialization in a single function
>   PCI: keystone: Use platform_get_resource_byname to get memory
>     resources
>   PCI: keystone: Move initializations to appropriate places
>   dt-bindings: PCI: Add dt-binding to configure PCIe mode
>   PCI: keystone: Explicitly set the PCIe mode
>   dt-bindings: PCI: Document "atu" reg-names
>   PCI: dwc: Enable iATU unroll for endpoint too
>   PCI: dwc: Fix ATU identification for designware version >= 4.80
>   PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
>   dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
>   PCI: keystone: Add support for PCIe RC in AM654x Platforms
>   PCI: keystone: Invoke phy_reset API before enabling PHY
>   PCI: endpoint: Add support to allocate aligned buffers to be mapped in
>     BARs
>   PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
>   PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
>     offset
>   PCI: dwc: Add callbacks for accessing dbi2 address space
>   PCI: keystone: Add support for PCIe EP in AM654x Platforms
>   PCI: designware-ep: Configure RESBAR to advertise the smallest size
>   PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
>   misc: pci_endpoint_test: Add support to test PCI EP in AM654x
>   misc: pci_endpoint_test: Fix test_reg_bar to be updated in
>     pci_endpoint_test
> 
>  .../bindings/pci/designware-pcie.txt          |   7 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
>  drivers/misc/pci_endpoint_test.c              |  17 +
>  drivers/pci/controller/dwc/Kconfig            |  25 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-keystone.c     | 505 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  19 -
>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
>  drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  10 +-
>  include/linux/pci-epc.h                       |   2 +
>  include/linux/pci-epf.h                       |   3 +-
>  16 files changed, 587 insertions(+), 148 deletions(-)
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
