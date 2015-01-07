From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jan 2015 10:27:24 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <54AC57FB.8000003@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
 <54AC57FB.8000003@free-electrons.com>
Message-ID: <20150107092724.GF7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 10:47:39PM +0100, Gregory CLEMENT wrote:
> > +				spi-flash at 0 {
> > +					#address-cells = <1>;
> > +					#size-cells = <1>;
> > +					compatible = "st,m25p128";
> > +					reg = <0>; /* Chip select 0 */
> > +					spi-max-frequency = <108000000>;
> 
> The SPI flahs used on the AP board is the same that the one used on the GP board:
> M25P128-VMF6P and the maximum frequency it can handle is 50MHz.

Actually, the one on the AP is a M25P128-VMF6PB, that has a max
frequency of 54MHz, but yeah, the frequency is wrong.

> > +
> > +			mdio at 72004 {
> > +				pinctrl-names = <&mdio_pins>;
> > +
> > +				phy0: ethernet-phy at 0 {
> Why don't you use the PHY address after the '@' ?
> Here I expected something like
> phy0: ethernet-phy at 1 {
> 
> > +					reg = <1>;
> > +				};
> > +
> > +				phy1: ethernet-phy at 1 {
> and here:
> phy0: ethernet-phy at 6 {
> > +					reg = <6>;
> > +				};
> > +
> > +				phy2: ethernet-phy at 2 {
> and here:
> phy0: ethernet-phy at 4 {

Indeed.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/cd05791e/attachment.sig>
