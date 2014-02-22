From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 21 Feb 2014 22:51:14 -0300
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140221175750.GB17611@obsidianresearch.com>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
 <20140219222103.GB17826@obsidianresearch.com>
 <20140221031927.GA2654@localhost>
 <20140221175750.GB17611@obsidianresearch.com>
Message-ID: <20140222015113.GA2438@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 10:57:50AM -0700, Jason Gunthorpe wrote:
> On Fri, Feb 21, 2014 at 12:19:28AM -0300, Ezequiel Garcia wrote:
> > > Thanks, I tested v3 of the patchset.
> > > 
> > > It boots, but I can't do very much because the watchdog driver doesn't
> > > build and my system is configured to watchdog timeout if there is no
> > > watchdog driver.
> > > 
> > > Presumably the watchdog patchset needs to be a dependency for this? Is
> > > there a git URL for it?
> > > 
> > 
> > Andrew's v3 and the mvebu/watchdog branch merges without any conflicts:
> > 
> > https://github.com/lunn/linux/tree/v3.14-rc1-mvebu-v3
> > 
> > http://git.infradead.org/linux-mvebu.git/shortlog/refs/heads/mvebu/watchdog
> > 
> > And multi v5 works great here!
> 
> It is working now for me as well, I haven't noticed any strangeness at
> least..
> 
> Ezequiel, after I applied your watchdog branch the .dtsi files
> lacked the new 2nd register:
> 
>                 wdt: watchdog-timer at 20300 {
>                         compatible = "marvell,orion-wdt";
>                         reg = <0x20300 0x28>;
>                         interrupt-parent = <&bridge_intc>;
>                         interrupts = <3>;
>                         clocks = <&gate_clk 7>;
>                         status = "okay";
>                 };
> 
> Which creates a nasty warn-on during boot - is that expected?
>

Yup, that's expected. It avoids any backwards compatibility issues.
The watchdog patchset has been pulled by Jason Cooper in two branches;
if my memory doesn't fail me, they are: mvebu/watchdog and mvebu/dt.

However, the mvebu/dt branch seemed to conflict with Andrew's multi-v5
work, so I haven't advised you to merge it as well. And since the watchdog
can work with the old DT, it's not a big issue.

Just remember to update your DTB.

> BTW, for both patche sets:
> Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (on kirkwood)
> 

Thanks! The watchdog work is already merged, but maybe Jason Cooper can take
care of adding your tested-by.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
