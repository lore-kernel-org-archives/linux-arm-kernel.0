From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 24 Nov 2014 11:33:57 -0800
Subject: [PATCH] drivers:block Remove unneeded Fix me message in xsyace.c
In-Reply-To: <fd1c5863660447cfb2b959e80d42c27c@BN1AFFO11FD018.protection.gbl>
References: <1416857108-2618-1-git-send-email-xerofoify@gmail.com>
 <fd1c5863660447cfb2b959e80d42c27c@BN1AFFO11FD018.protection.gbl>
Message-ID: <08ea34761ecd4d5a8bc814d1d42c9b61@BN1AFFO11FD048.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-11-24 at 08:31PM +0100, Michal Simek wrote:
> On 11/24/2014 08:25 PM, Nicholas Krause wrote:
> > Removes unneeded FIXME message related to using a hard coded value for ACE_BUS_WIDTH
> > due to it needing to be 8 bits, this is wrong as this function here needs all 16 bits
> > of the bus width and not just the lower or higher 16 depending on the machine's bit
> > order.
> > 
> > Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> > ---
> >  drivers/block/xsysace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> > index c4328d9..1b807ed 100644
> > --- a/drivers/block/xsysace.c
> > +++ b/drivers/block/xsysace.c
> > @@ -1152,7 +1152,7 @@ static void ace_free(struct device *dev)
> >  static int ace_probe(struct platform_device *dev)
> >  {
> >  	resource_size_t physaddr = 0;
> > -	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
> > +	int bus_width = ACE_BUS_WIDTH_16;
> >  	u32 id = dev->id;
> >  	int irq = 0;
> >  	int i;
> > 
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>

I find the commit message rather misleading, but the change is OK.

	S?ren
