From: ccross@android.com (Colin Cross)
Date: Sat, 12 Feb 2011 00:52:14 -0800
Subject: [PATCH v4 00/22] Updates for Tegra support in 2.6.39
In-Reply-To: <1297320204-31882-1-git-send-email-ccross@android.com>
References: <1297320204-31882-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTin1UOAwBuGC0vaDutCrWY2x1+qK9=b50k43a2K0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 9, 2011 at 10:43 PM, Colin Cross <ccross@android.com> wrote:
> This is a repost of the same series with the suspend and
> idle support dropped for now while the necessary changes
> to the gic, l2x0, and init notifiers are discussed. ?If
> there are no further comments, I will push these to
> tegra/for-next.
>
> ?arch/arm/configs/tegra_defconfig ? ? ? ? ? ? ? | ?123 +++++++++++
> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-tegra/board.h ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> ?arch/arm/mach-tegra/common.c ? ? ? ? ? ? ? ? ? | ? 17 ++-
> ?arch/arm/mach-tegra/cpu-tegra.c ? ? ? ? ? ? ? ?| ? 75 ++++++--
> ?arch/arm/mach-tegra/dma.c ? ? ? ? ? ? ? ? ? ? ?| ?198 ++++++++++--------
> ?arch/arm/mach-tegra/gpio.c ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-tegra/include/mach/debug-macro.S | ? 25 +--
> ?arch/arm/mach-tegra/include/mach/iomap.h ? ? ? | ? 69 +++++-
> ?arch/arm/mach-tegra/include/mach/irqs.h ? ? ? ?| ? 14 +-
> ?arch/arm/mach-tegra/include/mach/legacy_irq.h ?| ? ?4 +
> ?arch/arm/mach-tegra/include/mach/pinmux-t2.h ? | ? 10 +
> ?arch/arm/mach-tegra/include/mach/powergate.h ? | ? 40 ++++
> ?arch/arm/mach-tegra/include/mach/suspend.h ? ? | ? 38 ++++
> ?arch/arm/mach-tegra/include/mach/system.h ? ? ?| ? 10 +-
> ?arch/arm/mach-tegra/include/mach/uncompress.h ?| ? 18 +--
> ?arch/arm/mach-tegra/irq.c ? ? ? ? ? ? ? ? ? ? ?| ?186 ++++++++---------
> ?arch/arm/mach-tegra/legacy_irq.c ? ? ? ? ? ? ? | ?109 ++++++++++-
> ?arch/arm/mach-tegra/pinmux-t2-tables.c ? ? ? ? | ? 26 ++-
> ?arch/arm/mach-tegra/powergate.c ? ? ? ? ? ? ? ?| ?212 +++++++++++++++++++
> ?arch/arm/mach-tegra/tegra2_clocks.c ? ? ? ? ? ?| ?264 ++++++++++++++++++++++--
> ?arch/arm/mach-tegra/timer.c ? ? ? ? ? ? ? ? ? ?| ? 61 ++++++-
> ?22 files changed, 1212 insertions(+), 291 deletions(-)
>

I pushed this patch set to tegra/for-next, with minor fixups from
Stephen Warren.
