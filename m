From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 21:13:29 -0700
Subject: [PATCH v7 03/11] arm64: Support restart through restart handler
 call chain
In-Reply-To: <1408495538-27480-4-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-4-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=VwnbsHSMMH+mMucTL2BnX2mpAOEmpyyH7ta2TFLahbFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> The kernel core now supports a restart handler call chain to restart
> the system. Call it if arm_pm_restart is not set.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change.
> v6: No change.
> v5: Renamed restart function to do_kernel_restart
> v4: No change.
> v3: Use wrapper function to execute notifier call chain.
> v2: Only call notifier call chain if arm_pm_restart is not set.
>     Do not include linux/watchdog.h.
>
>  arch/arm64/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
