From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 11 Aug 2015 23:54:02 +0800
Subject: [PATCH 0/5] add GPT timer support for mt8173
In-Reply-To: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAGS+omAeYhXDpBueG-F_gYBccqeaejN9k5bRKC78aDLfvHfnBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 5:32 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> This series add GPT timer support for mt8173. This is based on v4.2-rc1
> and Matthias' next branch (for dts parts).
>
> The first 2 patches comes from 'Add SMP bringup support for mt65xx socs'
> series [1]. I decide to move these 2 patches to this series, since it
> is more relevent here. They are changed based on Matthias' and Daniel's
> comments.
>
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html
>
> Daniel Kurtz (1):
>   arm64: dts: mt8173: add timer node
>
> Yingjoe Chen (4):
>   clocksource: mediatek: do not enable GPT_CLK_EVT when setup
>   clocksource: mediatek: Use GPT as sched clock source
>   arm64: mediatek: enable MTK_TIMER
>   clk: mediatek: add 13mhz clock for MT8173

Was this mediatek clocksource patch set get forgotten again?
All 5 patches have have been reviewed, and I think the ones that need
it have been Ack'ed by Matthias and/or Stephen.
What is the plan for merging them?

Thanks,
-Dan

>
>  arch/arm64/Kconfig                       |  1 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |  9 +++++++++
>  drivers/clk/mediatek/clk-mt8173.c        |  5 +++++
>  drivers/clocksource/mtk_timer.c          | 26 ++++++++++++++++++++------
>  include/dt-bindings/clock/mt8173-clk.h   |  3 ++-
>  5 files changed, 37 insertions(+), 7 deletions(-)
>
