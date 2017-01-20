From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 20 Jan 2017 08:49:09 +0530
Subject: [PATCH 3/3] arm64: dts: exynos: Use macros for pinctrl
 configuration on Exynos7
In-Reply-To: <20170118150131.ttalzfxxtpbrw5gb@kozik-lap>
References: <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170118054013epcas5p3b20dca776ee350f4ba863db24d3dea67@epcas5p3.samsung.com>
 <1484718141-28785-4-git-send-email-pankaj.dubey@samsung.com>
 <20170118150131.ttalzfxxtpbrw5gb@kozik-lap>
Message-ID: <7f003a7a-897f-2fef-f48c-44db75be84ff@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Wednesday 18 January 2017 08:31 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 18, 2017 at 11:12:21AM +0530, Pankaj Dubey wrote:
>> Usage of DTS macros instead of hard-coded numbers makes code easier to
>> read.  One does not have to remember which value means pull-up/down or
>> specific driver strength.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   4 +-
>>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 302 ++++++++++++------------
>>  2 files changed, 154 insertions(+), 152 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>> index c528dd5..1b2db9f0 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>> @@ -328,8 +328,8 @@
>>  &pinctrl_alive {
>>  	pmic_irq: pmic-irq {
>>  		samsung,pins = "gpa0-2";
>> -		samsung,pin-pud = <3>;
>> -		samsung,pin-drv = <3>;
>> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;
>>  	};
>>  };
> 
> This is not equal (value 3 => 1). If the change was intended, please do
> in separate patch.
> 

This was not an intended change. It should be EXYNOS4_PIN_DRV_LV4, I
will submit another set after fixing this.

Thanks,
Pankaj Dubey

> Rest looks fine.
> 
> Best regards,
> Krzysztof
> 
> 
> 
