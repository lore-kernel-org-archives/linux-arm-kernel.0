From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Nov 2018 17:18:03 +0100
Subject: [PATCH 06/27] kernel: Define gettimeofday vdso common code
In-Reply-To: <20181109123730.8743-7-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
Message-ID: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
>
> This patch tries to unify the gettimeofday vdso implementation
> introducing lib/vdso. The code contained in this library can
> ideally be reused by all the architectures avoiding, where
> possible, code duplication.
>
> In doing so, tries to maintain the performances using inlining as much
> as possible and consequently reduces the surface for ROP type of attacks.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I just noticed that this new version misses some of the cleanups
that Thomas recently did in the x86 version, e.g. f3e839384164
("x86/vdso: Replace the clockid switch case").

I haven't looked at all the details, but I'd suggest using the latest
x86 code as a base.

        Arnd
