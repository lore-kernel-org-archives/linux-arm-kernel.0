From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 5 Nov 2016 23:08:48 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105210441.GB1216@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <20161105210441.GB1216@lunn.ch>
Message-ID: <20161105220848.k6rrjmvvhdaeduma@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 10:04:41PM +0100, Andrew Lunn wrote:
> > +&mdio {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mdio_pins>;
> > +	status = "okay";
> > +
> > +	phy1: phy at 1 {
> > +		status = "okay";
> > +		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
> > +		reg = <1>;
> > +	};
> 
> phy.txt says:
> 
> - compatible: Compatible list, may contain
>   "ethernet-phy-ieee802.3-c22" or "ethernet-phy-ieee802.3-c45" for
>   PHYs that implement IEEE802.3 clause 22 or IEEE802.3 clause 45
>   specifications. If neither of these are specified, the default is to
>   assume clause 22.
> 
>   If the phy's identifier is known then the list may contain an entry
>   of the form: "ethernet-phy-idAAAA.BBBB" where
>      AAAA - The value of the 16 bit Phy Identifier 1 register as
>             4 hex digits. This is the chip vendor OUI bits 3:18
>      BBBB - The value of the 16 bit Phy Identifier 2 register as
>             4 hex digits. This is the chip vendor OUI bits 19:24,
>             followed by 10 bits of a vendor specific ID.
> 
>   The compatible list should not contain other values than those
>   listed here.
> 
> Please don't list the "marvell,*" names.

Will do for v2. arch/arm/boot/dts/keystone-* needs fixing in this
regard, too.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161105/813ef036/attachment.sig>
