From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 31 Aug 2016 14:53:02 +0200
Subject: [PATCH 1/9] ARM: dts: exynos: Add macros for GPIO configuration
In-Reply-To: <28320955.k33BrW2NEN@wuerfel>
References: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
 <1472645613-5362-2-git-send-email-k.kozlowski@samsung.com>
 <28320955.k33BrW2NEN@wuerfel>
Message-ID: <07ddb8f8-a9e1-6105-ace9-edb5c8cc2f57@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2016 02:42 PM, Arnd Bergmann wrote:
> On Wednesday, August 31, 2016 2:13:25 PM CEST Krzysztof Kozlowski wrote:
>>
>> +#define PIN_PULL_NONE          0
>> +#define PIN_PULL_DOWN          1
>> +#define PIN_PULL_UP            3
>> +
>> +#define PIN_DRV_LV1            0
>> +#define PIN_DRV_LV2            2
>> +#define PIN_DRV_LV3            1
>> +#define PIN_DRV_LV4            3
>> +
>> +#define PIN_FUNC_INPUT         0
>> +#define PIN_FUNC_OUTPUT                1
>> +#define PIN_FUNC_SPC_2         2
>> +#define PIN_FUNC_SPC_3         3
>> +#define PIN_FUNC_SPC_4         4
>> +#define PIN_FUNC_SPC_5         5
>> +#define PIN_FUNC_SPC_F         0xf
> 
> Any reason for having a copy in each of those files instead of one
> that is shared across all of them?

The drive strengths differ between some of them. There are three groups
of drive strengths:
1. Exynos3250, Exynos4 (all) and Exynos5250,
2. Exynos5260,
3. Exynos5410, 542x and 5800.

Rest (functions and pull up/down) is the same so sharing the defines is
possible but not that obvious. Solution would be for example adding a
SoC-family prefix for PIN_DRV_LVx. Not that good...

I could put it into three DTSI:
 - exynos3-pinctrl.dtsi (new file)
 - exynos5260-pinctrl.dtsi (like it is now)
 - exynos54xx-pinctrl.dtsi (new file)

which would reduce the duplication. Other ideas?

Best regards,
Krzysztof
