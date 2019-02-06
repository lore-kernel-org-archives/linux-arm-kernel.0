Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EEDC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:51:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE74320B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5xzxKYr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vUQBd2gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE74320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eM+uIdqAzpFsW0ICkaQCVYTR+9FF871uM9UQ0FCQvRg=; b=t5xzxKYrAqGfLT
	7Zd9gURJStQ9x2ylRl58F3hAKEjZaxQWyQcho+ZFz3flX/4xDGAlTkLCNiW52ti2o9jgwdtMT0AZf
	AyYzsHqSMd36jV5y8Vg05XSMeEQjqxWQalD21MO2oRgzUjZMdZU0HU8hs15ZuY8ZZUWmIeNoo9i4l
	HFdCYd6DLxXcM81txcqZTaMl6OmGLu6nn6csVvsvn+7yqEaYsPJlyRzR+BPkQppXQjzemSNCDyUXi
	5nXULV5m2c50O5jWy9sMRIkdcz1IE6A7dz4gEuCqnaHWGXidNKkrMAyRM+VmLfTOpBAbKBwONqqGV
	st9cd1Mf00KRhd8lK/Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMfa-0005wU-Uo; Wed, 06 Feb 2019 12:51:14 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMfW-0005w9-U4
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:51:12 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CoxY6108766;
 Wed, 6 Feb 2019 06:50:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549457459;
 bh=XQ7nlxslfcwTd9Bi0BBFQvK4BIP9P7P7NhyBC1rpSck=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=vUQBd2gROk0KS7Qa1I8LXECHmTjYxleSg9M7qJKc0lMFvkxCWcWJhQh1VUcgjOk69
 H7yM1/0fQpBjH31BWmet98H6LJYqsRc8nm7iB26SDDl3e2ce8GNRKzVQKBzEZ9EUGR
 M7Cqd5SQB6/E7sXbrdwoRVis6dllfoNTO8LmxL6w=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16Cox8H081347
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 06:50:59 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:50:59 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:50:59 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16Cos1N026235;
 Wed, 6 Feb 2019 06:50:55 -0600
Subject: Re: [PATCH 00/24] Add support for PCIe RC and EP mode in TI's AM654
 SoC
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190114132424.6445-1-kishon@ti.com>
 <20190204164054.GA21488@e107981-ln.cambridge.arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a9a7fe72-9b23-7ebb-d0d0-82cac62b6884@ti.com>
Date: Wed, 6 Feb 2019 18:20:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204164054.GA21488@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_045111_045808_BDE3FB9B 
X-CRM114-Status: GOOD (  27.46  )
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

Hi Lorenzo,

On 04/02/19 10:10 PM, Lorenzo Pieralisi wrote:
> On Mon, Jan 14, 2019 at 06:54:00PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
>> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
>> in keystone2 with certain modification. Hence AM654 will use the same
>> pci wrapper driver pci-keystone.c
>>
>> This series was initially part of [1]. This series only includes patches
>> that has to be merged via Lorenzo's tree. The PHY patches and dt patches
>> will be sent separately.
>>
>> This series is created over my keystone MSI cleanup series [2] and EPC
>> features series [3].
> 
> Hi Kishon,
> 
> so I would suggest we merge those series first, starting from the MSI
> clean-up.
> 
> I will mark this series as awaiting upstream, it is on my radar but
> we have to get the two others done first.

Sure. I have one outstanding comment to be fixed on my legacy interrupt cleanup
patch in the MSI cleanup series. I'll resend the series without the legacy
interrupt cleanup patch so that we can get most of the patches for 5.1. I'll
come back to it later.

I'm not sure how many tested EPC features cleanup. However I've got ACK from
Shawn Lin for the v2 of EPC features cleanup series and Layerscape EP series
was created on top of EPC features cleanup series.

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>> This series:
>> *) Cleanup pci-keystone driver so that both RC mode and EP mode of
>>    AM654 can be supported
>> *) Modify epc-core to support allocation of aligned buffers required for
>>    AM654
>> *) Fix ATU unroll identification
>> *) Add support for both host mode and device mode in AM654    
>>
>> [1] -> https://lore.kernel.org/patchwork/cover/989487/
>> [2] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1883081.html
>> [3] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899011.html
>>
>> Kishon Vijay Abraham I (24):
>>   PCI: keystone: Add start_link/stop_link dw_pcie_ops
>>   PCI: keystone: Cleanup error_irq configuration
>>   dt-bindings: PCI: keystone: Add "reg-names" binding information
>>   PCI: keystone: Perform host initialization in a single function
>>   PCI: keystone: Use platform_get_resource_byname to get memory
>>     resources
>>   PCI: keystone: Move initializations to appropriate places
>>   dt-bindings: PCI: Add dt-binding to configure PCIe mode
>>   PCI: keystone: Explicitly set the PCIe mode
>>   dt-bindings: PCI: Document "atu" reg-names
>>   PCI: dwc: Enable iATU unroll for endpoint too
>>   PCI: dwc: Fix ATU identification for designware version >= 4.80
>>   PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
>>   dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
>>   PCI: keystone: Add support for PCIe RC in AM654x Platforms
>>   PCI: keystone: Invoke phy_reset API before enabling PHY
>>   PCI: endpoint: Add support to allocate aligned buffers to be mapped in
>>     BARs
>>   PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
>>   PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
>>     offset
>>   PCI: dwc: Add callbacks for accessing dbi2 address space
>>   PCI: keystone: Add support for PCIe EP in AM654x Platforms
>>   PCI: designware-ep: Configure RESBAR to advertise the smallest size
>>   PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
>>   misc: pci_endpoint_test: Add support to test PCI EP in AM654x
>>   misc: pci_endpoint_test: Fix test_reg_bar to be updated in
>>     pci_endpoint_test
>>
>>  .../bindings/pci/designware-pcie.txt          |   7 +-
>>  .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
>>  drivers/misc/pci_endpoint_test.c              |  17 +
>>  drivers/pci/controller/dwc/Kconfig            |  25 +-
>>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>>  drivers/pci/controller/dwc/pci-keystone.c     | 505 ++++++++++++++----
>>  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
>>  .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
>>  .../pci/controller/dwc/pcie-designware-host.c |  19 -
>>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>>  drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
>>  drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
>>  drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
>>  drivers/pci/endpoint/pci-epf-core.c           |  10 +-
>>  include/linux/pci-epc.h                       |   2 +
>>  include/linux/pci-epf.h                       |   3 +-
>>  16 files changed, 587 insertions(+), 148 deletions(-)
>>
>> -- 
>> 2.17.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
