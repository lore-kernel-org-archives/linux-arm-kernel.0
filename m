Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB6C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:32:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DBC2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E0TEWwaX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AoQ8p9HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DBC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PmsDEtqLdRBwNwZGn91nzYG9oP02asZpQHi8qteUClg=; b=E0TEWwaXh5B7fT
	91UT31aCZOgCjHMFYHkLp7w/2bxxkjIWy63hqiGD28C/cuTIF93T4UfkVvMfNR+vLpBQ/Ex43MDfC
	XucXMTVPchiIWE874HMH4mlLLWu/kdne4vP0jF66N84tHaGBVYV8iT1yYo3JVo48yrqHIOSrcF/Iu
	LU9tt8Zf6dpqgl+LTxnn1b4D3kt8SnHhcg5dZTlPn76i7e9DeI4Rc06JZs753N0BA0dDm0dRouhMx
	6OkTO6fHLBdrggyPqaHzCEHCjF3JQDS1r+oCILUs8LoOwDY/Is5gMCFSZ1ahkcRP8qzCPTDdco/xQ
	2BPWoa1NBhOZ9Jqcr0Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grxqQ-0004U8-6K; Fri, 08 Feb 2019 04:32:54 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grxqL-0004Tm-KQ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 04:32:51 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x184WfSI073156;
 Thu, 7 Feb 2019 22:32:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549600361;
 bh=v7CNHDwI7JL9k+8CJw1FIo64pVpyZaEbNQHdnQYswL8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=AoQ8p9HVhHtStavIVBw5Jr9ppG7bik7KZORGFqivoMo98suQblvYqQX3or+UjeY9G
 jxt3upof9GP5o1BD6xrbRhcZ+PGdzY6rcAXBxyVvt7/JyUzBYL6OtWf2NUZ0wIxZSf
 n2Gc+lTZ3CONuMjVm0eOomZaP+xVEL4pUx3L04QA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x184WfpB104629
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 22:32:41 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 22:32:40 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 22:32:40 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x184WbF3015086;
 Thu, 7 Feb 2019 22:32:38 -0600
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com>
 <20190207161502.GC21111@e107981-ln.cambridge.arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <55d1eeef-e8a5-1801-96e7-3cfed8f756fe@ti.com>
Date: Fri, 8 Feb 2019 10:02:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207161502.GC21111@e107981-ln.cambridge.arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_203249_814357_C75B6F2A 
X-CRM114-Status: GOOD (  26.07  )
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

On 07/02/19 9:45 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
>> The legacy interrupt handler directly checks the IRQ_STATUS register
>> corresponding to a interrupt line inorder to invoke generic_handle_irq.
>>
>> While this is okay for K2G platform which has separate interrupt line for
>> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
>> has a single interrupt line for all the legacy interrupts. So for AM654
>> the interrupt handler won't be able to directly check the IRQ_STATUS
>> register corresponding to the interrupt line.
>>
>> Also the legacy interrupt handler uses 'virq' obtained from
>> irq_of_parse_and_map to find the correct interrupt line which raised the
>> interrupt. There is no guarantee that virq assigned for contiguous hardware
>> irq will be contiguous and the interrupt handler might end up checking
>> the wrong IRQ_STATUS register.
>>
>> In order to overcome the above issues, read the IRQ_STATUS register of
>> all the 4 legacy interrupts to determine which interrupt was raised.
>>
>> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 5286a480f76b..4cf9849d5a1d 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>>  {
>>  	struct dw_pcie *pci = ks_pcie->pci;
>>  	struct device *dev = pci->dev;
>> -	u32 pending;
>>  	int virq;
>>  
>> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
>> -
>> -	if (BIT(0) & pending) {
>> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
>> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
>> -		generic_handle_irq(virq);
>> -	}
>> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
>> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
>> +	generic_handle_irq(virq);
>>  
>>  	/* EOI the INTx interrupt */
>>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
>> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>>  	struct dw_pcie *pci = ks_pcie->pci;
>>  	struct device *dev = pci->dev;
>> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	unsigned int irq_no;
>> +	u32 reg;
>>  
>>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>>  
>> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  	 * ack operation.
>>  	 */
>>  	chained_irq_enter(chip, desc);
>> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
>> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
> 
> I understand the aim of this code but now on platforms where there
> is a 1:1 relationship between Linux IRQ and INTX this loop has
> steps carried out for nothing.
> 
> If I understand the code correctly what this code does is force
> looping over INTX status regs regardless of what linux IRQ number was
> actually active.

right. This driver is used by 2 platforms K2G and AM654 (The patches are there
on the list). K2G has 4 interrupt lines for each of the 4 legacy interrups
while AM654 has a single interrupt line. One of the purpose of this patch is to
have a single legacy interrupt handler for both K2G and AM654.
> 
> You could do something faster by creating a matrix LinuxIRQ x INTx to
> detect what INTx status register should actually be checked.
> 
> This seems overkill to me but it is not that complicated to implement
> and may clarify the code (and avoid reading up to three registers for
> nothing on the IRQ code path, which can make things faster too).

Agreed. But that's not possible for AM654 which has a single interrupt line and
all the registers has to be read to identify the interrupt source.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
