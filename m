From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 19 Aug 2016 15:40:49 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Don't attempt to enable
 schedutil governor as module
In-Reply-To: <1471612328-6467-2-git-send-email-javier@osg.samsung.com>
References: <1471612328-6467-1-git-send-email-javier@osg.samsung.com>
 <1471612328-6467-2-git-send-email-javier@osg.samsung.com>
Message-ID: <9c71ddbd-deb1-1e07-7421-53bb58359bad@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 03:12 PM, Javier Martinez Canillas wrote:
> The schedutil CPUFreq governor could be built as a module but the commit
> 58919e83c85c ("cpufreq / sched: Pass flags to cpufreq_update_util()")
> made it non-modular so attempting to enable as module leads to a warning:
> 
> warning: symbol value 'm' invalid for CPU_FREQ_GOV_SCHEDUTIL
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good.

Applied... wait, no, these are not in samsung-soc list so they miss also
from patchwork. For reference:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Please post it to linux-samsung-soc, unless it goes through arm-soc or
other tree.

Best regards,
Krzysztof
