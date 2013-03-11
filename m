From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 11 Mar 2013 15:51:46 +0100
Subject: [GIT PULL] Device Tree fixes for v3.9
In-Reply-To: <201303111443.21019.arnd@arndb.de>
References: <CACRpkdai0PRbK-R_KfNqkkVuSNn97v9Za8Doq71Zb-xCHW+J1A@mail.gmail.com>
 <201303012319.28231.arnd@arndb.de>
 <20130302005852.GA3106@gmail.com>
 <201303111443.21019.arnd@arndb.de>
Message-ID: <20130311145146.GA11450@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 11, 2013 at 02:43:20PM +0000, Arnd Bergmann wrote:
> On Saturday 02 March 2013, Lee Jones wrote:
> > > 
> > > I'm still getting build errors even with those patches applied:
> > > 
> > > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > > Warning (reg_format): "reg" property in /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> > 
> > These have been there since DT landed for the AB8500 - it's on my TODO
> > to fix, but it's a really low priority.
> 
> I've come up with the trivial patch below. I'm trying hard to kill off all known
> warnings, and will not take submissions introducing new ones if I see them.
> 
> Maybe Sam can just pick this up along with the other patch.
I'll take it.



> > > drivers/built-in.o: In function `ab8500_power_off':
> > > /git/arm-soc/drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
> > > /git/arm-soc/drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
> > > make[2]: *** [vmlinux] Error 1
> > 
> > This has already been fixed.
> > 
> > https://patchwork.kernel.org/patch/2163301/
> 
> It hasn't made it into v3.9-rc2 or even linux-next yet. I guess it got lost
> somewhere.
In my Inbox. I'm planning to send a pull request to Linus later this week.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
