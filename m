From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 16 Feb 2016 15:37:02 +0100
Subject: [PATCH] spi/rockchip: Add dt-binding for Rockchip rk3399 spi
In-Reply-To: <20160216132223.GM18327@sirena.org.uk>
References: <1455614538-4415-1-git-send-email-jay.xu@rock-chips.com>
 <20160216132223.GM18327@sirena.org.uk>
Message-ID: <1730751.NYv1NxJVuB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Februar 2016, 13:22:23 schrieb Mark Brown:
> On Tue, Feb 16, 2016 at 05:22:18PM +0800, jianqun.xu wrote:
> >  Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I'd expect this to be added to both the driver and the binding document
> not just the document.

It seems the driver can still use the rk3066-variant - aka nobody has found 
specific issues in the rk3399 IP implementation.

Having the more specific IP names already in the dts before actually using 
them was suggested by devicetree people to not have to exchange everything 
once specific issues were found. 

So right now it's using the fallback-mechanism of binding to the rk3066 
name, but if some obstacle appears it will only take adding the binding in 
the driver to make it work (even with old devicetrees).
