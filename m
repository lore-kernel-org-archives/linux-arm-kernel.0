From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 22:10:34 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC SoC Updates for v4.20
In-Reply-To: <cover.1538127537.git.horms+renesas@verge.net.au>
References: <cover.1538127537.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a0NreOTfL6L+w2WHnC5uf3jELf6ud_wdBZ7iAU3yuf4VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:21 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM64 based SoC SoC updates for v4.20.
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-soc-for-v4.20
>
> for you to fetch changes up to 692dce77dfb71b5eaf896d3cdc7ef72f70631b14:
>
>   arm64: Add Renesas R8A774C0 support (2018-09-11 15:50:57 +0200)
>
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC SoC Updates for v4.20
>
> * Add support for RZ/G2E (r8a774c0) and RZ/G2M (r8a774a1) SoCs
> * Enable Compare Match Timer (CMT) and Timer Unit (TMU)
>   for Renesas SoCs
> * Remove no longer needed ARCH_SHMOBILE Kconfig symbol

The ARCH_SHMOBILE removal and cleanup is fine, but I wonder about
the newly added symbols for specific SoCs. I see you already have a
couple of those, but the other manufacturers don't.

I think what happened here is that I tried to reject those additions
normally, but I never noticed yours. From what I see in drivers,
you have additional symbols depending on these in clk, pinctrl,
drivers/soc, and the dtb files, so at the very least we can't
just drop the config options, but I'd still like to see this work
more like other platforms.

Any ideas what we can do here?

      Arnd
