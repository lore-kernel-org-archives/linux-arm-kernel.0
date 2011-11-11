From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Fri, 11 Nov 2011 07:59:17 +0100
Subject: ioremap on system memory
In-Reply-To: <4EBC4C27.3070400@gmail.com>
References: <CAM8FrKJ8OeavZxTBJBONw76UBBzS_mQYMZuS6Chf8+Po6yqDgA@mail.gmail.com>
 <4EBC4C27.3070400@gmail.com>
Message-ID: <CAM8FrKKAz6okqX+SxwmgCvqQpBmYwVYLWxqbVQ36q4o2T1gX5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/10 Ryan Mallon <rmallon@gmail.com>
>
> On 10/11/11 19:06, Marcus Folkesson wrote:
>
> > Hi,
> >
> > I'm working with a custom based platform based on OMAP-L138.
> > A driver we are using is ioremapping system memory. It does this to
> > share data between the GPP and DSP core.
> > This is not allowed in later kernel versions since ARMv6+ does not support this.
> >
> > Is there any good(and easy) way to get around this or is it so
> > fundamentally wrong that the driver should be written from scratch?
>
>
> Cc'ed the ARM kernel list and Marek Szyprowski (CMA developer). The CMA
> patches I think do what you want, but I am not sure if they are merged
> yet. The other solution (again, I'm not an expert on this area) is to
> not pass the region of memory you want to manage as part of Linux's
> normal system memory. See how the OMAP framebuffer driver reserves a
> region of SDRAM (arch/arm/plat-omap/fb.c).
>
> Some one else on the ARM list can probably explain in more detail.
>
> ~Ryan
>

Not passing the region of the concerned memory seems to solve the problem.
Thank you!

Med v?nliga h?lsningar / Best regards
Marcus Folkesson
