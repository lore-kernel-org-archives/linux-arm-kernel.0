From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 17 Jul 2015 12:45:31 +0200
Subject: drm/edid: sound/core: pcm_drm_eld.c compilation error in 4.2
In-Reply-To: <20150716164643.GM7557@n2100.arm.linux.org.uk>
References: <20150716181658.553e6da7@armhf>
 <20150716164643.GM7557@n2100.arm.linux.org.uk>
Message-ID: <s5hd1zrhxkk.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 18:46:43 +0200,
Russell King - ARM Linux wrote:
> 
> On Thu, Jul 16, 2015 at 06:16:58PM +0200, Jean-Francois Moine wrote:
> > The file sound/core/pcm_drm_eld.c which was added by the commit
> > 
> > 	838d1631b766529213684f07dd71cdf2e92f0623
> > 	ALSA: pcm: add DRM ELD helper
> > 
> > lacks the function drm_eld_sad() which was defined by Russell's patch
> > 
> > 	http://article.gmane.org/gmane.linux.ports.arm.kernel/411574
> > 	drm/edid: add function to help find SADs
> > 
> > This patch has not been applied.
> 
> Grr, that's the danger of trying to split changes which cross between
> subsystems.  I hate todays fragmented nature of kernel development,
> it's really a nightmare.
> 
> I'm not sure how this can be resolved now, I asked Dave Airlie to pull
> the next set of patches which include the one adding the SAD helper;
> he's probably already pulled that for -next, so to pull out just that
> patch and try to get it merged into -rc is going to be far from nice,
> and will probably introduce conflicts.

Oh, that's bad that the DRM part slipped from 4.2 merge.
OTOH, the commit in sound side adds a code enabled only when a new
Kconfig is set, and currently there is no one setting this Kconfig.
(and it's no selectable).  So there should be no breakage as of now.


thanks,

Takashi
