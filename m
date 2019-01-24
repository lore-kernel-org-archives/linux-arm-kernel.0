Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBBBC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929BB218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k/C21/oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929BB218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lbYaapqAIS4wlMvQ0E+5igDTn7GKr913LLQSsSoFgwY=; b=k/C21/oKs9X5r8
	wWFVgrqDfE6JZoJ19m3ew1zaYA+LQXHorbL0DkLuFGTGhI6jcQlZBroWAm9cmE+A/9kNpvdJ35UI3
	qbhVlauQe85Qx2VQTXHMDdOx9iaOXczpARtzKA+Eu1d7QXnVtKu0aGBzfMymX39RizcrueB/U6rZy
	EQHdF3Jis1W508Zi057JfRYBV3Nk6TQXaZYRAsovTXa36+pB0Q1T0S6JIXfBpyE4/ghJzApK5bcQZ
	QbHNnVji0jjg0LJJIK6DzM2+0QY/XyjOpIJnFjacjXrgpsnnwsTTwNbWmDoTFiXwPF8nHBrbnzwUy
	fzH2zOBIqe1aSyt7FjXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgMm-0000dc-Q5; Thu, 24 Jan 2019 14:52:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgMj-0000cu-CH; Thu, 24 Jan 2019 14:52:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11D4A78;
 Thu, 24 Jan 2019 06:52:24 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41D6F3F5AF;
 Thu, 24 Jan 2019 06:52:22 -0800 (PST)
Date: Thu, 24 Jan 2019 14:52:19 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Message-ID: <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_065225_424622_450944ED 
X-CRM114-Status: GOOD (  18.58  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 12:11:33PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>      AM654 uses Designware configuration with fixed size BAR). The
>      size of each BARs cannot be passed to the endpoint function
>      driver.
>   *) Too many macros for handling EPC features.
>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>       EPC_FEATURE_GET_BAR)
>   *) Endpoint controllers are directly modifying struct pci_epc
>      members. (I have plans to move struct pci_epc to
>      drivers/pci/endpoint so that pci_epc members are referenced
>      only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Tested on TI's DRA7xx platform.

Hi Kishon,

I have no major objections to this series but I would like to see some
testing done in EP mode (on test platforms other than DRA7XX) to make
sure it does not break anything.

Please do help Kishon get some testing done.

Thanks,
Lorenzo

> Thanks
> Kishon
> 
> Kishon Vijay Abraham I (15):
>   PCI: endpoint: Add new pci_epc_ops to get EPC features
>   PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
>   PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
>   PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
>   PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
>   PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
>   PCI: endpoint: Add helper to get first unreserved BAR
>   PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
>   PCI: pci-epf-test: Remove setting epf_bar flags in function driver
>   PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
>     64Bit
>   PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
>   PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
>   PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
>   PCI: designware-plat: Remove setting epc->features in Designware plat
>     EP driver
>   PCI: endpoint: Remove features member in struct pci_epc
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
>  .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
>  .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
>  drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c           |  3 +
>  include/linux/pci-epc.h                       | 30 +++++--
>  10 files changed, 185 insertions(+), 64 deletions(-)
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
