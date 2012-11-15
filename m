From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 14:39:41 +0000
Subject: [PATCH] ARM: add get_user() support for 8 byte types
In-Reply-To: <CAF6AEGuJReNtwUZX6HVZCE8GHuyEAyC8bM0GqZuVMV1=DrGJVw@mail.gmail.com>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
 <201211151339.08016.arnd@arndb.de>
 <CAF6AEGuJReNtwUZX6HVZCE8GHuyEAyC8bM0GqZuVMV1=DrGJVw@mail.gmail.com>
Message-ID: <201211151439.41393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Rob Clark wrote:
> > I still haven't heard a conclusive argument why we need to use get_user()
> > rather than copy_from_user() in the DRM code. Is this about a fast path
> > where you want to shave off a few cycles for each call, or does this
> > simplify the code structure, or something else?
> 
> well, it is mostly because it seemed like a good idea to first try to
> solve the root issue, rather than having to fix things up in each
> driver when someone from x86-world introduces a 64b get_user()..

As pointed out by hpa earlier, x86-32 doesn't have a 64b get_user
either. I don't think we have a lot of drivers that are used only
on 64-bit x86 and on 32-bit ARM but not on 32-bit x86.

> There are some other arch's that don't have 64b get_user(), but I
> don't think any that have any DRM drivers.  If 64b get_user() is
> really not intended to be supported by all archs, it is better to
> remove it from x86 and the other arch's that do currently support it,
> rather than making it possible to write drivers that are broken on
> some archs.

The majority of architectures we support have PCI and should be able
to build the regular (radeon, nouveau, MGA, VIA, ...) DRM drivers
AFAICT.

	Arnd
