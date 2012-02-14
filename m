From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 14 Feb 2012 11:33:18 +0100
Subject: How to deal with a PHY configuration related to the board?
In-Reply-To: <20120214094339.GA4338@sapphire.tkos.co.il>
References: <20120214092606.GE4723@ldesroches-Latitude-E6320>
 <20120214094339.GA4338@sapphire.tkos.co.il>
Message-ID: <20120214103318.GF4723@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, Feb 14, 2012 at 11:43:39AM +0200, Baruch Siach wrote:
> Hi Ludovic,
> 
> On Tue, Feb 14, 2012 at 10:26:06AM +0100, Ludovic Desroches wrote:
> > I am using a Micrel KSZ9021RN PHY and I would like to configure some 
> > registers
> > as 'RGMII Clock and Control Pad Skew' and 'RGMII RX Data Pad Skew'.
> > So the values of these registers are board dependant and I wondering what is
> > the proper way to set them.
> > It seems there is no platform data usable for this case. Having a quick look
> > to other PHYs, the situation seems the same.
> > 
> > Can you give me some clues about how to do this? Did I miss anything which
> > allow to do this?
> 
> See ksz9021rn_phy_fixup() in arch/arm/mach-imx/mach-imx6q.c.
> 

Thanks for your help.

So the solution is to use phy_register_fixup function.

Regards

Ludovic
