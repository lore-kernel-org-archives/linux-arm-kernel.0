From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 8 Sep 2011 23:47:16 +0530
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 11:04 PM, Mans Rullgard <mans.rullgard@linaro.org> wrote:
> This converts the per-board modules to platform drivers for a
> device created by in main platform setup. ?These drivers call
> snd_soc_register_card() directly instead of going via a "soc-audio"
> device and the corresponding driver in soc-core.
>
> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
> ---
> Platform device names fixed.
> N8x0 changed to get clocks before registering card.
> ---
> ?arch/arm/mach-omap2/board-3430sdp.c ? ? ? ? ?| ? ?6 ++
> ?arch/arm/mach-omap2/board-4430sdp.c ? ? ? ? ?| ? ?6 ++
> ?arch/arm/mach-omap2/board-am3517evm.c ? ? ? ?| ? ?7 +++
> ?arch/arm/mach-omap2/board-devkit8000.c ? ? ? | ? ?6 ++
> ?arch/arm/mach-omap2/board-igep0020.c ? ? ? ? | ? ?6 ++
> ?arch/arm/mach-omap2/board-n8x0.c ? ? ? ? ? ? | ? ?6 ++
> ?arch/arm/mach-omap2/board-omap3beagle.c ? ? ?| ? ?6 ++
> ?arch/arm/mach-omap2/board-omap3evm.c ? ? ? ? | ? ?7 +++
> ?arch/arm/mach-omap2/board-omap3pandora.c ? ? | ? ?6 ++
> ?arch/arm/mach-omap2/board-overo.c ? ? ? ? ? ?| ? 17 ++++++
> ?arch/arm/mach-omap2/board-rx51.c ? ? ? ? ? ? | ? ?6 ++
> ?arch/arm/mach-omap2/board-zoom-peripherals.c | ? ?6 ++

Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
generate a platform device of name depending upon machine_is_* ?
