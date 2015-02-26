From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 27 Feb 2015 05:52:52 +0900
Subject: [PATCH] ARM: EXYNOS: Don't use LDREX and STREX after disabling
 cache coherency
In-Reply-To: <54E3BFB3.5030801@codeaurora.org>
References: <1424093802-5488-1-git-send-email-k.kozlowski@samsung.com>
 <54E3BFB3.5030801@codeaurora.org>
Message-ID: <54EF87A4.6090609@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/15 07:24, Stephen Boyd wrote:
> On 02/16/15 05:36, Krzysztof Kozlowski wrote:
>> During CPU shutdown the exynos_cpu_power_down() is called after
>> disabling cache coherency and it uses LDREX and STREX instructions (by
>> calling of_machine_is_compatible() -> kobject_get() -> kref_get()).
>>
>> The LDREX and STREX should not be used after disabling the cache
>> coherency so just use soc_is_exynos().
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Fixes: adc548d77c22 ("ARM: EXYNOS: Use MCPM call-backs to support S2R on exynos5420")
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
> 
> Looks good to me.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
Thanks for this fix, applied.

- Kukjin
