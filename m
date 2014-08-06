From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Aug 2014 11:26:41 +0100
Subject: [PATCH] mtd: nand: stm_nand_bch: add new driver
In-Reply-To: <20140703002237.GM3599@ld-irv-0074>
References: <1401268805-26043-1-git-send-email-lee.jones@linaro.org>
 <20140703002237.GM3599@ld-irv-0074>
Message-ID: <20140806102641.GB10136@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jul 2014, Brian Norris wrote:
> On Wed, May 28, 2014 at 10:20:05AM +0100, Lee Jones wrote:

[...]

> > +	if (((unsigned int)buf & (NANDI_BCH_DMA_ALIGNMENT - 1)) ||
> > +	    (!virt_addr_valid(buf))) /* vmalloc'd buffer! */
> > +		bounce = true;
> > +
> > +	p = bounce ? nandi->page_buf : buf;
> 
> It looks like you're reimplementing NAND_USE_BOUNCE_BUFFER. Can you try
> using that flag? (You may need to extend it to account for your DMA
> alignment, too.)

NAND_USE_BOUNCE_BUFFER won't work for us unless we can guarantee that
the bounce buffer will always be 64 Byte aligned, which I don't think
we can.  Another way to do it would be to assign all of our own
buffers, but I'm really not comfortable fiddling with those as there
are a lot of controller specific intricacies which a) I'm not familiar
with and b) no longer have Angus to fire questions off to and/or
review.

So if you don't mind, I'd really rather use Angus' implementation.
It's only an extra couple of lines and Angus has already tested it to
a high level.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
