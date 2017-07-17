From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Mon, 17 Jul 2017 09:59:14 +0100
Subject: [RFC] PCI: dwc: designware: allow customize unroll registers'
 readl/writel
In-Reply-To: <20170713185213.0b04a4fc@xhacker>
References: <20170713184837.541ccf26@xhacker> <20170713185213.0b04a4fc@xhacker>
Message-ID: <825636e2-f685-738e-46d9-bbc483e95606@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

?s 11:52 AM de 7/13/2017, Jisheng Zhang escreveu:
> On Thu, 13 Jul 2017 18:48:37 +0800 Jisheng Zhang wrote:
> 
>> Hi Joao, Jingoo,
>>
>> Now, the PCIE_GET_ATU_OUTB_UNR_REG_OFFSET macro is defined as:
>>
>> /* Register address builder */
>> #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)        \
>>                         ((0x3 << 20) | ((region) << 9))
>>
>> I have one question: where does the (0x3 << 20) come from? 2MB space, a bit

From, the PCIe Core 4.80 you have the new feature Unroll, which was developed
for both iATU and DMA.
To inform the Core that you want to access an Unroll register address, bits 20
and 21 must be set, and thats where 0x3 comes from.

If it is not clear please let me know.

> 
> sorry, typo. (0x3 << 20) should be 3MB.
> 
>> large. And I didn't find it in the databook. Is it platform specific?
>> If yes, I want to cook one patch to customize unroll registers' readl/writel.
>>
>> And how does (0x3 << 20) enable DBI2 access?
>>
>> Thanks in advance,
>> Jisheng
> 

Thanks,
Joao
