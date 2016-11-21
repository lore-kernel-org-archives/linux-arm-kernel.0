From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 21 Nov 2016 13:50:31 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20161121132419.GF1041@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20161121110604.GC1005@e106497-lin.cambridge.arm.com>
 <20161121112030.GC1041@n2100.armlinux.org.uk>
 <20161121113212.GF1005@e106497-lin.cambridge.arm.com>
 <20161121122556.GE1041@n2100.armlinux.org.uk>
 <20161121125653.GJ1005@e106497-lin.cambridge.arm.com>
 <20161121132419.GF1041@n2100.armlinux.org.uk>
Message-ID: <20161121135031.GK1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 01:24:19PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 21, 2016 at 12:56:53PM +0000, Liviu Dudau wrote:
> > That is mostly due to the check in hdlcd_crtc_disable() which I should
> > remove, I've added it because I was getting a ->disable() hook call
> > before any ->enable() was called at startup time. I need to revisit
> > this as I remember Daniel was commenting that this was not needed.
> 
> Removing that test results in:
> 
> [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:24:crtc-0] flip_done timed out
> 
> and the kernel hanging, seemingly in an IRQs-off region.

Right, I need to sort this one out. Are you doing these tests out of
some tagged branch that I can get in sync with?

Best regards,
Liviu

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
