From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 17:43:26 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <540F1409.3070206@antcom.de>
References: <540F1409.3070206@antcom.de>
Message-ID: <4173517.3fBhGIV2aO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:51:53 Roland Stigge wrote:
> The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:
> 
>   Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6 lpc32xx/dt
> 
> for you to fetch changes up to de1fcd7f8a6d313c92c2af476b012305d4fe6553:
> 
>   ARM: LPC32xx: Use DMA for both SSP channels (2014-09-09 15:05:31 +0200)
> 

Hi Roland,

I'm glad to see some pull requests from you again, you've been
absent for a while.

I have no objection to the patches, but I notice that you have just
rebased them all today on the latest -rc.
In general, we prefer the branches to be based on an older -rc,
preferably -rc1, unless you have a dependency on a bug fix that
went into a later one.
Can you rebase them to -rc1 and send a new version?

On a separate topic, are you still actively working with lpc32xx
based machines? You cleaned up the platform a lot when you took
over in 2012, but now we have move other platforms much further
and I wonder if you could do some of the same changes.
Most importantly, I really want most platforms to be part of
ARCH_MULTIPLATFORM and build them into the same image. For
lpc32xx, this is currently not possible because you are not using
the common clk implementation. Would it be possible for you
to look into converting that driver over and moving it to
drivers/clk?
There are a few other things that could be done if you are motivated,
but that is the only one that I need and can't do myself.

	Arnd
