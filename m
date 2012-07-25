From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 19:04:59 +0000
Subject: [PATCH 6/7] ARM: pxa3xx: add generic DT machine code
In-Reply-To: <501035EB.6030406@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <201207251734.50946.arnd@arndb.de> <501035EB.6030406@gmail.com>
Message-ID: <201207251904.59571.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Daniel Mack wrote:
> On 25.07.2012 19:34, Arnd Bergmann wrote:
> > On Wednesday 25 July 2012, Daniel Mack wrote:
> >> Add a DT_MACHINE_START entry for PXA3xx machines and a auxdata table for
> >> some of the devices. This file can be extended to also support pxa2xx
> >> boards.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >> ---
> >>  arch/arm/mach-pxa/Kconfig  |   12 +++++++++
> >>  arch/arm/mach-pxa/Makefile |    3 +++
> >>  arch/arm/mach-pxa/pxa-dt.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 76 insertions(+)
> > 
> > The code looks good, but I wonder if it would be better to add it to the pxa3xx.c
> > file instead. One more comment:
> 
> Well, I though having tham separated from the generic code will make
> things cleaner and also save us one #ifdef.

For new platforms that are DT-only we usually keep everything in one file,
but you're right that it makes some sense to have it separate while most
people use non-DT board files.

> >> +static const char *pxa3xx_dt_board_compat[] __initdata = {
> >> +       "mrvl,pxa3xx",
> >> +};
> > 
> > We should try to avoid wildcards in compatible properties but rather be
> > more specific. I would use separate values for pxa300/310/320/920/930/935
> > that you could all list here if they have the same auxdata lookup table.
> 
> Ok, makes sense. I'm not sure about 920/930/935, so I'll leave them out
> for now. Whoever successfully tests these can easly add that lines.

Sounds good.

	Arnd
