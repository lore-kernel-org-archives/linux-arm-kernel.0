From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jan 2018 14:04:39 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add registers clock
 for SPI nodes
In-Reply-To: <87372n1otf.fsf@free-electrons.com>
References: <20180130111455.10101-1-gregory.clement@free-electrons.com>
 <20180130112138.4xopqhgllnbq4xhb@sapphire.tkos.co.il>
 <20180130122640.wx2r3mnqusz362ju@sapphire.tkos.co.il>
 <87bmhb1pry.fsf@free-electrons.com>
 <20180130135320.39899ef5@windsurf.lan>
 <87372n1otf.fsf@free-electrons.com>
Message-ID: <20180130140439.1abb59e6@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 Jan 2018 14:03:24 +0100, Gregory CLEMENT wrote:

> >> Actually this is the reason of these changes. The clock driver is wrong,
> >> now that we got new documentation about the clocks, we saw that the
> >> clock tree descried in this driver was not correct. There is no relation
> >> between clock 17 and clock 21 for instance. But in order to be able to
> >> fix the clock driver, first we have to make sure that all the driver of
> >> the peripherals really select their own clocks.
> >> 
> >> I have already the patch fixing the clock ready and once I will have
> >> converted the remaining peripheral I will be able to submit it.  
> >
> > Of course I do agree with Gr?gory here, since we discussed this at
> > length. However, I think Baruch has a point in that this should be
> > explained in the commit log.  
> 
> It was explained in the series modifying the drivers. But here it is
> only about correctly describing the hardware ressource in the device
> tree, the fact that the linux clock driver may or not automatically
> select some of the clock should not be taking into account.

Agreed, but there is no reference to the driver commits in your commit
log, and I still think a better commit log would be nice. The simple
fact that Baruch had to ask is a good indication that the commit log is
not detailed enough, IMO.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
