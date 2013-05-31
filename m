From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 31 May 2013 16:18:50 +0100
Subject: [PATCH 2/2] ARM: ux500: Enable HIGHMEM in the u8540 defconfig
In-Reply-To: <38058740.G1EqTG95pA@wuerfel>
References: <1370010272-25520-1-git-send-email-lee.jones@linaro.org>
 <1370010272-25520-2-git-send-email-lee.jones@linaro.org>
 <38058740.G1EqTG95pA@wuerfel>
Message-ID: <20130531151850.GC12488@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013, Arnd Bergmann wrote:

> On Friday 31 May 2013 15:24:32 Lee Jones wrote:
> > In order to utilise all of the memory located on ux500 based devices
> > we have to enable HIGHMEM. Without it the kernel truncates memory down
> > to what's left after the PAGE_OFFSET has been applied, which doesn't
> > leave an awful lot, especially if we're running large rootfs' such
> > as full Linux desktop distributions or Android.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> How much memory do those devices have? Enabling HIGHMEM is quite expensive.

Another 1GB.

> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 5439925..808be06 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> 
> You should probably resend the patch without the second half that got
> in it by accident.

I did already, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
