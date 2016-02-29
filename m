From: frank.li@nxp.com (Frank Li)
Date: Mon, 29 Feb 2016 15:23:06 +0000
Subject: Booting MX7Solo with 4.5-rc6
In-Reply-To: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
References: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
Message-ID: <AMSPR04MB263126AA78BEE3D8818F80388BA0@AMSPR04MB263.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, February 29, 2016 8:23 AM
> To: Frank Li <frank.li@nxp.com>; Hui Liu <jason.hui.liu@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>; linux-arm-kernel at lists.infradead.org;
> Dong Aisheng <dongas86@gmail.com>
> Subject: Booting MX7Solo with 4.5-rc6
> 
> Hi,
> 
> I am trying to boot linux-next 20160229 on a m7solo warp board and this is
> what I get:
> 
> http://pastebin.com/TmQdqd2B
> 
> I can boot this board fine using NXP 3.14.52 kernel.
> 
> These clock warnings also happen on a mx7d sabresd board, but the boot
> proceed fine.

It caused usleep_range(50, 500) in clk_pllv3_wait_lock.
Need aisheng's patch to fix it.
> 
> Any ideas as to what needs to be done in order to boot a MX7S?

Can you try to disable arch_timer in dts?

> 
> I have also tried to disable cpu1 in the imx7d.dtsi, but it did not help.
> 
> Thanks
