From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jul 2018 21:24:41 +0200
Subject: Subject: [PATCH 00/22] gpio: xilinx: update driver to match
 official xilinx version
In-Reply-To: <5D23E7CAADD3BE4A97642792FFC691C561C7A3D7@MBX215.d.ethz.ch>
References: <5D23E7CAADD3BE4A97642792FFC691C561C7A3D7@MBX215.d.ethz.ch>
Message-ID: <CACRpkdan_Fc8E2o69_48OZU-N_4HUBh2uY77Se3qTVvRSny3bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 4:14 PM Hedges Alexander
<ahedges@student.ethz.ch> wrote:

An overarching question:

the whole patch set contains things like this:

> +#ifdef CONFIG_OF
(...)
> +#else
(...)
> +#endif

But arch/arm/mach-zynq and the Aarch64 counterpart are
OF-only.

I.e. these adaptions must have been made for some Xilinx
platform support codebase that is not upstream, and which does
not use device tree.

If this is the case, I insist that these non-OF platforms are
upstreamed *first*, because we are trying to get rid of
non-OF platforms from the ARM kernel, and the Aarch64
kernel simply does not allow them (unless they are instead
using ACPI). It is as far as I can tell code that cannot be
tested with any machine supported in the upstream kernel
and the upstream kernel should only contain code that
can be executed with an unpatched kernel.

Yours,
Linus Walleij
