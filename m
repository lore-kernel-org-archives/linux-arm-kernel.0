From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Feb 2018 13:45:51 +0100
Subject: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
In-Reply-To: <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
Message-ID: <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 01:05:38PM +0100, Giulio Benetti wrote:
> Hi,
> 
> Il 31/01/2018 09:43, Maxime Ripard ha scritto:
> > Hi,
> > 
> > On Wed, Jan 31, 2018 at 12:23:59AM +0100, Giulio Benetti wrote:
> > > When mali.ko is inserted, it set default clocks and call all parent
> > > clocks to stay into range, causing pll-video0 to change and
> > > subsequently to change dclk to wrong frequencies.
> > 
> > This is what you should fix.
> 
> Ok, so it must be patch title(shrinked of course), right?
> 
> > 
> > > "gpu" clock has lot of parent plls inside driver, but on sun7i
> > > pll8-gpu does not depend on pll-video0, pll-ve, pll-video1.
> > > 
> > > It only depends on 24Mhz main clock.
> > 
> > I don't really know why you are mentionning that. The GPU clock has
> > all the parents described in the driver. And the parents' parents are
> > irrelevant to this particular issue.
> > 
> > > Remove all pll parents from gpu_parents_sun7i except "pll-gpu".
> > 
> > However, this is not a proper fix for your issue.
> 
> Yes, you're right, now I understand.
> 
> It is more complex than I thought.
> I need to dig more and study better A20 CCU.
> 
> So this patch can be dropped.
> 
> > 
> > What kernel version did you use?
> 
> Latest mainline.

I guess this patch could fix it:
http://code.bulix.org/1kitrq-268936?raw

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/09d92df4/attachment.sig>
