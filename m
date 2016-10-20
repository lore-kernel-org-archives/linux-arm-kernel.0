From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 20 Oct 2016 12:56:50 +0100
Subject: [PATCH] pinctrl: st: don't specify default interrupt trigger
In-Reply-To: <729ebc94-5476-65a7-cc17-eabfba0d2404@st.com>
References: <1476774988-13484-1-git-send-email-patrice.chotard@st.com>
 <729ebc94-5476-65a7-cc17-eabfba0d2404@st.com>
Message-ID: <20161020115650.GA8848@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

On Thu, 20 Oct 2016, Patrice Chotard wrote:

> 
> 
> On 10/18/2016 09:16 AM, patrice.chotard at st.com wrote:
> > From: Patrice Chotard <patrice.chotard@st.com>
> > 
> > Thanks to 332e99d5ae4 which now alerts of default
> > trigger usage when configuring interrupts.
> > 
> > Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> > ---
> >  drivers/pinctrl/pinctrl-st.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> > index 99da4cf..b7bb371 100644
> > --- a/drivers/pinctrl/pinctrl-st.c
> > +++ b/drivers/pinctrl/pinctrl-st.c
> > @@ -1512,7 +1512,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
> >  	if (info->irqmux_base || gpio_irq > 0) {
> >  		err = gpiochip_irqchip_add(&bank->gpio_chip, &st_gpio_irqchip,
> >  					   0, handle_simple_irq,
> > -					   IRQ_TYPE_LEVEL_LOW);
> > +					   IRQ_TYPE_NONE);
> >  		if (err) {
> >  			gpiochip_remove(&bank->gpio_chip);
> >  			dev_info(dev, "could not add irqchip\n");
> > 
> 
> Hi Linus
> 
> I forgot to mention that this patch is dedicated for v4.9-rcs 

Wow, v4.9-rc is a noisy boot without this patch :)

Acked-by: Peter Griffin <peter.griffin@linaro.org>
