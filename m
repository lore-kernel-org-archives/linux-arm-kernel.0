From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 18:12:17 +0100
Subject: [PATCH 2/5 v2] ARM: AT91SAM9G45: same platform data structure
 for all crypto peripherals
In-Reply-To: <20121107175946.01f9dc78@eb-e6520>
References: <20121107152615.GD4576@game.jcrosoft.org>
 <1352305675-21961-1-git-send-email-nicolas@eukrea.com>
 <20121107164523.GG4576@game.jcrosoft.org>
 <20121107175946.01f9dc78@eb-e6520>
Message-ID: <20121107171217.GH4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:59 Wed 07 Nov     , Eric B?nard wrote:
> Hi Jean-Christophe,
> 
> Le Wed, 7 Nov 2012 17:45:23 +0100,
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> > > @@ -1900,7 +1900,7 @@ static void __init at91_add_device_tdes(void) {}
> > >   * -------------------------------------------------------------------- */
> > >  
> > >  #if defined(CONFIG_CRYPTO_DEV_ATMEL_AES) || defined(CONFIG_CRYPTO_DEV_ATMEL_AES_MODULE)
> > > -static struct aes_platform_data aes_data;
> > > +static struct crypto_platform_data aes_data;
> > >  static u64 aes_dmamask = DMA_BIT_MASK(32);
> > >  
> > >  static struct resource aes_resources[] = {
> > > @@ -1931,9 +1931,11 @@ static struct platform_device at91sam9g45_aes_device = {
> > >  static void __init at91_add_device_aes(void)
> > >  {
> > >  	struct at_dma_slave	*atslave;
> > > -	struct aes_dma_data	*alt_atslave;
> > > +	struct crypto_dma_data	*alt_atslave;
> > >  
> > > -	alt_atslave = kzalloc(sizeof(struct aes_dma_data), GFP_KERNEL);
> > > +	alt_atslave = kzalloc(sizeof(struct crypto_dma_data), GFP_KERNEL);
> > I still not understand why we need to allocate it
> > 
> > just declare it as static
> > 
> last time we had some data static and you asked to alloc them (and
> didn't bother to answer why you required that :
> http://lkml.indiana.edu/hypermail/linux/kernel/1207.0/02779.html ), now
> you ask to declare static something which is allocated (and
> that's already done this way for the mci) : may you please explain why
> so that we get it the right way for next time ?

in the driver yes we write multi instance and generic code but in the platfrom I do not see why

Best Regards,
J.
