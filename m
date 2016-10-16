From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sun, 16 Oct 2016 10:44:41 -0300
Subject: [PATCH] clk: samsung: clk-exynos-audss: Fix module autoload
In-Reply-To: <20161015172711.GA6465@kozik-lap>
References: <1476470645-22159-1-git-send-email-javier@osg.samsung.com>
 <20161015172711.GA6465@kozik-lap>
Message-ID: <521c63ea-2564-1739-696f-bc9178eab838@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/15/2016 02:27 PM, Krzysztof Kozlowski wrote:
> On Fri, Oct 14, 2016 at 03:44:05PM -0300, Javier Martinez Canillas wrote:
>> If the driver is built as a module, autoload won't work because the module
>> alias information is not filled. So user-space can't match the registered
>> device with the corresponding module.
>>
>> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>>
>> Before this patch:
>>
>> $ modinfo drivers/clk/samsung/clk-exynos-audss.ko | grep alias
>> alias:          platform:exynos-audss-clk
>>
>> After this patch:
>>
>> $ modinfo drivers/clk/samsung/clk-exynos-audss.ko | grep alias
>> alias:          platform:exynos-audss-clk
>> alias:          of:N*T*Csamsung,exynos5420-audss-clockC*
>> alias:          of:N*T*Csamsung,exynos5420-audss-clock
>> alias:          of:N*T*Csamsung,exynos5410-audss-clockC*
>> alias:          of:N*T*Csamsung,exynos5410-audss-clock
>> alias:          of:N*T*Csamsung,exynos5250-audss-clockC*
>> alias:          of:N*T*Csamsung,exynos5250-audss-clock
>> alias:          of:N*T*Csamsung,exynos4210-audss-clockC*
>> alias:          of:N*T*Csamsung,exynos4210-audss-clock
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  drivers/clk/samsung/clk-exynos-audss.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Indeed, this was missed by 4d252fd5719b thus I think it could be
> mentioned as fix tag (just for reference...):
> Fixes: 4d252fd5719b ("clk: samsung: Allow modular build of the Audio Subsystem CLKCON driver")
>

Indeed. I missed that, sorry. I'll post a v2 including this information.
 
> Anyway, this fixes the issue, so:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
>

Thanks!
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
