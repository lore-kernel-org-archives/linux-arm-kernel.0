From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Aug 2013 01:07:31 +0100
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
Message-ID: <20130803000731.GS23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 04:41:11PM -0700, Olof Johansson wrote:
> Russell,
> 
> Looks like you sent up some fixes to Linus that broke one of the atmel
> configs (CONFIG_MMU=n):
> 
> commit 48be69a026b2c1 ARM: move signal handlers into a vdso-like page
> 
> seems to have caused it:
> 
> arch/arm/kernel/signal.c: In function 'setup_return':
> arch/arm/kernel/signal.c:413:25: error: 'mm_context_t' has no member
> named 'sigpage'
> 
> I see it with at91x40_defconfig.

I'll look into that.  Obviously, I never build nommu because it isn't
part of the build system and the nommu platform I do have - OKI67001 -
doesn't have mainline kernel support.  (And if it did, it would not be
DT, so I doubt it's submittable.)
