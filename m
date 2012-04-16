From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 10:48:47 +0200
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 4:05 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Provide a means to collect attributes specific to ST-Ericsson's
> ux500 variant series. This patch registers itself as the AMBA
> driver to be called during the probe process. Once all
> attributes and ux500 specifics are are collected the normal
> mmci core probe is called.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?arch/arm/boot/dts/snowball.dts ? ? ? ? | ? 21 ++++++++++--
> ?arch/arm/mach-ux500/board-mop500-sdi.c | ? ?4 +-
> ?arch/arm/mach-ux500/board-mop500.c ? ? | ? ?3 +-
> ?arch/arm/mach-ux500/board-mop500.h ? ? | ? ?4 ++
> ?drivers/mmc/host/mmci.c ? ? ? ? ? ? ? ?| ? 58 +++++++++++++++++++++++++++++--
> ?5 files changed, 80 insertions(+), 10 deletions(-)

Can you split this in a clean patch to mmci.c and another patch for all
the ux500 stuff? You can add my Acked-by for both.

Obviously I cannot apply the mmci.c patch without Russell's ACK,
(or you have to take it through his patch tracker). Russell has
positively affirmed that he's looking after the MMCI driver.

If you get Russell's ACK I'll behappy to merge it through ux500
and ARM SoC.

Yours,
Linus Walleij
