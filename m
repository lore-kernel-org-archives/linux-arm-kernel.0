From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 03 Oct 2018 17:22:55 +0200
Subject: [PATCH] arm64: dts: clearfog-gt-8k: add PCIe slot description
In-Reply-To: <20181003134345.id34eoianoeeodvs@sapphire.tkos.co.il> (Baruch
 Siach's message of "Wed, 3 Oct 2018 16:43:45 +0300")
References: <ac8d233a624411272616d19f070cea756f625235.1538572981.git.baruch@tkos.co.il>
 <20181003133110.GD427@lunn.ch>
 <20181003134345.id34eoianoeeodvs@sapphire.tkos.co.il>
Message-ID: <87bm8bm4vk.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On mer., oct. 03 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Andrew,
>
> On Wed, Oct 03, 2018 at 03:31:10PM +0200, Andrew Lunn wrote:
>> On Wed, Oct 03, 2018 at 04:23:01PM +0300, Baruch Siach wrote:
>> > This adds support for the PCIe interface on the CON4 mini-PCIe
>> > connector.
>> 
>> Is there a dependency between this and the implementation of the
>> reset-gpios? It would be good to at least mention if there is/is not
>> such a dependency. You could put it under the ---.
>
> There is no hard dependency between the patches. This patch is about hardware 
> description which is correct regardless of software implementation. For the 
> hardware to work you need to toggle the reset signal. But you can also do that 
> in the bootloader if the kernel does not support reset-gpios.
>
> baruch
>
>> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied on mvebu/dt64

Thanks,

Gregory

>> > ---
>> >  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> > 
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
>> > index 2e06d82bec58..a13549749ee7 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
>> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
>> > @@ -233,6 +233,13 @@
>> >  	};
>> >  };
>> >  
>> > +&cp0_pcie0 {
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&cp0_pci0_reset_pins>;
>> > +	reset-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
>> > +	status = "okay";
>> > +};
>> > +
>> >  &cp0_gpio2 {
>> >  	sata_reset {
>> >  		gpio-hog;
>
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
