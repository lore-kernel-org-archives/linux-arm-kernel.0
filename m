From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 8 Dec 2015 14:33:00 +0000
Subject: [PATCH 09/19] mfd: arizona-core: msleep() is unreliable for
 anything <20ms use usleep_range() instead
In-Reply-To: <1449489032-14374-10-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
 <1449489032-14374-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20151208143300.GD6058@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 11:50:22AM +0000, Lee Jones wrote:
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> +               msleep(1);
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> +                       msleep(5);
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> +               msleep(1);
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> +               msleep(1);
> 
> total: 0 errors, 4 warnings, 1407 lines checked
> 
> Cc: patches at opensource.wolfsonmicro.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

This doesn't actually appear to cc patches. But all looks good:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
