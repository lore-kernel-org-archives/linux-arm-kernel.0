From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 7 Nov 2012 16:50:26 +0100
Subject: [PATCH 2/5] ARM: AT91SAM9G45: same platform data structure for
 all crypto peripherals
In-Reply-To: <20121107152615.GD4576@game.jcrosoft.org>
References: <1352219544-30416-1-git-send-email-nicolas@eukrea.com>
 <20121107152615.GD4576@game.jcrosoft.org>
Message-ID: <20121107165026.4e64422f@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

Le Wed, 7 Nov 2012 16:26:15 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> > @@ -1931,9 +1931,9 @@ static struct platform_device at91sam9g45_aes_device = {
> >  static void __init at91_add_device_aes(void)
> >  {
> >  	struct at_dma_slave	*atslave;
> > -	struct aes_dma_data	*alt_atslave;
> > +	struct crypto_dma_data	*alt_atslave;
> >  
> > -	alt_atslave = kzalloc(sizeof(struct aes_dma_data), GFP_KERNEL);
> > +	alt_atslave = kzalloc(sizeof(struct crypto_dma_data), GFP_KERNEL);
> we do not check the result of kzalloc ouch
> 
> and why we allocate it?
> 
for both remarks : that's the way it's done in at91_add_device_mci since
75305d768d296a07fd02df9af3e5de326df1c72e
A v2 will follow (and also a fix for at91_add_device_mci).

Eric
