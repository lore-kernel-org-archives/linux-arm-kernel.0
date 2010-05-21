From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 21 May 2010 12:56:04 -0700
Subject: [patch] nuc900fb: release correct mem region
In-Reply-To: <AANLkTimDYkjTEVMFl8Vrbwblg46-ErGEaUV3M9-DWbCu@mail.gmail.com>
References: <20100325105408.GD5069@bicker> <20100519194854.GB22515@bicker>
	<AANLkTimDYkjTEVMFl8Vrbwblg46-ErGEaUV3M9-DWbCu@mail.gmail.com>
Message-ID: <20100521125604.3065ca0e.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 May 2010 10:36:59 +0800
Wan ZongShun <mcuos.com@gmail.com> wrote:

> Hi Dan,
> 
> Qiang brother have a busy doing business, so I can maintain the
> nuc900fb driver instead.

Feel free to send an update to the MAINTAINERS file.

> It looks good to me.
> 
> Andrew , Could you help merge this patch? thanks a lot!
> 
> Acked-by: Wan ZongShun<mcuos.com@gmail.com>
> 
> 
> 2010/5/20 Dan Carpenter <error27@gmail.com>:
> > Ping. __Any feedback on this patch?
> >
> > regards,
> > dan carpenter
> >
> > On Thu, Mar 25, 2010 at 01:54:08PM +0300, Dan Carpenter wrote:
> >> We should be releasing "res->start" here.
> >>
> >> Signed-off-by: Dan Carpenter <error27@gmail.com>
> >> ---
> >> BTW. __Congratulations on being an official driver maintainer now. __:) __Can
> >> you add yourself to the MAINTAINERS file?
> >>
> >> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> >> index 6bf0d46..d4cde79 100644
> >> --- a/drivers/video/nuc900fb.c
> >> +++ b/drivers/video/nuc900fb.c
> >> @@ -667,7 +667,7 @@ release_irq:
> >> __release_regs:
> >> __ __ __ iounmap(fbi->io);
> >> __release_mem_region:
> >> - __ __ release_mem_region((unsigned long)fbi->mem, size);
> >> + __ __ release_mem_region(res->start, size);
> >> __free_fb:
> >> __ __ __ framebuffer_release(fbinfo);
> >> __ __ __ return ret;
> >

I don't think I ever received a copy of this patch.  I reconstructed it.
