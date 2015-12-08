From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Dec 2015 09:32:24 +0100
Subject: [PATCH v5 3/4] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151208090658.e471fcde7fd5e79c69706115@free.fr>
References: <1449264283-25360-1-git-send-email-jenskuske@gmail.com>
 <1449264283-25360-4-git-send-email-jenskuske@gmail.com>
 <20151207091257.070723b67db726d9f05c6550@free.fr>
 <5665D38E.4050406@gmail.com>
 <20151208090658.e471fcde7fd5e79c69706115@free.fr>
Message-ID: <20151208083224.GN27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 09:06:58AM +0100, Jean-Francois Moine wrote:
> On Mon, 7 Dec 2015 19:44:30 +0100
> Jens Kuske <jenskuske@gmail.com> wrote:
> 
> > >> +					     "bus_lcd0", "bus_lcd1", "bus_deint",
> > 
> > > 	"bus_tcon0", "bus_tcon1", "bus_deint",
> > > 
> > > (the tcon1 clock is used by both lcd0 and lcd1, while
> > >  the tcon0 clock is used for TV output from lcd1)
> > 
> > Hi,
> > 
> > These are only the ahb bus gates, not the module clocks.
> > Naming them lcd might be a bit confusing, but it follows the naming we
> > used since sun4i. And the tcon modules are still called lcd0 and lcd1
> > module in the manual too.
> 
> There is no reference to TCON0 in the LCDs registers (H3 V1.1 pages 428
> and 435), only TCON1.
> 
> > Interestingly there is only a tcon0 module clock in the manual and no
> > tcon1, but that is not part of this patch.
> 
> Well, I looked again in the 3.4 kernel and, for the LCD0/HDMI, there is
> no clock setting for TCON1: it just receives the AHB1 clock.
> 
> This means that its gate ("bus_lcd1" or "ahb1_tcon1") must be enabled
> when streaming on LCD0 or LCD1.
> 
> The role of tcon0 is not yet clear to me, but it seems that its clock
> is the streaming clock for LCD1/TV, as the HDMI clock is for LCD0/HDMI.

If the H3 display block is done the same way than the A10 (and later)
one on this aspect, then the TCON has two channels with two different
streaming (or functional, you pick the name) clocks. The channel 0 is
usually used for RGB, the channel 1 for HDMI, composite and VGA.

Maybe they just added different bus gates for those two different
channels, and moved HDMI to the channel 0.

Anyway, that can always be changed later on if we have more clue on
what's going on.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/4c688f3d/attachment.sig>
