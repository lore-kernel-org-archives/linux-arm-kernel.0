From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 31 Jul 2015 11:14:01 +0800
Subject: [PATCH v2 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT
 when setup
In-Reply-To: <1437552878-3684-1-git-send-email-yingjoe.chen@mediatek.com>
References: <CAGS+omD8k_Cfxv3bYyjmjtLbiavo-WmJPn0Z-CBhN_nnv65Tag@mail.gmail.com>
 <1437552878-3684-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1438312441.26889.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-07-22 at 16:14 +0800, Yingjoe Chen wrote:
> Spurious mtk timer interrupt is noticed at boot and cause kernel
> crash. It seems if GPT is enabled, it will latch irq status even
> when its IRQ is disabled. When irq is enabled afterward, we see
> spurious interrupt.
> Change init flow to only enable GPT_CLK_SRC at mtk_timer_init.
> 
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
> Update to my patch [1], added __init as Daniel suggest. This is the
> only patch that need to change in that series, so I only sent this one.
> 
> http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001545.html


Hi Daniel, Thomas,

Any suggestions for mtk_timer fixes in this series?
Should I resend and add tags from the reviewers?

Joe.C
