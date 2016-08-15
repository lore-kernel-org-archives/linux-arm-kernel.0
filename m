From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Aug 2016 09:00:03 -0300
Subject: [PATCH 1/1] ARM: mach-imx: imx6ul: populates platform device at
 .init_machine
In-Reply-To: <1471232236-12635-1-git-send-email-peter.chen@nxp.com>
References: <1471232236-12635-1-git-send-email-peter.chen@nxp.com>
Message-ID: <CAOMZO5BzxFLH-_71_AEU+1rjssuz-rNuLcoYaocXegioD5Zbcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Aug 15, 2016 at 12:37 AM, Peter Chen <peter.chen@nxp.com> wrote:
> At imx6ul_init_machine, it calls imx6ul_pm_init which needs to find
> platform device for ocram, but the default populate platform device is at
> of_platform_default_populate_init, which is located at arch_initcall_sync,
> and called later than arch_initcall (.init_machine is located at that).
> So below warning message will be showed during boots up:
>
>         imx6q_suspend_init: failed to find ocram device!
>         imx6_pm_common_init: No DDR LPM support with suspend -19!
>
> Due to lack of ocram device, the suspend mode "mem" which needs ocram to
> store suspend routine code is invalid.
>
> This commit populates platform device before imx6ul_pm_init like other
> imx6 platforms do, and the suspend mode "mem" can work successfully.
>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: <stable@vger.kernel.org>
> Fixes: ee4a5f838c84 ("ARM: imx: add suspend/resume support for i.mx6ul")
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
