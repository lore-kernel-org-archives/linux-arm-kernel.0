From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 18:52:09 +0900
Subject: [PATCH 04/10] ARM: dts: Add MSHC2 dt node for Exynos3250 SoC
In-Reply-To: <56E67632.30602@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-5-git-send-email-cw00.choi@samsung.com>
 <56E658AE.5070806@samsung.com> <56E67632.30602@samsung.com>
Message-ID: <56E689C9.6030405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2016 17:28, Chanwoo Choi wrote:
> On 2016? 03? 14? 15:22, Krzysztof Kozlowski wrote:
>> On 14.03.2016 11:04, Chanwoo Choi wrote:
>>> This patch adds the MSHC2 (Mobile Storage Host Controller) Device Tree node for
>>> Exynos3250 SoC.
>>>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 35 +++++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos3250.dtsi         | 13 ++++++++++++
>>>  2 files changed, 48 insertions(+)
>>
>>
>> After looking at your other patch ("ARM: dts: Add initial pin
>> configuration for exynos3250-rinato") I have doubts. The Monk will be
>> affected.
> 
> You're right. On monk board, this line may be not stable.
> 
>>
>> Here you are configuring all the gpk2 GPIOS for EMMC2 mode. Then on
>> Rinato you are setting it back to default non-used state. However the
>> Monk board will remain with this new configuration... so you would have
>> to add initial-state also for Monk.
> 
> OK. I'll do it.
> 
>>
>> But how about doing opposite? Configure here the pins to unused state
>> and enable them only for Artik board?
>>
>> What do you think?
> 
> I think that gpk2-[0~6] pins are fixed for MMC2 device.
> So, it is good to add the pin setting for gpk2-[0~6] to exynos3250-pinctrl.dtsi.
> 
> If mmc2 device is not used like rinato and monk board,
> we should add the initial setting as NC (not connected) pin state
> as other patch (ARM: dts: Add initial pin configuration for exynos3250-rinato).

Okay, fine to me.

BR,
Krzysztof
