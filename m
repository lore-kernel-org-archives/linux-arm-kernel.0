From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Mar 2017 10:49:38 +0100
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170308163025.31098-1-Liviu.Dudau@arm.com>
References: <20170222153036.GI31595@intel.com>
 <20170308163025.31098-1-Liviu.Dudau@arm.com>
Message-ID: <20170331094937.GO7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 04:30:25PM +0000, Liviu Dudau wrote:
> The calculation of the framebuffer's start address was wrongly using
> the CRTC's x and y position rather than the one of the source
> framebuffer. To fix that we need to update the plane_check code to
> call drm_plane_helper_check_state() to clip the src and dst coordinates.
> While there so some minor cleanup of redundant freeing of
> devm_alloc-ated memory.

The following series is what I came up with, although I've had no time
to test it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
