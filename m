From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 17:16:23 +0200
Subject: [PATCH 0/4] arm64: dts: renesas: Add Support for R-Car D3 and
 Draak
In-Reply-To: <1500555277-22921-1-git-send-email-geert+renesas@glider.be>
References: <1500555277-22921-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170727151622.GG16143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:54:33PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds minimal support for the R-Car D3 SoC and the
> Draak development board, allowing to boot from a ramdisk using a serial
> console.
> 
>   - The first two patches add DT sources for R-Car D3 and Draak.
>     Due to the use of hardcoded constants, they have no further (build)
>     dependencies (obviously there is a runtime dependency).
>   - The last two patches replace the hardcoded constants by symbols from
>     DT binding headers, and thus depend on those headers.  Hence it
>     should be postponed to v4.15.
> 
> For proper operation, this depends on the 3 series I have just sent:
>   - [PATCH 0/3] arm64: renesas: Base R-Car D3 support,

I have applied the above patchset for v4.14.

>   - [PATCH 0/4] soc: renesas: Add R-Car D3 support,

And this one too.

>   - [PATCH 0/4] clk: renesas: Add R-Car D3 support.

And this one seems to have been acked, so I assume you will
apply it once you are back from holidays.

So I have applied the first two patches for v4.14.
Please repost the remaining two after v4.13-rc6 at which time I should
be able to queue them up for v4.15.

> For testing, an integration branch containing all dependencies (and a
> few DT binding updates I do not want to send before "ARM: shmobile:
> Document R-Car D3 SoC DT bindings" has been accepted) is available in
> the topic/r8a77995-integration branch of the git repository at
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (4):
>   arm64: dts: renesas: Add Renesas R8A77995 SoC support
>   arm64: dts: renesas: Add Renesas Draak board support
>   arm64: dts: renesas: r8a77995: Use r8a7795-sysc binding definitions
>   arm64: dts: renesas: r8a77995: Use r8a7795-cpg-mssr binding
>     definitions
> 
>  arch/arm64/boot/dts/renesas/Makefile           |   1 +
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts |  46 ++++++++
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi      | 151 +++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a77995.dtsi
> 
> -- 
> 2.7.4
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
