From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 12:39:32 -0300
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <57111429.6040802@nxtcontrol.com>
References: <57111429.6040802@nxtcontrol.com>
Message-ID: <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 1:17 PM, Stanislav Meduna
<stanislav.meduna@nxtcontrol.com> wrote:
> Hi,
>
> I am using an TQMa53 board, which expects to be resetted
> by watchdog circuit. In older kernels ths was done in
> by mxc_restart defined in arch/arm/mach-imx/system.c
> and initialized and wired in mach-imx53.c.
>
> Current kernels however do not use this and the mach-imx53.c
> does not set .restart. I am getting
>   imx2-wdt 53f98000.wdog: Device shutdown: Expect reboot!
>   reboot: Restarting system
> and the system just hangs there.

I am able to reproduce this issue on a imx6ul-evk board.

It works fine on a imx6q sabresd board though.
