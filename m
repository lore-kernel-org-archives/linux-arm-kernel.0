From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 22:10:30 +0200
Subject: [PATCHv3 1/6] net: Add EMAC ethernet driver found on Allwinner
 A10 SoC's
In-Reply-To: <519F6128.9060608@elopez.com.ar>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369387394-9453-2-git-send-email-maxime.ripard@free-electrons.com>
 <519F6128.9060608@elopez.com.ar>
Message-ID: <20130524201030.GA17847@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, May 24, 2013 at 09:46:32AM -0300, Emilio L?pez wrote:
> El 24/05/13 06:23, Maxime Ripard escribi?:
> > From: Stefan Roese <sr@denx.de>
> > 
> > The Allwinner A10 has an ethernet controller that seem to be developped
> > internally by them.
> > 
> > The exact feature set of this controller is unknown, since there is no
> > public documentation for this IP, and this driver is mostly the one
> > published by Allwinner that has been heavily cleaned up.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> 
> (snip)
> 
> > +
> > +config SUN4I_EMAC
> > +        tristate "Allwinner A10 EMAC support"
> > +	depends on ARCH_SUNXI
> > +	depends on OF
> > +	select CRC32
> > +	select NET_CORE
> > +	select MII
> > +	select REGULATOR_FIXED_VOLTAGE
> > +        ---help---
> > +          Support for Allwinner A10 EMAC ethernet driver.
> > +
> > +          To compile this driver as a module, choose M here.  The module
> > +          will be called sun4i-emac.
> > +
> 
> You also need to select REGULATOR when you select REGULATOR_FIXED_VOLTAGE

Actually, this should be in patch 2/6.

Thanks for noticing!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
