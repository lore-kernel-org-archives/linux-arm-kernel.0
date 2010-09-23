From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 23 Sep 2010 14:31:22 -0700
Subject: [PATCH 1/6] ARM: add PrimeCell generic DMA to PL022 v10
In-Reply-To: <1283354665-8673-2-git-send-email-linus.walleij@stericsson.com>
References: <1283354665-8673-1-git-send-email-linus.walleij@stericsson.com>
	<1283354665-8673-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTinoGjwWjqHQx-+UB+9K+s97t9c0y5i5-rdw=UA4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 8:24 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the PL022 SSP/SPI driver with generic DMA engine
> support using the PrimeCell DMA engine interface. Also fix up the
> test code for the U300 platform.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> As mentioned I have no clue to why this failed to compile for Grant,
> please see if this tenth version is still problematic or if it was
> something intermittent.
>
> Else I really need help in knowing what config to compile, this was
> compiled for U300, U8500 and RealView with and without DMA enabled.

Maybe it makes more sense for these filter_id functions to be defined
in the arch code rather than the dma driver.  Right now there seems to
be a weird dependency of arch requires dma-driver, dma-driver requires
arch, and slave-driver requires arch and dma-driver in order to
dynamically select dma-driver with dma_request_channel().  It forces
dma-driver and slave-driver to always be compiled in, if I am reading
this correctly.

--
Dan
