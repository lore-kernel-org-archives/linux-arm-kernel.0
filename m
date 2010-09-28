From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 28 Sep 2010 16:53:12 +0200
Subject: [PATCH 1/6] ARM: add PrimeCell generic DMA to PL022 v10
In-Reply-To: <AANLkTinoGjwWjqHQx-+UB+9K+s97t9c0y5i5-rdw=UA4@mail.gmail.com>
References: <1283354665-8673-1-git-send-email-linus.walleij@stericsson.com>	<1283354665-8673-2-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinoGjwWjqHQx-+UB+9K+s97t9c0y5i5-rdw=UA4@mail.gmail.com>
Message-ID: <4CA20158.5040700@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Williams wrote:
> [Me]
>> As mentioned I have no clue to why this failed to compile for Grant,
>> please see if this tenth version is still problematic or if it was
>> something intermittent.
>>
>> Else I really need help in knowing what config to compile, this was
>> compiled for U300, U8500 and RealView with and without DMA enabled.
> 
> Maybe it makes more sense for these filter_id functions to be defined
> in the arch code rather than the dma driver.  Right now there seems to
> be a weird dependency of arch requires dma-driver, dma-driver requires
> arch, and slave-driver requires arch and dma-driver in order to
> dynamically select dma-driver with dma_request_channel().  It forces
> dma-driver and slave-driver to always be compiled in, if I am reading
> this correctly.

I think what happened was two things:

- First that I was switching on CONFIG_DMADEVICES rather than
  CONFIG_DMA_ENGINE which caused the immediate compile warnings

- Second I had no dummy filter function for COH901318 and ste_dma40
  in case the driver was not compiled in or available as
  module.

I actually think it is OK to request that DMA drivers always be
compiled in for slave transfer support, they are *really* infrastructure
IMO.

And that is why "my" drivers are Kconfig:ed bool.

Yours,
Linus Walleij
