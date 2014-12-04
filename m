From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 09:05:38 -0600
Subject: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux data
In-Reply-To: <20141204144325.GA17269@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-3-git-send-email-balbi@ti.com>
 <543E6774.8000406@ti.com> <20141204144325.GA17269@saruman>
Message-ID: <20141204150538.GE18045@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 08:43:25AM -0600, Felipe Balbi wrote:
> HI,
> 
> On Wed, Oct 15, 2014 at 03:24:20PM +0300, Tomi Valkeinen wrote:
> > On 14/10/14 21:28, Felipe Balbi wrote:
> > > Caused by a copy & paste error. Note that even with
> > > this bug AM437x SK display still works because GPIO
> > > mux mode is always enabled. It's still wrong to mux
> > > somebody else's pin.
> > > 
> > > Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
> > > isn't used for anything.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> > > index 859ff3d..681be00 100644
> > > --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> > > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > > @@ -320,8 +320,7 @@
> > >  
> > >  	lcd_pins: lcd_pins {
> > >  		pinctrl-single,pins = <
> > > -			/* GPIO 5_8 to select LCD / HDMI */
> > > -			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
> > > +			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
> > >  		>;
> > >  	};
> > >  };
> > 
> > I didn't verify the offset, but based on the comments this looks fine to me.
> > 
> > Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tony, are you taking this patch ? Looks like it has been forgotten and
> now it needs to be backported to v3.17 and v3.18 (assuming it's too late
> for v3.18).

I'll send a new version and Cc stable.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/65c5030a/attachment-0001.sig>
