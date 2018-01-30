From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jan 2018 13:53:20 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add registers clock
 for SPI nodes
In-Reply-To: <87bmhb1pry.fsf@free-electrons.com>
References: <20180130111455.10101-1-gregory.clement@free-electrons.com>
 <20180130112138.4xopqhgllnbq4xhb@sapphire.tkos.co.il>
 <20180130122640.wx2r3mnqusz362ju@sapphire.tkos.co.il>
 <87bmhb1pry.fsf@free-electrons.com>
Message-ID: <20180130135320.39899ef5@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Jan 2018 13:42:41 +0100, Gregory CLEMENT wrote:

> > On Tue, Jan 30, 2018 at 01:21:38PM +0200, Baruch Siach wrote:  
> >> On Tue, Jan 30, 2018 at 12:14:55PM +0100, Gregory CLEMENT wrote:  
> >> > This extra clock is needed to access the registers of the SPI controller
> >> > used on Armada 7K/8K SoCs.  
> >> 
> >> Don't we need this also for I2C and UART?  
> >
> > So you posted a patch for I2C as well.
> >
> > Looking at the cp110-system-controller.c driver (cp110_syscon_common_probe()), 
> > I see that clock gate #17 (CP110_GATE_MAIN) is automatically enabled when #21 
> > (CP110_GATE_SLOW_IO) is enabled. So this additional clock specifier should not 
> > be needed.  
> 
> Actually this is the reason of these changes. The clock driver is wrong,
> now that we got new documentation about the clocks, we saw that the
> clock tree descried in this driver was not correct. There is no relation
> between clock 17 and clock 21 for instance. But in order to be able to
> fix the clock driver, first we have to make sure that all the driver of
> the peripherals really select their own clocks.
> 
> I have already the patch fixing the clock ready and once I will have
> converted the remaining peripheral I will be able to submit it.

Of course I do agree with Gr?gory here, since we discussed this at
length. However, I think Baruch has a point in that this should be
explained in the commit log.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
