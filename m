Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC5C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B75C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTb7op01";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8BhtOZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B75C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/HjT81RAcn2XVS8rlSLmA3yr4NPtcXhU/G9zZSVm+lU=; b=rTb7op015ltYZV
	YzLtRfG0y/DyvxRYSntKTHlhGZe5txM9ek6x/cY1Uu5xR5fIQx7gMOV5oJrl6bSHFxYBVYip5dOiS
	suQC/Al33xTOCg/cZkOcJv0CWlGPPbl61rKwwjeTOp/085EuWHdzv2znNatILDmned3yHDQAfxG1c
	M+HR1NVHaKcKzDCcw7Vqfjwafbj48r9XkFKQ0MVer21b2y+8TE2RQI71a49VgPOvlBpsixyEyQHu1
	qzQ8oW5lkWtIcm6+JLbokVHLxmj7qYPMzzZs59kSVRvPAjLsCPtgOfBb7fFzN99OBaBRHLUN/4k7Q
	NyMRaxxpx9I/7PcpolqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnz3Z-0006sa-0J; Mon, 28 Jan 2019 05:02:01 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnz3T-0006rr-LA; Mon, 28 Jan 2019 05:01:57 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0S51dxx030139;
 Sun, 27 Jan 2019 23:01:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548651699;
 bh=XPjDlXvG3F0BiZ3mpuQAQvzcxWbKcbzD2ZGGw5Vhk/4=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=S8BhtOZux8OFN8h0SoN5YzzMoHxGuu7hNDUeJN4DxrB8IOHR2sKc5yFL5F51Yt+AF
 WGOdEPoyJaOJf8cUMEQmCI6y30tnhV4fPgrqcih/Zgng/DtvdD6H2ZyDBT5MlKwNEb
 fiCjsuT5KMNYK/Kp5gyyOrdI6Ucb35Ko8Ih/5yck=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0S51db7103823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Jan 2019 23:01:39 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 27
 Jan 2019 23:01:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 27 Jan 2019 23:01:38 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0S51YDd013948;
 Sun, 27 Jan 2019 23:01:35 -0600
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ae09e4e2-3015-f4c9-4b3c-093f30e9b508@ti.com>
Date: Mon, 28 Jan 2019 10:31:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_210155_819009_48E6D2B9 
X-CRM114-Status: GOOD (  22.11  )
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

Hi,

On 24/01/19 8:22 PM, Lorenzo Pieralisi wrote:
> On Mon, Jan 07, 2019 at 12:11:33PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> The Endpoint controller driver uses features member in 'struct pci_epc'
>> to advertise the list of supported features to the endpoint function
>> driver.
>>
>> There are a few shortcomings with this approach.
>>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>>      AM654 uses Designware configuration with fixed size BAR). The
>>      size of each BARs cannot be passed to the endpoint function
>>      driver.
>>   *) Too many macros for handling EPC features.
>>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>>       EPC_FEATURE_GET_BAR)
>>   *) Endpoint controllers are directly modifying struct pci_epc
>>      members. (I have plans to move struct pci_epc to
>>      drivers/pci/endpoint so that pci_epc members are referenced
>>      only by endpoint core).
>>
>> To overcome the above shortcomings, introduced pci_epc_get_features()
>> API, pci_epc_features structure and a ->get_features() callback.
>>
>> Also added a patch to set BAR flags in pci_epf_alloc_space and
>> remove it from pci-epf-test function driver.
>>
>> Tested on TI's DRA7xx platform.
> 
> Hi Kishon,
> 
> I have no major objections to this series but I would like to see some
> testing done in EP mode (on test platforms other than DRA7XX) to make
> sure it does not break anything.
> 
> Please do help Kishon get some testing done.

Please test v2 of this series please [1]

[1] -> https://www.spinics.net/lists/arm-kernel/msg699787.html

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>> Thanks
>> Kishon
>>
>> Kishon Vijay Abraham I (15):
>>   PCI: endpoint: Add new pci_epc_ops to get EPC features
>>   PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
>>   PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
>>   PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
>>   PCI: endpoint: Add helper to get first unreserved BAR
>>   PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
>>   PCI: pci-epf-test: Remove setting epf_bar flags in function driver
>>   PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
>>     64Bit
>>   PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
>>   PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
>>   PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
>>   PCI: designware-plat: Remove setting epc->features in Designware plat
>>     EP driver
>>   PCI: endpoint: Remove features member in struct pci_epc
>>
>>  drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
>>  .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
>>  .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
>>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>  drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
>>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
>>  drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
>>  drivers/pci/endpoint/pci-epf-core.c           |  3 +
>>  include/linux/pci-epc.h                       | 30 +++++--
>>  10 files changed, 185 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.17.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
