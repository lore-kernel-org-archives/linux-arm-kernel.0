From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 16 Dec 2014 01:37:51 +0200
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <548ABAB6.6010200@collabora.co.uk>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <548ABAB6.6010200@collabora.co.uk>
Message-ID: <3197445.qizQc0zeRb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Friday 12 December 2014 10:51:50 Javier Martinez Canillas wrote:
> Hello,
> 
> On 11/18/2014 07:20 AM, Ajay kumar wrote:
> > On Sat, Nov 15, 2014 at 3:24 PM, Ajay Kumar wrote:
> >> This series is based on master branch of Linus tree at:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> This series has been in the mailing lists for months and have been tested
> by many people. What else is missing before it can be merged?
> 
> It would be great to have proper display support on platforms that have a
> eDP to LVDS bridge chip (e.g: Snow, Peach Pit and Spring Chromebooks) and
> everything is in place but this series which had been missing many kernel
> releases already.
> 
> >> Changes since V7:
> >>         -- Address comments from Tomi and Laurent:
> >>                 -- Use videoports and endpoints to represent the
> >>                 connection between
> >>                 
> >>                    encoder, bridge and the panel, instead of using
> >>                    phandles.
> >>         
> >>         -- Address comments from Daniel:
> >>                 -- Make the patch description more descriptive.
> >>                 -- remove device pointer from drm_bridge, and just use
> >>                 
> >>                    device_node instead.
> >>                 
> >>                 -- don't pass encoder pointer to bridge_attach.
> >>         
> >>         -- Address comments from Sean Paul:
> >>                 -- Remove bridge from mode_config, and pull out
> >>                 drm_bridge
> >>                 
> >>                    functions from drm_crtc.c to drm_bridge.c
> 
> Tomi and Laurent,
> 
> You asked Ajay to change his series to use the video port and enpoints DT
> bindings instead of phandles, could you please review his latest version?
> 
> I guess is now too late for 3.19 since we are in the middle of the merge
> window but it would be great if this series can at least made it to 3.20.

I don't have time to review the series in details right now, but I'm happy 
with the DT bindings, and have no big issue with the rest of the patches. I 
don't really like the of_drm_find_bridge() concept introduced in 03/14 but I 
won't nack it given lack of time to implement an alternative proposal. It's an 
internal API, it can always be reworked later anyway.

-- 
Regards,

Laurent Pinchart
