From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Jun 2013 12:12:43 +0530
Subject: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
In-Reply-To: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
References: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51CD3063.5010309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/27/2013 8:40 PM, Daniel Lezcano wrote:
> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target
> residency to 100000, assuming this is a careless mistake.
> 
> commit 19976c2a88d125aec16b9255c7197c297bbdd637
> Author: Robert Lee <rob.lee@linaro.org>
> Date:   Tue Mar 20 15:22:45 2012 -0500
> 
>     ARM: davinci: Consolidate time keeping and irq enable
> 
>     Enable core cpuidle timekeeping and irq enabling and remove that
>     handling from this code.
> 
>     Signed-off-by: Robert Lee <rob.lee@linaro.org>
>     Reviewed-by: Kevin Hilman <khilman@ti.com>
>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Acked-by: Jean Pihet <j-pihet@ti.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> The same happened to the at91's cpuidle driver.
> 
> Fix it by putting the initial value to 10000.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
