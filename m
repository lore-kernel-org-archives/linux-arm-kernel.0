From: tpiepho@impinj.com (Trent Piepho)
Date: Wed, 18 Oct 2017 17:50:30 +0000
Subject: [PATCH 4/4] ARM: imx: Update spi_imx platform data to reflect
 current state
In-Reply-To: <20171018021709.GD18810@dragon>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-4-tpiepho@impinj.com> <20171018021709.GD18810@dragon>
Message-ID: <1508349029.87493.8.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-18 at 10:17 +0800, Shawn Guo wrote:
> On Fri, Oct 13, 2017 at 12:54:10PM -0700, Trent Piepho wrote:
> > 
> > If a board uses all native chip selects, then it's not necessary to
> > specify a chip select array at all, as all native is the default (this is
> > how device-tree configured SPI masters work too).  Most of the spi-imx
> > platform data users have their chip select arrays removed by this patch.
> > 
> > 
> Does this patch have any dependency on others in this series, or can it
> be sent via arm-soc tree independently?

It needs patch 1 and 3 in the series.  Currently supplying cs gpios is
mandatory for both platform data and DT based systems using spi-imx. 
The latter is a bug, as the DT binding clearly makes cs-gpios optional
and other drivers do not require it.  I figured I might as well clean
up the platform data while I fixed that bug and came across the
imx31moboard bug in that process.
