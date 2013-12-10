From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 10:45:58 +0100
Subject: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
In-Reply-To: <201312080344.56317.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de>
 <20131206135825.GG29268@sirena.org.uk>
 <201312080344.56317.arnd@arndb.de>
Message-ID: <CACRpkdYN6X=Qd1Fyy9dyM7FStMaMMDAQCzQOxX4cwHM-J00kHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 8, 2013 at 3:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I'd agree as soon as someone can convince me that we actually want ACPI
> support in the kernel for ARM64 servers. As far as I'm concerned it's quite
> possible that the people who have worked on this for the past couple of
> years behind closed doors know what they are doing and it will all be
> good, but it's also possible that it turns into a huge trainwreck once
> we see multiple implementations that have fundamentally incompatible
> requirements regarding what they want from ACPI and we end up not doing
> it at all.

Here is a piece I've noticed very clearly in the GPIO subsystem:

ACPI is persued for x86 servers, desktops by all vendors. For
embedded x86 it is persued by Intel *ONLY*. We still get several
embedded GPIO drivers for x86 that use ISA-style portmapped I/O
probing (!)

So, hehe, in init/Kconfig there is still the much-debated Kconfig
option "EMBEDDED"...

Should ACPI for ARM64 be depends on !EMBEDDED?

Yours,
Linus Walleij
