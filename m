From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Feb 2018 14:35:16 +0100
Subject: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
In-Reply-To: <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
 <20180202105304.gow2znzgxqmuxgol@flea.lan>
 <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
Message-ID: <20180202133516.uoy7ppuozd6cnldm@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 11:57:20AM +0100, Giulio Benetti wrote:
> Il 02/02/2018 11:53, Maxime Ripard ha scritto:
> > Hi,
> > 
> > On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
> > > > > > What kernel version did you use?
> > > > > 
> > > > > Latest mainline.
> > > > 
> > > > I guess this patch could fix it:
> > > > http://code.bulix.org/1kitrq-268936?raw
> > > 
> > > This should prevent from modifying parent clock. But my problem was
> > > different.
> > > 
> > > On A20, gpu_clk can have different PLL, not I've found out the way
> > > to choose right one with assigned-parent-clocks.
> > > 
> > > I have patchset ready for adding A20 mali node, but I need some more
> > > time to complete with OPP, then I will submit entire patchset.
> > > 
> > > Now it works correctly, using right pll(dedicated PLL8), setting
> > > right frequency.
> > 
> > The point is that we really don't care about which PLL is actually
> > being used, as long as the rate is correct and we don't break anything
> > else. If the GPU rate is accessible through one of the other PLL, it
> > makes even more sense to not use the GPU PLL and keep it disabled,
> > since it will result in some power savings.
> 
> Ah! I see the point now, very clever system for power saving.
> I'm going to check if it's resolutive,
> but it sounds good.
> 
> > 
> > > Btw, do I need to add a board using it, or can I add only Mali node
> > > to sun7i-a20.dtsi(plus other little patches)?
> > 
> > You can add it to the DTSI without a board using it (and actually,
> > nothing should be in the board DTS, everything in the DT for the Mali
> > applies to all boards).
> 
> Sure. So I would also add the patch you've addressed me:
> http://code.bulix.org/1kitrq-268936?raw
> as a commit. Can I submit it in patchset to complete the whole job?

I already sent that patch quite some time ago, I'll just apply it. You
can send the DT patch :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180202/08fa128c/attachment.sig>
