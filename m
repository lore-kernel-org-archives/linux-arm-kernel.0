From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 16:54:06 -0700
Subject: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
In-Reply-To: <517F5126.5000509@ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com>
Message-ID: <20130508235404.GX32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [130429 22:11]:
> 
> On 4/29/2013 1:25 PM, Gupta, Pekon wrote:
> > From: avinash philip <avinashphilip@ti.com>
> > 
> > NAND flash connected in am335x-evm on GPMC controller. This patch adds
> > device tree node in am3355-evm with GPMC contoller timing for NAND flash
> > interface, NAND partition table, ECC scheme, elm handle id.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > Tested-by: Pekon Gupta <pekon@ti.com>
> > 
> > ---
> > arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index 0423298..1c2fd89 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -26,7 +26,8 @@
> >  
> >  	am33xx_pinmux: pinmux at 44e10800 {
> >  		pinctrl-names = "default";
> > -		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
> > +		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
> > +			&nandflash_pins_s0>;
> 
> Why add this to the board level fallback (called pinctrl hogs, I think)?
> This can be part of nand node you added below so that the pinctrl will
> take effect when nand gets probed instead of all the time.

Yes we should have all the pinctrl entries under the related drivers.
This makes it easy remux pins during runtime if needed, and also
allows unloading pinctrl-single.ko for development.

Regards,

Tony
