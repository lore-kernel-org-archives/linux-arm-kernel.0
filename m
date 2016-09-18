From: sam.van.den.berge@telenet.be (Sam Van Den Berge)
Date: Sun, 18 Sep 2016 20:18:19 +0200
Subject: [PATCH v2] dmaengine: s3c24xx: Add dma_slave_map for s3c2440
 devices
In-Reply-To: <b8d6e8a9-4807-0dc0-95c8-a4aca89f18e7@samsung.com>
References: <CGME20160915194202eucas1p2fa3c4d1c9713e3713f956e1b114e1525@eucas1p2.samsung.com>
 <1473968506-4150-1-git-send-email-sam.van.den.berge@telenet.be>
 <b8d6e8a9-4807-0dc0-95c8-a4aca89f18e7@samsung.com>
Message-ID: <20160918181819.GA28721@sam-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 01:00:12PM +0200, Sylwester Nawrocki wrote:
> On 09/15/2016 09:41 PM, Sam Van Den Berge wrote:
> > @@ -445,10 +446,44 @@ static struct s3c24xx_dma_channel s3c2440_dma_channels[DMACH_MAX] = {
> >  	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 3), },
> >  };
> >  
> > +static const struct dma_slave_map s3c2440_dma_slave_map[] = {
> > +	/* TODO: DMACH_XD0 */
> > +	/* TODO: DMACH_XD1 */
> > +	{ "3c2440-sdi", "rx-tx", (void *)DMACH_SDI },
> 
> Thanks for the patch, still device name needs to be changed here
> to "s3c2440-sdi".

Thanks for spotting this! I guess I was too focused on the "rx-tx" part
that I totally missed the missing leading "s". I will fix this in v3.

Sam.
