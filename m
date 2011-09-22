From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 22 Sep 2011 10:59:04 +0900
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <20110921185312.GK17357@phenom.oracle.com>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<20110914214204.GA16666@phenom.oracle.com>
	<002c01cc738b$1c717df0$555479d0$%dae@samsung.com>
	<20110915141501.GA19897@phenom.oracle.com>
	<001501cc766b$0cb7eba0$2627c2e0$%dae@samsung.com>
	<20110921185312.GK17357@phenom.oracle.com>
Message-ID: <000201cc78cb$34b96040$9e2c20c0$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Konrad Rzeszutek Wilk.

> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk at oracle.com]
> Sent: Thursday, September 22, 2011 3:53 AM
> To: Inki Dae
> Cc: airlied at linux.ie; dri-devel at lists.freedesktop.org;
> sw0312.kim at samsung.com; kyungmin.park at samsung.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
> 
> > > > > > +		DRM_ERROR("desired size is bigger then real
> > size.\n");
> > > > >
> > > > > So .. you can't continue by just using the real size instead?
> > > > >
> > > >
> > > > I am afraid I don't understand what you mean but I think that
> condition
> > > is
> > > > fine. size is a vm area to user-desired size and you could request
> > > mapping
> > > > as specific size. so it just check user-requested virtual space
> region
> > > it
> > > > bigger than allocated physical memory region to be mapped. if there
> is
> > > my
> > > > missing points, I would be happy to you give me your comments. thank
> > you.
> > >
> > > I meant that you return -EINVAL. But I am wondering if it would be
> > > possible
> > > to just continue on, but ignore what the user specified.
> > >
> > > I think the issue here is that you are outputing the DRM_ERROR and
> > > I am not sure if it is that neccessary. Perhaps DRM_DEBUG, but
> DRM_ERROR
> > > just seems a bit.. heavy handed.
> > >
> >
> > I thought this condition would be critical issue as user application
> should
> > be terminated. is your wondering if user application could go ahead
> after
> > mmap failed? this is just my view so I would be happy you to give me
> your
> > advice. Thank you.
> 
> I think terminating the appliaction is the right thing. But the DRM_ERROR
> is not neccessary.

I understood. I will remove DRM_ERROR or use DRM_DEBUG instead. thank you.
