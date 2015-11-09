From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 18:12:02 +0100
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <20151109170834.GE8644@n2100.arm.linux.org.uk>
References: <4225885.EYXTHjRPmX@wuerfel> <6910088.dNmooXDTJR@wuerfel>
 <20151109170834.GE8644@n2100.arm.linux.org.uk>
Message-ID: <4827390.CWKT8ytt79@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 17:08:34 Russell King - ARM Linux wrote:
> They are "optional" because when you're using a DSA switch, you don't
> specify a PHY (because, there isn't one).  For example, this is what
> I'm using with an Armada 388 board with a Marvell DSA switch.  The
> DSA does not appear as a PHY, and no node in the DSA stanza can be
> referenced for a phy entry in the ethernet device's stanza.
> 
>                         eth1: ethernet at 30000 {
>                                 compatible = "marvell,armada-370-neta";
>                                 reg = <0x30000 0x4000>;
>                                 interrupts-extended = <&mpic 10>;
>                                 clocks = <&gateclk 3>;
>                                 managed = "in-band-status";
>                                 phy-mode = "sgmii";
>                                 status = "okay";
>                         };
> 
> 

Ok, then it would be nice to change the binding to reflect that,
and also document the "managed" property there.

	Arnd
