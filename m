From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 21:10:31 -0700
Subject: [PATCH v7 02/11] power/restart: Call machine_restart instead of
 arm_pm_restart
In-Reply-To: <1408495538-27480-3-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-3-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=Va8UrpDCLjFQJ6j-K0C3v7NPfifaJGtReCkUEu3x0mLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> machine_restart is supported on non-ARM platforms, and and ultimately calls
> arm_pm_restart, so dont call arm_pm_restart directly but use the more
> generic function.
>
> Cc: Russell King <linux@arm.linux.org.uk>

Do you need to submit this to his patch tracker to get him to pick it
up?  How are you envisioning that this series land?  It crosses a lot
of boundaries so I guess will need a reasonable amount of coordination
between maintainers...


> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change.
> v6: No change.
> v5: No change.
> v4: No change.
> v3: No change.
> v2: Added patch.
>
>  drivers/power/reset/restart-poweroff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
