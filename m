Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45967C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130412080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yt2ZHuOJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CvNxYSoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130412080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TCEboaqLu0eG2U3R9bg5xcM7WIdjCFT7ltpqZtYbPGc=; b=Yt2ZHuOJKXR3L2
	mdBtXQ6Fw2uwhX23Jy1YtlklfmgeI1YKf8r+6teyE61wjY51PbIZndd1Qh1vazhAu+coQG+8KKnR4
	ojcQnOegii9BkZRvuSB12hXnIEK1ucux+MjUj1TcTyDdx4Y9Lwk15n8wkLZIsH6uYHrOtT66xdJC5
	+Oki5Y27snRqYyzrlA9qPPjTfV78EwwIDICiJgpBwvF8Vv6NP9QDdrBMLyFLgBznDfpwkG4ip9vmp
	ncmMVmCkRbR5s9a1ngsRLupZSwZV6CU4dmXwd81+DSE7reczfhKgYoFSyGNGSPm/z8FwPaSjf+sFT
	n3hQI9t1HSGgFhR/cnvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8lr-0001MT-8C; Mon, 11 Feb 2019 10:25:03 +0000
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8ln-0001Iz-6e; Mon, 11 Feb 2019 10:25:00 +0000
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com
 [10.192.0.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id C574A24E171A;
 Mon, 11 Feb 2019 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1549880696; bh=+wS3QB9Q/Ttq9cP5dShY0goPrBx5IxvPPI+Gt5VMXm0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=CvNxYSoMTQmce6mtvx7U74GEFny5Lkfi8p24U5Q8H2NvV7cMrr4bjhQy4TvVmKiW+
 9NHN2XHoWECkec2toTArz5TydQRauMtqXmMHMwUJc7EpYiy1vrNIkIlmACyVrqEmc2
 pv55Y00zqpoH2gNnYMlyMikU1WOK1100010cJFfG9GytRtWtk00ypWGL6ePoUN/rPP
 dWrIiB/NLUlzqx4NKU9IU89kK84yq/Q7hRUgYZLuRGUKs1jir8b35iejreKM4rB+DY
 T+vwaLLdZZKa9wuSbFCqxK1LtYvGtb9t7JC8hjKd93Rn1q0NJtiLnaNxItMQN4X5yZ
 u04ekyCsAXfMw==
Received: from US01WEHTC3.internal.synopsys.com
 (us01wehtc3.internal.synopsys.com [10.15.84.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id 02C3FA0071;
 Mon, 11 Feb 2019 10:24:49 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 02:24:49 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 11:24:47 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 11:24:47 +0100
Subject: Re: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Alan Douglas <adouglas@cadence.com>,
 "Shawn  Lin" <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
References: <20190114111513.21618-1-kishon@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <a0b12a7f-b341-28a2-edb8-b573d39f6e1b@synopsys.com>
Date: Mon, 11 Feb 2019 10:19:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Content-Language: en-US
X-Originating-IP: [10.107.25.131]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_022459_250653_C20EF40F 
X-CRM114-Status: GOOD (  20.39  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 14/01/2019 11:14, Kishon Vijay Abraham I wrote:
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
> Changes from v1:
> *) Fixed helper function to return '0' (or BAR_0) for any incorrect
>    values in reserved BAR.
> *) Do not set_bar or alloc space for BARs if the BARs are reserved
> *) Fix incorrect check of epc_features in pci_epf_test_bind
> 
> Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
> in AM654 platform will be posted shortly.
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
>  drivers/pci/controller/pcie-cadence-ep.c      | 25 ++---
>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 93 ++++++++++++-------
>  drivers/pci/endpoint/pci-epc-core.c           | 53 +++++++++++
>  drivers/pci/endpoint/pci-epf-core.c           |  4 +-
>  include/linux/pci-epc.h                       | 31 +++++--
>  10 files changed, 201 insertions(+), 64 deletions(-)
> 

Sorry for the delay, I had a problem with my setup.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
