From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2011 23:54:36 +0000
Subject: [linux-next] make  s5p64x0_defconfig build error
In-Reply-To: <4EE93185.9030502@solonet.org.ua>
References: <1323838630.18517.1.camel@phoenix>
 <20111214123244.GE7122@mudshark.cambridge.arm.com>
 <20111214191205.GF14542@n2100.arm.linux.org.uk>
 <4EE93185.9030502@solonet.org.ua>
Message-ID: <20111214235436.GG14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 01:30:13AM +0200, Denis Kuzmenko wrote:
> On 12/14/2011 09:12 PM, Russell King - ARM Linux wrote:
> > On Wed, Dec 14, 2011 at 12:32:44PM +0000, Will Deacon wrote:
> >> On Wed, Dec 14, 2011 at 04:57:10AM +0000, Axel Lin wrote:
> > So... unless things change, we can expect Gemini, almost all Samsung
> > stuff, shmobile, vt8500, and Telechips TCC8k to be at least broken at
> > the next merge window.
> 
> Mini2440 march (s3c24xx platform) is not broken in v3.2-rc5. Does that
> mean that s3c24xx is untouched by this issue or this means that I should
> use linux-next?

Most of the completed changes are in linux-next for the restart changes.
I have some additional commits (which were posted to the list as the 3rd
sub-series), which I'm not planning to submit in their current form -
they move things _towards_ sorting out the samsung stuff, but they're
all incomplete.  These continue to be a part of my 'reset' branch.

Basically, the comments in the commit summary line marked with XXX need
addressing - and folk need to get out of the habbit of thinking "it's
an include file, it must go into somewhere called 'include'."  Instead,
put includes local to a set of files in a directory in that same
directory.

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Nov 6 16:22:23 2011 +0000

    ARM: restart: plat-samsung: remove plat/reset.h and s5p_reset_hook

    Now that s5p_reset_hook is unused, we can get rid of plat/reset.h and
    the s5p_reset_hook code in plat/system-reset.h.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Nov 6 16:20:11 2011 +0000

    ARM: restart: s5pv210: use new restart hook XXX WIP XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX

    Hook these platforms restart code into the new restart hook rather
    than using arch_reset().

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Nov 6 13:24:20 2011 +0000

    ARM: restart: exynos4: use new restart hook XXX WIP XXX WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX

    Hook these platforms restart code into the new restart hook rather
    than using arch_reset().

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
