From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jul 2012 04:40:02 -0700
Subject: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable OMAP DMA
 engine support
In-Reply-To: <CABxcv=nbUOKKhJxTG302fX=UzHsX3mN=R2nEi88VZM61ka11Vg@mail.gmail.com>
References: <1342321398-11009-1-git-send-email-javier@dowhile0.org>
 <87bojfeikj.fsf@ti.com>
 <CABxcv=nbUOKKhJxTG302fX=UzHsX3mN=R2nEi88VZM61ka11Vg@mail.gmail.com>
Message-ID: <20120719114001.GO6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [120716 16:33]:
> On Mon, Jul 16, 2012 at 7:12 PM, Kevin Hilman <khilman@ti.com> wrote:
> > Javier Martinez Canillas <javier@dowhile0.org> writes:
> >
> >> commit 13f30fc893e4610f67dd7a8b0b67aec02eac1775
> >> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> >> Date:   Sat Apr 21 22:41:10 2012 +0100
> >>
> >>     mmc: omap: remove private DMA API implementation
> >>
> >> removed the private DMA API implementation from the OMAP mmc host to
> >> make it use exclusively the DMA engine API.
> >>
> >> Unfortunately the omap2plus_defconfig doesn't enable this feature
> >> leading to the following error on an IGEPv2 Rev.C (and probably on most
> >> boards with MMC support):
> >
> > Personally, I'd rather see this fixed by having the drivers that depend
> > on DMA engine 'select DMADEVICES'.  That way, any defconfig will work
> > correctly instead of just omap2plus_defconfig.
> >
> > Kevin
> >
> 
> Hi Kevin,
> 
> Thanks a lot for your feedback. I'll do what you suggest and send a v2
> of the patch.

I'd rather see the drivers fixed to work with and without DMA as the
channels can run out. Also forcing the select is not good for distro kernels.

I'll apply this fix into l-o master branch while we're discussing the
issue.

Regards,

Tony
