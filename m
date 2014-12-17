From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 17 Dec 2014 17:09:25 +0800
Subject: [PATCH v4 4/5] ARM: mediatek: Add EINT support to MTK pinctrl
 driver.
In-Reply-To: <1418772873-19747-5-git-send-email-hongzhou.yang@mediatek.com>
References: <1418772873-19747-1-git-send-email-hongzhou.yang@mediatek.com>
 <1418772873-19747-5-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1418807365.6443.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-17 at 07:34 +0800, Hongzhou Yang wrote:
> From: Maoguang Meng <maoguang.meng@mediatek.com>
> 
> MTK SoC support external interrupt(EINT) from most SoC pins.
> Add EINT support to pinctrl driver.
> 
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Hi Linus,

This patch add EINT support to the pinctrl driver. We've surveyed
GPIOLIB_IRQCHIP, but we didn't use it because:

- Not every GPIO pin support interrupt.
- EINT use a different numbering to GPIO. eg, from the mt8135 table,
GPIO29 is EINT158. It is more nature & efficient to use EINT number as
hwirq.

+               MTK_EINT_FUNCTION(2, 158),
+               MTK_FUNCTION(0, "GPIO29"),

Joe.C
