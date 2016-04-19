From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 19 Apr 2016 07:46:17 +0200
Subject: [PATCH] ARM: dts: exynos: Remove unsupported s2mps11 regulator
 bindings from Exynos5420 boards
In-Reply-To: <571510D5.3090406@osg.samsung.com>
References: <1460965453-5337-1-git-send-email-k.kozlowski@samsung.com>
 <571510D5.3090406@osg.samsung.com>
Message-ID: <5715C629.1030602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2016 06:52 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 04/18/2016 03:44 AM, Krzysztof Kozlowski wrote:
>> The bindings like s2mps11,buck6-ramp-enable or s2mps11,buck2-ramp-delay
>> where ignored. They were never parse by s2mps11 regulator driver. Also
>> the values used in these bindings were equal to default reset values of
>> S2MPS11 device. It is safe to remove them.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks.

> 
> On a related note, the s5m8767 regulator driver parses similar DT properties
> ("s5m8767,pmic-buck-ramp-delay", "s5m8767,pmic-buck2-ramp-enable", etc) that
> are not in Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt.
> 
> So those should either be added to the binding doc or removed from the driver
> if are not correct (I don't have documentation for the s5m8767 PMIC but the
> DT properties are not use by any DTS in mainline using the s5m8767 PMIC).

That's the grey area. :) I mean that instead of making these implemented
bindings an interface, they should rather be converted to standard
regulator bindings. However the device is quite old, not used on newer
boards, so there is no interest in improving this. In the same time
removal of this code is not strictly necessary. Its existence does not hurt.

Best regards,
Krzysztof
