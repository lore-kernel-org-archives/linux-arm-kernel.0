From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 May 2015 17:46:56 +0100
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <20150530164655.GM2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 05:37:57PM +0200, Mikko Rapeli wrote:
> Fixes userspace compilation error:
> 
> drm/exynos_drm.h:30:2: error: unknown type name ?uint64_t?
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>

This is another thing which we need to address.  We should not be using
unsigned int/unsigned long/uintXX_t/etc in here, but the __uXX and __sXX
types.

The lesson learned from other DRM developers is that using these types
simplifies the API especially when it comes to the differences between
32-bit and 64-bit machines, and compat applications.

Note that drm/drm.h is all that should need to be included - drm/drm.h
takes care of including linux/types.h when building on Linux platforms.
(note: if your compiler doesn't set __linux__ then you're probably not
using the proper compiler...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
