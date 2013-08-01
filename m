From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 1 Aug 2013 16:32:23 +0800
Subject: [PATCH 1/2] pinctrl: imx: work around select input quirk
In-Reply-To: <CAAQ0ZWQajP49jM_0wqvqmuv19ZcSQ_1QUzgxfsBYzKU_5w0bMA@mail.gmail.com>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
 <20130801065147.GM8540@nchen-desktop>
 <CAAQ0ZWQajP49jM_0wqvqmuv19ZcSQ_1QUzgxfsBYzKU_5w0bMA@mail.gmail.com>
Message-ID: <20130801083221.GA32696@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 03:08:06PM +0800, Shawn Guo wrote:
> On 1 August 2013 14:51, Peter Chen <peter.chen@freescale.com> wrote:
> > Shawn, input_reg[i] may be 0 if the fixed one at first register of IOMUXC
> 
> Ah, yes.  Now select input register at offset 0 becomes possible.  I
> will try to fix it.
> 
> Regardless of this, does the series work for you?
> 
Yes, it works, you can add : Tested-by: Peter Chen <peter.chen@freescale.com>

I changed the second patch manually, have you changed the pin prefix
at arch/arm/boot/dts/imx6q-pinfunc.h?  At 3.10, it is MX6Q_XXX.

Besides, please add comments for u16 *input_reg at struct imx_pin_group.

-- 

Best Regards,
Peter Chen
