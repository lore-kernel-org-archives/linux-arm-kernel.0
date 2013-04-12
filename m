From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 12 Apr 2013 09:06:35 +0200
Subject: [PATCH 17/30] pwm: samsung: repair the worst MMIO abuses
In-Reply-To: <1365638712-1028578-18-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-18-git-send-email-arnd@arndb.de>
Message-ID: <20130412070635.GA16956@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:04:59AM +0200, Arnd Bergmann wrote:
> The Samsung PWM driver uses "magic" pointers that are mapped
> at boot time to point its MMIO registers. This fails horribly
> with a multiplatform kernel, which can not rely on platform
> specific header files to contain the right values, aside from
> this being a really bad idea in general.
> 
> This changes the driver to at least pass an __iomem token
> around in the device structure to dereference that. Fixing
> the platform code is much harder, so we'll leave that
> until we have a DT binding for pwm-samsung, which may require
> other changes in this area. Since we are already touching
> every MMIO accessor in this driver, let's also use the
> proper readl_relaxed variant rather than __raw_readl.
> 
> Tomasz Figa has a set of patches to clean this up in a proper
> way, but that might be too late for 3.10.

Joonyoung Shim (Cc'ed) posted a driver for Exynos back in December. I
had a few comments on it but never saw an updated version. Is Tomasz'
work based on that patch?

Given that this patch solves a real problem and doesn't make things any
worse, I think it's okay to use it temporarily until Tomasz has had time
to finish up the proper driver, so:

Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130412/30629483/attachment.sig>
