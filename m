From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 20 Jan 2012 14:15:15 +0530
Subject: [PATCH 0/5] uart updates
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAL8m4x3uOgWFvaVP9BK1L6myDayf94fZqcQS5NvaLEvhwKnsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> The patch series does the following
>
> - Make the Make the suspend/resume functions depend on
> ? ?CONFIG_PM_SLEEP
> - Fix the serial omap probe's error handling
> - Make he context_loss_cnt signed so that error handling is
> ?possible.
>
>

After fixing Kevin's comment's,

If can add some testing updates it be nice.

like :
boot tested or any other tests done on xxx boards.

--
Thanks,
Govindraj.R



> Shubhrajyoti D (5):
> ?omap-serial :Make the suspend/resume functions depend on
> ? ?CONFIG_PM_SLEEP.
> ?omap-serial: make serial_omap_restore_context depend on
> ? ?CONFIG_PM_RUNTIME
> ?omap-serial: Fix the error handling in the omap_serial probe
> ?ARM : OMAP : serial : Make context_loss_cnt signed
> ?OMAP : serial : Check for error in get_context_loss_count
>
> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?2 +-
> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 41 ++++++++++++++++--------
> ?2 files changed, 28 insertions(+), 15 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
