From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jul 2013 22:55:10 +0200
Subject: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
In-Reply-To: <20130705173321.GE27646@sirena.org.uk>
References: <201307051745.16140.arnd@arndb.de>
 <20130705173321.GE27646@sirena.org.uk>
Message-ID: <201307052255.10765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 05:45:15PM +0200, Arnd Bergmann wrote:
> > This is required so we can build the imx sound support
> > when ALSA itself is a loadable module.
> 
> Is this actually OK with the FIQ APIs?
> 

I don't know. Why wouldn't it?

Other users of the same interfaces (mx1_camera, spi-s3c24xx) can also be
modules, so I wouldn't expect a fundamental issue.

	Arnd
