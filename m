From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2012 15:29:08 +0100
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <20120730084558.GE31509@S2101-09.ap.freescale.net>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <20120728133215.GG2128@S2101-09.ap.freescale.net>
 <5015624D.50305@googlemail.com>
 <20120730011426.GB30774@S2101-09.ap.freescale.net>
 <50162C7A.1060307@de.bosch.com>
 <20120730084558.GE31509@S2101-09.ap.freescale.net>
Message-ID: <20120730142908.GM6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:46:07PM +0800, Shawn Guo wrote:
> On Mon, Jul 30, 2012 at 08:40:58AM +0200, Dirk Behme wrote:
> > - Do you like to propose a better macro than SOC_IMX6Q to cover
> > imx3/imx6, too?
> > 
> No, I do not see the need of this.  CONFIG_ARCH_NR_GPIO is not the only
> way to overwrite the default number.  We can define ARCH_NR_GPIOS to
> the number we want in IMX platform headers.

Don't do that.  CONFIG_ARCH_NR_GPIO is there so that we can consolidate
out as much crap from mach/gpio.h as possible.  Either use it now, or I
will patch you to make you use it.  Either way, you will end up using
it... :)
