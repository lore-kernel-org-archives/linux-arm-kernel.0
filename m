From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 6 Jan 2015 17:16:57 +0800
Subject: [PATCH v4 4/5] ARM: mediatek: Add EINT support to MTK pinctrl
 driver.
In-Reply-To: <1418807365.6443.17.camel@mtksdaap41>
References: <1418772873-19747-1-git-send-email-hongzhou.yang@mediatek.com>
 <1418772873-19747-5-git-send-email-hongzhou.yang@mediatek.com>
 <1418807365.6443.17.camel@mtksdaap41>
Message-ID: <1420535817.17567.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-17 at 17:09 +0800, Yingjoe Chen wrote:
> On Wed, 2014-12-17 at 07:34 +0800, Hongzhou Yang wrote:
> > From: Maoguang Meng <maoguang.meng@mediatek.com>
> > 
> > MTK SoC support external interrupt(EINT) from most SoC pins.
> > Add EINT support to pinctrl driver.
> > 
> > Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> Hi Linus,
> 
> This patch add EINT support to the pinctrl driver. We've surveyed
> GPIOLIB_IRQCHIP, but we didn't use it because:
> 
> - Not every GPIO pin support interrupt.
> - EINT use a different numbering to GPIO. eg, from the mt8135 table,
> GPIO29 is EINT158. It is more nature & efficient to use EINT number as
> hwirq.
> 
> +               MTK_EINT_FUNCTION(2, 158),
> +               MTK_FUNCTION(0, "GPIO29"),


Hi Linus,

After further looking into this, we could use GPIOLIB_IRQCHIP if we add
an extension gpiochip_irqchip_add() to accept interrupt numbers and
custom .to_irq function for our SoC. We could still reuse other code
GPIOLIB_IRQCHIP provide.

Please let me know what you think about this idea.
Thanks.

Joe.C
