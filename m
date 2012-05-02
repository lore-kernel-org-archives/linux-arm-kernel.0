From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 21:37:58 +0800
Subject: [PATCH 00/15] arch/arm/mach-* late_initcall cleanup
In-Reply-To: <201205021245.02831.arnd@arndb.de>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <201205021245.02831.arnd@arndb.de>
Message-ID: <20120502133757.GB2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 12:45:02PM +0000, Arnd Bergmann wrote:
> On Wednesday 02 May 2012, Shawn Guo wrote:
> > This series tries to clean up those late_initcall in arch/arm/mach-*,
> > which will be a blocker for single kernel build for multiple platforms.
> > Even on single platform, for example imx, where we already have single
> > kernel image for imx3, imx5 and imx6 families, late_initcall does not
> > scale.  We have to detect soc type in the late_initcall to do soc
> > sepcific late initialization.
> 
> Hi Shawn,
> 
> If you're targetting this at v3.5, I think we should get it into arm-soc
> as a staging branch to give it some more testing in linux-next ASAP.
> 
Thanks for the reminding, Arnd.  Yes, I'm targeting this at v3.5,
since the imx cpuidle drivers from Rob Lee which targets at v3.5
depends on it.

> If you send me a pull request, I can put it in and then we upgrade it
> to a proper branch for the next merge window when everyone is happy
> with it. Until then, you can send add-on patches or replacement
> pull requests. Most importantly, the first patch needs an Ack from
> Russell and we should see if there are any serious conflicts of the
> other patches with stuff in his tree. If so, we should put the
> branch into both the arm and the arm-soc tree before we send it off
> to Linus.
> 
Ok. Will do immediately once I get back from Russell on the first patch.

> On a related note, do you plan to do the same thing for subsys_initcall?
> 
I was asked by Russell to clean up late_initcall when I was trying to
propose some something to help imx cpuidle drivers, so I did not really
plan to do the same thing for subsys_initcall.  However, since you are
asking, I think I can do it.  But I would defer it a little bit until
we have device tree kill some amount of board files.

-- 
Regards,
Shawn
