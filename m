From: dinguyen@altera.com (Dinh.Nguyen)
Date: Wed, 18 Jul 2012 12:53:31 -0600
Subject: [PATCH v4] arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
In-Reply-To: <201207181242.44326.arnd@arndb.de>
References: <20120718102507.GA11993@elf.ucw.cz>
 <201207181242.44326.arnd@arndb.de>
Message-ID: <1342637611.13680.2.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-18 at 12:42 +0000, Arnd Bergmann wrote:
> On Wednesday 18 July 2012, Pavel Machek wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Adding core definitions for Altera's SOCFPGA ARM platform.
> >   
> 
> There are two small details I noticed. You can either send
> a replacement patch or fixups on top of this one.
> 
> > +		gmac0: stmmac at ff700000 {
> > +			compatible = "st,spear600-gmac";
> > +			reg = <0xff700000 0x2000>;
> > +			interrupts = <0 115 4>;
> > +			interrupt-names = "macirq";
> > +			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> > +			phy-mode = "gmii";
> > +		};
> 
> We've just discussed the stmmac driver in the spear1340 update
> series. My understanding is that there are multiple variants of this
> that we may need to distintinguish. I think it's better if you
> make the compatible string something that does not reference the
> spear600 specific variant, unless you are certain that it is in fact
> completely identical to that one.
> 
> Ideally you would have the version of the stmmac macro encoded
> in there, in addition to a name identifying altera as the company
> who added this one, ordered from most specific to least specific.
> 
> For instance, this could be
> 
> 	compatible = "altr,socfpga-stmmac", "st,stmmac-v12.3.45", "st,stmmac";
> 
> Looking at the driver, it seems that this should actually not be called
> stmmac in the devicetree but rather dwmac, so better make it
> 
> 	compatible = "altr,socfpga-stmmac", "snps,dwmac-4.567", "snps,dwmac";
> 

Is there already work to update the bindings to reflect this change in
stmmac driver? Or could I help with setting up some patches for it?

Dinh
