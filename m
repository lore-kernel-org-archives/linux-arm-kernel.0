From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 11:16:17 +0000
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
 <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
Message-ID: <201303181116.17369.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Jonas Jensen wrote:
> 
> On 15 March 2013 13:49, Florian Fainelli <florian@openwrt.org> wrote:
> > Someone recently announced support for a Moxart SoC which seems to use the
> > FA526 core however.
> 
> That was probably me, and I understand people want it gone. Even
> Debian wants v4:s gone because they're not strictly EABI (
> http://lists.debian.org/debian-arm/2010/12/msg00044.html ).

It's not that we want it gone, it si that we want unmaintained code
to be removed. ARMv4 support is going to stay at least for a couple
more years, probably longer given the number of ARM7TDMI and StrongARM
systems still in use.

There are probably no general purpose distros that will build for
ARMv4 any more, but a lot of the embedded distros (OpenWRT, OpenEmbedded,
Buildroot, ...) typically build all user space from source anyway, so
there is no issue.

> The port is not near mainline but I think I'd prefer if CPU_FA526
> wasn't removed. If someone stepped up to maintain ARCH_GEMINI (so I
> could peek at the changes) that would be even better :)

I've tried before to find someone who is still interested in Gemini,
but it seems nobody has the hardware any more.

My plan right now is to leave CPU_FA526 alone but drop ARCH_GEMINI
in 3.10. We can revisit the situation next year. If we don't hear back
from you or someone else interested in this CPU type by then, we can
still drop it then. It's not a maintainance burden anyway, the CPU
specific code is well isolated and does not change a lot, compare
to platform specific code.

	Arnd
