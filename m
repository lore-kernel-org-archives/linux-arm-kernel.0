From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Dec 2013 19:17:02 -0800
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14
In-Reply-To: <20131201211341.GX2879@titan.lakedaemon.net>
References: <20131201211341.GX2879@titan.lakedaemon.net>
Message-ID: <CAOesGMgexET170EJ5jOoXiV1xQ+K-tngFWydxiKW4zT_WGuuqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,



On Sun, Dec 1, 2013 at 1:13 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Guys,
>
> Another round of small changes that have been in -next for a week or so.
>
> thx,
>
> Jason.
>
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14
>
> for you to fetch changes up to bd22bb23919e6727967e90eb89bb41ab790bcd2d:
>
>   ARM: Dove: Add RTC interrupt via PMU interrupt controller. (2013-11-26 16:10:49 +0000)
>
> ----------------------------------------------------------------
> mvebu DT changes for v3.14
>
>  - mvebu:
>     - remove unneeded OS-specific properties from led nodes
>     - add NAND controller to Armada boards
>     - add sata leds to readynas 104
>     - add gpio-poweroff to readynas duo v2
>
>  - kirkwood:
>     - comment cleanup in sheevaplug files
>     - default pinctrl for sdio
>     - sdio in guruplug is non-removable
>
>  - orion5x:
>     - typo fix
>
>  - dove:
>     - typo fix
>     - add PMU interrupt controller and RTC interrupt via same
>
> ----------------------------------------------------------------
> Andrew Lunn (2):
>       ARM: Dove: Add DT node for PMU interrupt controller.

This one produces a boot time warning on dove now:

[    0.049752] irq: no irq domain found for
/mbus/internal-regs/pmu-interrupt-ctrl at d0050 !
[    0.049764] ------------[ cut here ]------------
[    0.049790] WARNING: CPU: 0 PID: 1 at
/home/build/work/batch/drivers/of/platform.c:171
of_device_alloc+0x178/0x17c()
[    0.049796] Modules linked in:
[    0.049810] CPU: 0 PID: 1 Comm: swapper Not tainted
3.13.0-rc2-00160-g788b89b #1
[    0.049844] [<c001356c>] (unwind_backtrace+0x0/0xf4) from
[<c0010dc0>] (show_stack+0x10/0x14)
[    0.049863] [<c0010dc0>] (show_stack+0x10/0x14) from [<c001b448>]
(warn_slowpath_common+0x6c/0x84)
[    0.049879] [<c001b448>] (warn_slowpath_common+0x6c/0x84) from
[<c001b4fc>] (warn_slowpath_null+0x1c/0x24)
[    0.049895] [<c001b4fc>] (warn_slowpath_null+0x1c/0x24) from
[<c02eef8c>] (of_device_alloc+0x178/0x17c)
[    0.049913] [<c02eef8c>] (of_device_alloc+0x178/0x17c) from
[<c02eefc0>] (of_platform_device_create_pdata+0x30/0x88)
[    0.049932] [<c02eefc0>]
(of_platform_device_create_pdata+0x30/0x88) from [<c02ef108>]
(of_platform_bus_create+0xe4/0x168)
[    0.049949] [<c02ef108>] (of_platform_bus_create+0xe4/0x168) from
[<c02ef164>] (of_platform_bus_create+0x140/0x168)
[    0.049979] ---[ end trace 16502b0864dc0741 ]---


Please follow up with incremental branch/fix (or just send patch directly).



-Olof
