Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE159C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:47:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D60121908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFadCGEr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T6AMDNzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D60121908
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9W44lwP/Lo3nkwck53m9hKkI51dH5+9zoQpP+9/2oAE=; b=RFadCGErSct5Af
	Vs+ybp5yOcGJP4E/fDt5OXsk6VDHO0bIASpYTr4aewjm3Gc/x0XeWJ9MGYEAZUsnuWrmXnMXhDiIt
	+GuvEZgm/nffT/REvDcXveClbnQEGZ3lgErIZ6FeqtoUTEmbW2k/bMSwZ//gcPx/97Qa/kuwIEdka
	QkBWZIbFLt9mVppGRqOmMxrccxfNAqiwxwsX6XkveIPgZpiiajhV4gnVGtHslcRIWyW4otqfE8iOB
	9Olcp6Gpnm6nu5S5lAc0M9ghRaQ2543PACtD41L/7CLDJ7Rgv5+IlulzMI8jq41M4w47bq/k2ku+Q
	EfzzSe6wp6ufdPMKP7MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gry4l-0001Cj-CP; Fri, 08 Feb 2019 04:47:43 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gry4i-0001CQ-GY
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 04:47:42 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x184lYhg003837;
 Thu, 7 Feb 2019 22:47:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549601254;
 bh=RQjQd7DjeMh3goejjtirtc3uOhGBlaT8KVW7AkyYmdE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=T6AMDNzODLIOk8EOvT6hmsEazrvNG6X5HEQFy9ri+ZRRppWX5XTv+Aek59BUbCYbN
 1F5HWI6c8WJtQA3UTaRSOn2zgSAoKxIlctNDaUDbLxtB7QdAIlnIhGJXQxWPwmtK2m
 m9PtmpUlO3qe2O3ZV8btqhD5hBoqf6IE3hSzvZFA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x184lY6C047799
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 22:47:34 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 22:47:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 22:47:33 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x184lUY5004466;
 Thu, 7 Feb 2019 22:47:31 -0600
Subject: Re: [PATCH v2 6/9] PCI: dwc: Add support to use non default
 msi_irq_chip
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-7-kishon@ti.com>
 <20190207164853.GD21111@e107981-ln.cambridge.arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ff55a1e9-0998-685f-2d2c-e6cf522b0988@ti.com>
Date: Fri, 8 Feb 2019 10:16:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207164853.GD21111@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_204740_632668_CB6D9CEF 
X-CRM114-Status: GOOD (  24.85  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lorenzo,

On 07/02/19 10:18 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 07, 2019 at 04:39:21PM +0530, Kishon Vijay Abraham I wrote:
>> Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
>> configuring the MSI controller logic within the Designware IP. However
>> certain platforms like Keystone (K2G) which uses Desingware IP has
>> it's own MSI controller logic. For handling such platforms,
>> the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
>> functions.
>>
>> Add support to use different msi_irq_chip with default as
>> dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
>> msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
>> dw_pcie_host_ops. This will also help to get rid of get_msi_addr and
>> get_msi_data ops.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
>>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 721d60a5d9e4..042de09b0451 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>>  
>>  	for (i = 0; i < nr_irqs; i++)
>>  		irq_domain_set_info(domain, virq + i, bit + i,
>> -				    &dw_pci_msi_bottom_irq_chip,
>> +				    pp->msi_irq_chip,
>>  				    pp, handle_edge_irq,
>>  				    NULL, NULL);
>>  
>> @@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
>>  
>> +	if (!pp->msi_irq_chip)
>> +		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> 
> I think it is better to initialize pp->msi_irq_chip outside
> dw_pcie_allocate_domains(), it makes things clearer.
> 
> In:
> 
> dw_pcie_host_init() for dwc
> 
> or
> 
> msi_host_init() for platforms with that hook implemented.
> 
> Is there any gotcha I am missing ?

I added here only to avoid breaking "git bisect". Next patch adds
ks_pcie_msi_irq_chip in msi_host_init of keystone. However till then it has to
use dw_pci_msi_bottom_irq_chip. Adding anywhere else in dw_pcie_host_init would
mean msi_irq_chip is uninitialized for keystone.

Maybe I can add that in the commit log and move it to dw_pcie_host_init?

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
