From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Mar 2013 23:19:28 +0000
Subject: [GIT PULL] Device Tree fixes for v3.9
In-Reply-To: <CACRpkdai0PRbK-R_KfNqkkVuSNn97v9Za8Doq71Zb-xCHW+J1A@mail.gmail.com>
References: <CACRpkdai0PRbK-R_KfNqkkVuSNn97v9Za8Doq71Zb-xCHW+J1A@mail.gmail.com>
Message-ID: <201303012319.28231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 March 2013, Linus Walleij wrote:
> Hi Olof, Arnd,
> 
> Here is a pull request for the Device Tree fixes for Ux500 in the v3.9 series.
> 
> Basically this should have come in earlier, but I failed at processing
> it in time
> for the merge window. t should have been this cycle's Ux500 DT topic branch.
> 
> As discussed I've started to funnel all Ux500 DT stuff through my ux500 tree
> in order to do some coordination and I became overloaded. So this patch set
> got stuck in the air. It was not trivial to push since this branch had a few
> conflicts with other branches. (There might have been a good way to solve
> that but I didn't come up with it in time.)
> 
> Basically how to handle it is your pick, in the old times I would have pushed
> it ASAP, maybe during -rc1, as it restores the Ux500 DT to a working state
> for the basic functionality (notably ethernet and MMC on the Snowball).
> 
> Please pull it in, for fixes or -next at your decision. As you can see the
> base is at Torvald's HEAD since all dependencies that conflicted with
> this branch is now there. If you want me to resend based on v3.9-rc1
> or so, just tell.


I'm still getting build errors even with those patches applied:

Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
drivers/built-in.o: In function `ab8500_power_off':
/git/arm-soc/drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
/git/arm-soc/drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
make[2]: *** [vmlinux] Error 1

	Arnd 1 `
