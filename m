Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D10C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:42:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88531218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QicG1dAz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBygKK+X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hv4PSwGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88531218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NFbd0YoU+UPRuOpwN5MxT+kOoHJrNSY7+f1Q8CcwKPU=; b=QicG1dAzaeDuQS
	DBj2Gh+k9Pba1FhcHZrCZ3189V/QL/ZQhnglXF3xSwlbQrqA1O6//dqaZfIwXIUkmlp1VcyCvsVmv
	0P+inzWotry4DMczmG09fD5/zO2hr3dbyTEwB9FIFw4ScZy8UfhvVfMJsLKM6jLvKqp2IBo9139Ag
	kUWxMM2e0QlQCvAcyYvKWGsLxn5kk8LL6TFpWA4s29gX4HZdFg0AwP0HABx1nVDHidWZp0DWaIPIY
	SecPIX3Cz5FRQNU6tNVX3lQDEEps3LjTLNcLbDe08GzeG1wpbRfMk6fe7Emd0n9c9SQ6oJAnv2q2y
	Tw/mQ6PUovBDk5C+y2NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAue-00047m-MA; Mon, 11 Feb 2019 12:42:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAua-0003qy-R0; Mon, 11 Feb 2019 12:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sj1ePXFFVvvlr+AO5ifm1mvyLi0nizVQYZ4N7X7ewWs=; b=PBygKK+XzIZZ/7+Fpr2ewK/FhY
 JUQsA0F2kq0OppSzH7lsYqvNZumpdiL8Q1q9H8gnTu9oe905/SSJZnoDSUgf5dPHvQGILpZ1mM4LH
 +9Hk7fvMmMT74aQZt1dodcXTF/FyJkEwV/qkh2N9l9ymsoimlwxSMPpVtVQGxXWfc+gupjZtJXtEP
 Pw6RFjpJ3jVG0MkeDRniIj9ie90F4HKUz/D+GUjv9+qnfmdvJkkQhR1qJCJDoLXW0toPJiE6yIZYr
 YDusc88kMqmx2OXR1Bw7i4DQnPGfVo34NBgDeNLWSulupyLkEpHwYFOJGYlexXw4BxlD7gy4YEWmg
 fJAG5bhA==;
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtArG-0005L4-54; Mon, 11 Feb 2019 12:38:48 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1BCcapj072013;
 Mon, 11 Feb 2019 06:38:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549888716;
 bh=Sj1ePXFFVvvlr+AO5ifm1mvyLi0nizVQYZ4N7X7ewWs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Hv4PSwGOnqmmuRJZrQoL7ingQGkqdUCd1RtmGGCInkqgG7V4YVn17TFdMGK4qq9TD
 XuPbqZtX+eTvredbb8aAcn9V/qKqdEIf7HkEslmbH3lsMnCSTK5XxUaastPHzYdN7E
 liG9WOw+z1YxyOuFeUS2UCeFlqTo7h3y0lv48KBU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1BCcaaM024129
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Feb 2019 06:38:36 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 06:38:35 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 06:38:35 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1BCcV2a006336;
 Mon, 11 Feb 2019 06:38:32 -0600
Subject: Re: [PATCH v2 00/15] PCI: endpoint: Cleanup EPC features
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
References: <20190114111513.21618-1-kishon@ti.com>
 <a0b12a7f-b341-28a2-edb8-b573d39f6e1b@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <47f1a416-6f8b-0c29-21ed-756ba76fc3f5@ti.com>
Date: Mon, 11 Feb 2019 18:07:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a0b12a7f-b341-28a2-edb8-b573d39f6e1b@synopsys.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_123846_426866_34D979DF 
X-CRM114-Status: GOOD (  19.55  )
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



On 11/02/19 3:49 PM, Gustavo Pimentel wrote:
> Hi,
> 
> On 14/01/2019 11:14, Kishon Vijay Abraham I wrote:
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
>> Changes from v1:
>> *) Fixed helper function to return '0' (or BAR_0) for any incorrect
>>    values in reserved BAR.
>> *) Do not set_bar or alloc space for BARs if the BARs are reserved
>> *) Fix incorrect check of epc_features in pci_epf_test_bind
>>
>> Tested on TI's DRA7xx platform and AM654 platform. Support for PCIe
>> in AM654 platform will be posted shortly.
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
>>  drivers/pci/controller/pcie-cadence-ep.c      | 25 ++---
>>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 93 ++++++++++++-------
>>  drivers/pci/endpoint/pci-epc-core.c           | 53 +++++++++++
>>  drivers/pci/endpoint/pci-epf-core.c           |  4 +-
>>  include/linux/pci-epc.h                       | 31 +++++--
>>  10 files changed, 201 insertions(+), 64 deletions(-)
>>
> 
> Sorry for the delay, I had a problem with my setup.
> 
> Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thank you Gustavo!

-Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
