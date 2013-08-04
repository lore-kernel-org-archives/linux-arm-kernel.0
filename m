From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Aug 2013 20:54:54 +0800
Subject: [PATCH 1/2] pinctrl: imx: work around select input quirk
In-Reply-To: <20130801083221.GA32696@nchen-desktop>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
 <20130801065147.GM8540@nchen-desktop>
 <CAAQ0ZWQajP49jM_0wqvqmuv19ZcSQ_1QUzgxfsBYzKU_5w0bMA@mail.gmail.com>
 <20130801083221.GA32696@nchen-desktop>
Message-ID: <20130804125452.GF18119@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 04:32:23PM +0800, Peter Chen wrote:
> On Thu, Aug 01, 2013 at 03:08:06PM +0800, Shawn Guo wrote:
> > On 1 August 2013 14:51, Peter Chen <peter.chen@freescale.com> wrote:
> > > Shawn, input_reg[i] may be 0 if the fixed one at first register of IOMUXC
> > 
> > Ah, yes.  Now select input register at offset 0 becomes possible.  I
> > will try to fix it.
> > 
> > Regardless of this, does the series work for you?
> > 
> Yes, it works, you can add : Tested-by: Peter Chen <peter.chen@freescale.com>

Thanks.

> 
> I changed the second patch manually, have you changed the pin prefix
> at arch/arm/boot/dts/imx6q-pinfunc.h?  At 3.10, it is MX6Q_XXX.

Yes, we changed the prefix to simplify the DTS files for imx6q and
imx6dl.

> 
> Besides, please add comments for u16 *input_reg at struct imx_pin_group.

I'm not fond of documenting a workaround for a random quirky select
input as a feature all over the files where input_reg is documented.
It should be good enough to have it well documented at where the quirk
is handled.

Shawn
