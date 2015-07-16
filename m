From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jul 2015 17:46:43 +0100
Subject: drm/edid: sound/core: pcm_drm_eld.c compilation error in 4.2
In-Reply-To: <20150716181658.553e6da7@armhf>
References: <20150716181658.553e6da7@armhf>
Message-ID: <20150716164643.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 06:16:58PM +0200, Jean-Francois Moine wrote:
> The file sound/core/pcm_drm_eld.c which was added by the commit
> 
> 	838d1631b766529213684f07dd71cdf2e92f0623
> 	ALSA: pcm: add DRM ELD helper
> 
> lacks the function drm_eld_sad() which was defined by Russell's patch
> 
> 	http://article.gmane.org/gmane.linux.ports.arm.kernel/411574
> 	drm/edid: add function to help find SADs
> 
> This patch has not been applied.

Grr, that's the danger of trying to split changes which cross between
subsystems.  I hate todays fragmented nature of kernel development,
it's really a nightmare.

I'm not sure how this can be resolved now, I asked Dave Airlie to pull
the next set of patches which include the one adding the SAD helper;
he's probably already pulled that for -next, so to pull out just that
patch and try to get it merged into -rc is going to be far from nice,
and will probably introduce conflicts.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
