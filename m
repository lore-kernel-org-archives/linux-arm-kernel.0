From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 19 Nov 2014 09:40:07 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: fix failure setting CPU voltage
 by enabling dependent I2C controller
In-Reply-To: <546C4BA1.6090701@samsung.com> (Kukjin Kim's message of "Wed, 19
 Nov 2014 16:49:53 +0900")
References: <1416337853-1558-1-git-send-email-tyler.baker@linaro.org>
 <546C4BA1.6090701@samsung.com>
Message-ID: <7hbno3w0lk.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim@samsung.com> writes:

> On 11/19/14 04:10, Tyler Baker wrote:
>
> Hi,
>
> + Arnd, Olof and Kevin
>
>> This patch fixes a long standing issue introduced during the 3.16 merge window.
>> Shortly after the merge, exynos5250-based arndale boards began to produce the 
>> following errors:
>> 
>> kern.err kernel:  exynos-cpufreq exynos-cpufreq: failed to set cpu voltage
>> kern.err kernel:  cpufreq: __target_index: Failed to change cpu frequency: -22
>> 
>> Further analysis revealed that the S5M8767 voltage regulator used on the 
>> exynos5250-based arndale board utilizes the S3C2410 I2C controller. If the 
>> S3C2410 I2C controller driver is not enabled, the S5M8767 voltage regulator 
>> fails to probe. Therefore a dependency exists between these two drivers. 
>> In the exynos_defconfig both CONFIG_REGULATOR_S5M8767 and CONFIG_I2C_S3C2410 
>> options are enabled, and no errors are produced. However, in the 
>> multi_v7_defconfig only the CONFIG_REGULATOR_S5M8767 option is enabled and the 
>> errors are present. So let's enable the CONFIG_I2C_S3C2410 option in the 
>> multi_v7_defconfig to allow the S5M8767 voltage regulator to probe.
>> 
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Applied to arm-soc/fixes, which is merged into arm-soc/for-next.

Thanks,

Kevin
