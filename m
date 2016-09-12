From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2016 15:33:22 +0100
Subject: [PATCH] ARM: dma-mapping: add in missing white space in error
 message text
In-Reply-To: <db1758f8-0335-6661-e797-b2021682a087@arm.com>
References: <20160912125212.32739-1-colin.king@canonical.com>
 <db1758f8-0335-6661-e797-b2021682a087@arm.com>
Message-ID: <20160912143322.GW1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 02:06:09PM +0100, Robin Murphy wrote:
> On 12/09/16 13:52, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > A dev_warn message spans two lines and the literal string is missing
> > a white space between words. Add the white space.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  arch/arm/common/dmabounce.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> > index 3012816..f47767b 100644
> > --- a/arch/arm/common/dmabounce.c
> > +++ b/arch/arm/common/dmabounce.c
> > @@ -547,7 +547,7 @@ void dmabounce_unregister_dev(struct device *dev)
> >  
> >  	if (!device_info) {
> >  		dev_warn(dev,
> > -			 "Never registered with dmabounce but attempting"
> > +			 "Never registered with dmabounce but attempting "
> >  			 "to unregister!\n");
> 
> Per Documentation/CodingStyle, better to put the whole thing onto one
> line so that, say, "git grep 'attempting to unregister'" doesn't leave
> one scratching ones head in confusion.
> 
> Of course, even better would be to get rid of the whole thing and
> convert ARM to use SWIOTLB, but hey, one thing at a time ;)

I doubt that can happen - dmabounce does a little more than swiotlb
because it copes with DMA masks that are _not_ a number of zeros
followed by one bits.  It was written to support things like SA1111
DMA, where the device has a bug in that it can't drive certain
SDRAM address bits correctly.

It also gets used for ITE8512 PCI controllers and IXP4xx platforms,
although these should probably be converted to SWIOTLB.  However,
without having test systems, I'd recommend leaving them as-is.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
