From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 12 Jan 2012 13:02:27 +0530
Subject: [PATCH RFC] omap-serial: make serial_omap_restore_context depend
 on CONFIG_PM_RUNTIME
In-Reply-To: <1326261400-3929-1-git-send-email-shubhrajyoti@ti.com>
References: <1326261400-3929-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAL8m4x5wf_XtPSe=GEG9tokrZmbVy4j5rbuwmoLYBuiVaWMWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 11:26 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> The function serial_omap_restore_context is called only from
> serial_omap_runtime_resume which depends on CONFIG_PM_RUNTIME. Make
> serial_omap_restore_context also compile conditionally.
>
> if CONFIG_PM_RUNTIME is not defined below warn may be seen.
>
> ?LD ? ? ?net/xfrm/built-in.o
> drivers/tty/serial/omap-serial.c:1524: warning: 'serial_omap_restore_context' defined but not used
> ?CC ? ? ?drivers/tty/vt/selection.o
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> applies on Tony's uart branch
>

Should apply on cleanly on mainline also
Please check.

Same comments for other patch (omap-serial :Make the
suspend/resume functions depend on CONFIG_PM_SLEEP)

--
Thanks,
Govindraj.R
