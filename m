From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Mar 2016 18:59:45 +0900
Subject: [PATCH 06/10] ARM: dts: Add MSHC0 dt node for eMMC device for
 exynos3250-artik5 module
In-Reply-To: <56E67319.1050502@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-7-git-send-email-cw00.choi@samsung.com>
 <56E660D2.9090706@samsung.com> <56E67319.1050502@samsung.com>
Message-ID: <56E68B91.3080906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2016 17:15, Chanwoo Choi wrote:
> On 2016? 03? 14? 15:57, Krzysztof Kozlowski wrote:
>> On 14.03.2016 11:04, Chanwoo Choi wrote:
>>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>>
>>> This patch adds MSHC (Mobile Storage Host Controller) dt node for Exynos3250
>>> SoC. MSHC is an interface between the system and the eMMC device.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>>> index 97d0087efb9f..75b291c10cdc 100644
>>> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>>> @@ -277,6 +277,25 @@
>>>  	};
>>>  };
>>>  
>>> +&mshc_0 {
>>> +	num-slots = <1>;
>>> +	broken-cd;
>>> +	non-removable;
>>
>> Broken or non-removable, not both.
> 
> I'll remove the 'broken-cd' property.
> 
>>
>>> +	cap-mmc-highspeed;
>>> +	desc-num = <4>;
>>> +	card-detect-delay = <200>;
>>> +	vmmc-supply = <&ldo11_reg>;
>>
>> Isn't this vqmmc-supply?
> 
> I'll fix it as following by using ldo12_reg:
> 	vmmc-supply = <&ldo12_reg>;

Sure, looks good.

> 
>>
>> BTW, both MMC0 regulators (ldo11, ldo12) are marked as always-on. Why
>> they cannot be controlled by XMMC0CDN (just like on Rinato)?
> 
> I'll fix it like rinato board to handle the ldo11/ldo12 as following:
> gpk0-2 is XMMC0CDN pin.

Great! Thanks,
Krzysztof
