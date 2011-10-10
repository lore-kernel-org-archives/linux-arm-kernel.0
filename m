From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 10 Oct 2011 11:54:26 +0200
Subject: [RFC][PATCH] plat-mxc: iomux-v3.h: implicitly enable
	pull-up/down when that's desired
In-Reply-To: <20111010081407.GA32718@sapphire.tkos.co.il>
References: <201110100758.p9A7wCYT011235@home.pavel.comp>
	<20111010081407.GA32718@sapphire.tkos.co.il>
Message-ID: <20114.49362.842057.846334@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Baruch Siach writes:
> Hi Paul,
> 
> On Mon, Oct 10, 2011 at 11:19:23AM +0400, Paul Fertser wrote:
> > To configure pads during the initialisation a set of special constants
> > is used, e.g.
> > #define MX25_PAD_FEC_MDIO__FEC_MDIO IOMUX_PAD(0x3c4, 0x1cc, 0x10, 0, 0, PAD_CTL_HYS | PAD_CTL_PUS_22K_UP)
> > 
> > The problem is that no pull-up/down is getting activated unless both
> > PAD_CTL_PUE (pull-up enable) and PAD_CTL_PKE (pull/keeper module
> > enable) set. This is clearly stated in the i.MX25 datasheet and is
> > confirmed by the measurements on hardware. This leads to some rather
> > hard to understand bugs such as misdetecting an absent ethernet PHY (a
> > real bug i had), unstable data transfer etc. This might affect mx25,
> > mx35, mx50, mx51 and mx53 SoCs.
> > 
> > It's reasonable to expect that if the pullup value is specified, the
> > intention was to have it actually active, so we implicitly add the
> > needed bits.
> 
> IMO, this patch should include the removal of the now redundant PAD_CTL_PKE 
> from arch/arm/plat-mxc/include/mach/iomux-mx25.h, and other v3 iomux headers.
> 
Why should PAD_CTL_PKE be redundant? You still need it to configure a
pin for the 'Keeper' functionality.
Even if there is no default pin configuration that uses this, it
should be possible to enable it when desired.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
