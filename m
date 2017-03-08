From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 8 Mar 2017 19:01:04 +0530
Subject: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
In-Reply-To: <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com> <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com>
Message-ID: <58C00798.1030302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 08 March 2017 05:07 PM, Joao Pinto wrote:
> ?s 11:35 AM de 3/8/2017, Kishon Vijay Abraham I escreveu:
>> Hi,
>>
>> On Wednesday 08 March 2017 05:02 PM, Joao Pinto wrote:
>>>
>>> Hi Kishon,
>>>
>>>>> Can you provide PCIE_GET_ATU_INB_UNR_REG_OFFSET (similar to
>>>>> PCIE_GET_ATU_OUTB_UNR_REG_OFFSET)?
>>>>
>>>> Yes of course, I will send you the definition soon.
>>>
>>> As promissed here is the definition for Inbound:
>>>
>>> +/* register address builder */
>>> +#define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
>>> +					((0x3 << 20) | (region << 9) |	\
>>> +					(0x1 << 8) | (register << 2))
>>
>> Cool, thanks!
> 
> No problem! If you have doubts, please let me know.

Okay, so this looks slightly different than the outbound macro since it takes
the register argument. In the case of outbound PCIE_GET_ATU_OUTB_UNR_REG_OFFSET
returns the offset which was used like
dw_pcie_write_dbi(pci, base, offset + reg, 0x4, val);

How should the value from PCIE_GET_ATU_INB_UNR_REG_ADDR be used?

Thanks
Kishon
