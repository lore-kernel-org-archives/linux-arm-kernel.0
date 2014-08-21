From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 21:11:21 -0700
Subject: [PATCH v7 04/11] arm: Support restart through restart handler
 call chain
In-Reply-To: <1408495538-27480-5-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-5-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=VNLCc5VVxQspZrZPrZ_JZQO+SJtkA61CAYj-f5fnA2LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> The kernel core now supports a restart handler call chain for system
> restart functions.
>
> With this change, the arm_pm_restart callback is now optional, so
> drop its initialization and check if it is set before calling it.
> Only call the kernel restart handler if arm_pm_restart is not set.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: Dropped null_restart and made arm_pm_restart truly optional.
> v6: No change.
> v5: Renamed restart function to do_kernel_restart
> v4: No change.
> v3: Use wrapper function to execute notifier call chain.
> v2: Only call notifier call chain if arm_pm_restart is not set.
>     Do not include linux/watchdog.h.
>
>  arch/arm/kernel/process.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
