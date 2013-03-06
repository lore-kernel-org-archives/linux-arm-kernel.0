From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Mar 2013 13:10:34 +0800
Subject: [PATCH v2 01/12] ARM: dts: add generic DMA device tree binding
 for mxs-dma
In-Reply-To: <201303051938.29660.arnd@arndb.de>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
 <1362486244-24593-2-git-send-email-shawn.guo@linaro.org>
 <201303051938.29660.arnd@arndb.de>
Message-ID: <20130306051032.GA1828@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 07:38:29PM +0000, Arnd Bergmann wrote:
> On Tuesday 05 March 2013, Shawn Guo wrote:
> >                                  <&clks 150>, <&clks 149>;
> >                         clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
> >                                       "gpmi_bch_apb", "per1_bch";
> > +                       dmas = <&dma_apbh 0>;
> > +                       dma-names = "gpmi";
> >                         fsl,gpmi-dma-channel = <0>;
> >                         status = "disabled";
> 
> Looks like a small bug:
> 
> In patch "[PATCH v2 07/12] mtd: gpmi: move to use generic DMA helper" you require the
> dma-names property for this device to be "rx-tx", not "gpmi".
> 
Dammit.  I missed this one.  Thanks for spotting it.  Fixed.

Shawn
