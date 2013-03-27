From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 27 Mar 2013 11:43:35 +0100
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303270929.45733.arnd@arndb.de>
 <CAHTX3d+9ST0X7x5hx5aLV2YMFUhPcmQg-VThX81vwk64WXj-eQ@mail.gmail.com>
 <201303271000.47614.arnd@arndb.de>
 <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
Message-ID: <20130327104335.GH16139@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 11:09:45AM +0100, Michal Simek wrote:
> 2013/3/27 Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 27 March 2013, Michal Simek wrote:
> >> FYI: I have looked at some code and I saw that Rob is using scu_base_addr
> >> in highbank. And then pointing to it in cpuidle-calxeda.c.
> >
> > Yes, the point is that it works as long as only one person uses that
> > identifier, so we should either not use it at all, or have a single
> > global definition shared by all ARM platforms.
> 
> yep.
> 
> >> Moving everything to one file is probably impossible.
> >>
> >> And in connection to symbols/functions/variables. It means that all
> >> specific soc functions in mach
> >> should also use specific prefix for everything.
> >
> > That is a good rule, although for static symbols it is not a bug
> > if they don't have a prefix.
> 
> ok. Let me check all my patches and Add there zynq_ prefix everywhere.
> 

While you're at, how about getting rid of the xilinx in the names and use
just zynq_* ?

I would also suggest s/xttc/ttc/g in your timer patch. It is up to you,
but I think the x doesn't make any sense anymore.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
