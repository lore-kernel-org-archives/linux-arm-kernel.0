From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 13 Feb 2015 19:04:46 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <20150213173121.GG26475@lunn.ch>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150213173121.GG26475@lunn.ch>
Message-ID: <20150213180446.GA4930@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Fri, Feb 13, 2015 at 06:31:21PM +0100, Andrew Lunn wrote:
> On Fri, Feb 13, 2015 at 05:42:54PM +0100, Antoine Tenart wrote:
> > 
> > Marvell Berlin SoCs have a chip control register set providing several
> > individual registers dealing with various controllers (pinctrl, reset,
> > clk). This chip controller is described by a single DT node since the
> > individual registers are spread among the chip control register bank.
> > 
> > Marvell Berlin also have a system control register set providing several
> > individual registers for pinctrl or adc.
> > 
> > A series was sent[1] to correctly handle these two nodes, by introducing
> > a Berlin mfd controller driver. The series converted the existing
> > pin-controller and reset drivers to take the changes into account.
> 
> Something which needs to be discussed for both this patchset and the
> previous one, is backwards compatibility of the device tree.
> 
> As far as i can see, these changes are not backwards compatible.
> Somebody trying to boot a new kernel with a old DT blob is going to
> have trouble.

Big trouble :)

> 
> How do we want to handle this?

Keeping a backward compatibility here would make Berlin drivers hard to
maintain, with lots of quirks. This rework is needed because since we
started to push things on Berlin we discovered how the chip and the
system controller are organized and working. It would have been
difficult to guess the perfect device tree organization at first, but
the current way we handle it is not acceptable on the long term.

The support is quite new and can be considered as in development and not
stable yet as far as I'm concerned. We just begin to have enough
functionalities supported. In this case backward compatibility would be
the same as having dead code in Berlin drivers.

IMHO, we do not want to handle this. But I'll let others, and Sebastian,
answer and I'm open to the discussion if needed.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
