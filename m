From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 21:53:19 +0200
Subject: [PATCH, RFC 20/22] media: coda: select GENERIC_ALLOCATOR
In-Reply-To: <1367515255.447627800@f375.mail.ru>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-21-git-send-email-arnd@arndb.de>
 <1367515255.447627800@f375.mail.ru>
Message-ID: <201305022153.19518.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Alexander Shiyan wrote:
> > The coda driver uses the generic allocator to get at the
> > "iram" memory, so add the necessary dependency to avoid:
> > 

> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index 0494d27..4608d03 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -145,6 +145,7 @@ config VIDEO_CODA
> >       depends on VIDEO_DEV && VIDEO_V4L2 && ARCH_MXC
> >       select VIDEOBUF2_DMA_CONTIG
> >       select V4L2_MEM2MEM_DEV
> > +     select GENERIC_ALLOCATOR
> >       ---help---
> >          Coda is a range of video codec IPs that supports
> >          H.264, MPEG-4, and other video formats.
> 
> Again?
> 

Ah, now I remember where I saw this before -- you sent the same patch, and
Fabio commented that Shawn had already queued up a different solution.

Unfortunately, linux-next as of today is still broken. Shawn, did I
miss a pull request from you?

	Arnd
