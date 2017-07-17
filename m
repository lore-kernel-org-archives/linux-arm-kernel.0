From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Jul 2017 15:08:54 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: hsmmc.c: Remove dead code
In-Reply-To: <1500036404-5556-2-git-send-email-faiz_abbas@ti.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
 <1500036404-5556-2-git-send-email-faiz_abbas@ti.com>
Message-ID: <CAPDyKFpwb3T4PhQSyUwWDwpEnOwVDxLeK7hAMS0Q4P3tzPXXrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2017 at 14:46, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Most platforms using OMAP hsmmc driver have switched to device tree
> for passing platform data to omap_hsmmc.c driver.
>
> The hsmmc.c file in mach-omap2 exists only to support pandora board
> which uses wl1251 driver in legacy platform data mode.
>
> Hence, remove the dead code not used by the pandora board.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

I just got an ack from Tony to pick this up. So I did that (including
the mmc change in patch 2) and intend to send this for 4.13 rcs, via
my fixes branch in my mmc tree.

However the below comment for testing puzzles me. Either it's dead
code or not, so then what is there to test? :-)

Anyway, it's available on my fixes and next branch, so let's see if
zero build reports some issues.

> ---
> This is only compile tested. Someone with a pandora board should help
> test this for functionality.
>
>  arch/arm/mach-omap2/hsmmc.c | 239 +-------------------------------------------
>  arch/arm/mach-omap2/hsmmc.h |   9 --
>  2 files changed, 2 insertions(+), 246 deletions(-)

[...]

Kind regards
Uffe
