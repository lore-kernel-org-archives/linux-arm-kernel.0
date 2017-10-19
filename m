From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 18:01:17 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.15
In-Reply-To: <cover.1506325834.git.horms+renesas@verge.net.au>
References: <cover.1506325834.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a32rCXame_ERzefy+va+40gL7NB-8Ff6XaqmXsLQpxGZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 9:54 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC updates for v4.15.
>
>
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.15
>
> for you to fetch changes up to 3fd45a136ff61bb54deab70fb2d534a85e40481f:
>
>   ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15 (2017-09-18 08:10:44 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.15
>
> * Prepare to enable SMP on R-Car E2 (r8a7794).
>
>   Geert Uytterhoeven says:
>   "The main hurdle here is that R-Car Gen2 boot loaders do not initialize
>    the arch_timer CNTVOFF register, which thus needs workarounds on Linux.
>
>    - The first patch adds a definition for MON_MODE, as suggested by Marc
>      Zyngier,
>    - The second patch makes sure CNTVOFF is initialized for boot and
>      secondary Cortex-A15 and Cortex-A7 CPU cores, like is already done for
>      the boot Cortex-A7 CPU core.  Without this, the ARM arch timer does
>      not work on secondary CPU cores."
>
>    A follow-up patch to enable SMP in DT on R-Car E2 (r8a7794) is currently
>    deferred unto v4.16 as it depends on the above.
>
> * Enable low-level debugging support for RZ/G1E (r8a7745).
>
>   Fabrizio Castro says, "RZ/G1E uses SCIF4 for the debug console."

Pulled into next/soc, thanks!

       Arnd
