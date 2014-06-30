From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 18:07:38 +0100
Subject: [GIT PULL] nommu fixes for 3.17-rc1
In-Reply-To: <CACRpkdZkwzEi2fYqRS-6o_EM-BeOS26Z2uS4DwEmaVT+FEW6eg@mail.gmail.com>
References: <20140630144355.GH14781@pengutronix.de>
 <4782912.zqsM5TNPdE@wuerfel>
 <CACRpkdZkwzEi2fYqRS-6o_EM-BeOS26Z2uS4DwEmaVT+FEW6eg@mail.gmail.com>
Message-ID: <20140630170738.GB30740@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:00:37PM +0100, Linus Walleij wrote:
> On Mon, Jun 30, 2014 at 5:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Your reasoning is that mach-integrator now doesn't work with !MMU any more
> > since it selects ARM_PATCH_PHYS_VIRT, and that no other platform uses
> > these CPUs. The change to integrator was done as a preparation for
> > multiplatform support and probably did not mean to remove support for !MMU
> > integrator.
> 
> Well actually the !MMU case has probably never really worked on the
> Integrator. I never heard of anyone doing that. The only person who ever
> mentioned running !MMU tiles (such as the 740 or 94x variants) was Will
> Deacon and I don't know if he ever got it anywhere.

I booted a 740t on an Integrator AP at the start of last year without issues
(once I'd fixed up proc-arm740.S -- the patches are in mainline). It wasn't
for anything useful though, I'm just sad that way.

> However if it is a good testbase for people synthesizing these old non-MMU
> ARM cores still and using Linux with them, then it would make sense to
> get that into shape and supported I guess? Especially now that the
> Integrator machine is soon-ish even multiplatform (famous last words).
> 
> So we need some input here ...

To be honest, I'm finding it more and more difficult to care about uclinux
outside of Cortex-M. Could we simply decide to support only v7m and rip out
the code for other !MMU targets, or are there actually users of those things
with mainline kernels?

Will
