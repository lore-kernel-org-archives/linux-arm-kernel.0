From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 14 Jul 2014 11:50:54 +0200
Subject: [PATCH 2/6] ARM: EXYNOS: Fix core ID used by platsmp and hotplug
 code
In-Reply-To: <031001cf9aaf$959cf6c0$c0d6e440$@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-3-git-send-email-t.figa@samsung.com>
 <031001cf9aaf$959cf6c0$c0d6e440$@samsung.com>
Message-ID: <53C3A7FE.8000401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 08.07.2014 15:21, Kukjin Kim wrote:
> Tomasz Figa wrote:
>>
>> When CPU topology is specified in device tree, cpu_logical_map() does
>> not return core ID anymore, but rather full MPIDR value. This breaks
>> existing calculation of PMU register offsets on Exynos SoCs.
>>
>> This patch fixes the problem by adjusting the code to use only core ID
>> bits of the value returned by cpu_logical_map() to allow CPU topology to
>> be specified in device tree on Exynos SoCs.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> 
> Looks good to me, but I think we don't need this fix in 3.16 because the CPU
> topology is not specified in DT yet...if I'm wrong, please correct me.

CPU topology is already specified in DT for Exynos3250, 5250, 5260, 5410
and 5420/5800.

This patch also fixes CPU hotplug on SoCs with more than 2 cores,
because it removes incorrect condition check in platform_do_lowpower().

Please take this fix for next -rc release.

Best regards,
Tomasz
