From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Nov 2018 15:47:10 +0100
Subject: [PATCH] arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
In-Reply-To: <20181115143347.f4wtdipdhhyooatu@verge.net.au>
References: <20181113152201.24476-1-geert+renesas@glider.be>
 <cb6b55cc-c91b-b3e2-bc04-d7dfb80cfa98@gmail.com>
 <20181115143347.f4wtdipdhhyooatu@verge.net.au>
Message-ID: <9f303eb5-31a1-a3dc-66e9-645b46c5983c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2018 03:33 PM, Simon Horman wrote:
> On Wed, Nov 14, 2018 at 04:32:05PM +0100, Marek Vasut wrote:
>> On 11/13/2018 04:22 PM, Geert Uytterhoeven wrote:
>>> Enable R-Car Gen3 PCIe PHY support, which is needed for PCIe to function
>>> on the Renesas Condor board.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This helps
>>
>> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Thanks, would it be better to use enable this driver as a module rather
> than a built-in?

I think not, since the pcie-rcar cannot be compiled in as module, so the
associated phy driver shouldn't be compiled in as module either.

>>> ---
>>>  arch/arm64/configs/defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 9d0b42d96f03156e..77f98a7e860b8850 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -657,6 +657,7 @@ CONFIG_PHY_HISI_INNO_USB2=y
>>>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
>>>  CONFIG_PHY_QCOM_QMP=m
>>>  CONFIG_PHY_QCOM_USB_HS=y
>>> +CONFIG_PHY_RCAR_GEN3_PCIE=y
>>>  CONFIG_PHY_RCAR_GEN3_USB2=y
>>>  CONFIG_PHY_RCAR_GEN3_USB3=m
>>>  CONFIG_PHY_ROCKCHIP_EMMC=y
>>>
>>
>>
>> -- 
>> Best regards,
>> Marek Vasut
>>


-- 
Best regards,
Marek Vasut
