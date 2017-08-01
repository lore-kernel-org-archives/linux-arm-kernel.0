From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 1 Aug 2017 13:48:34 +0000
Subject: [PATCH RESEND 2/2] gpio: gpio-vf610: add imx7ulp support
In-Reply-To: <CACRpkdYjkaEzuqvtryCwfAWPHhsP3wD8_U3M7kaO7cbCmj5rZg@mail.gmail.com>
References: <1500990438-3894-1-git-send-email-aisheng.dong@nxp.com>
 <1500990438-3894-3-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdYjkaEzuqvtryCwfAWPHhsP3wD8_U3M7kaO7cbCmj5rZg@mail.gmail.com>
Message-ID: <AM3PR04MB306474118389D928F28360E80B30@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Tuesday, August 01, 2017 8:04 PM
> To: A.s. Dong
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Shawn Guo; Stefan Agner; Jacky Bai; Andy Duan; Peter Chen; Dong Aisheng;
> Sascha Hauer; Alexandre Courbot
> Subject: Re: [PATCH RESEND 2/2] gpio: gpio-vf610: add imx7ulp support
> 
> On Tue, Jul 25, 2017 at 3:47 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> 
> > The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P) on
> > MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the RGPIO2P
> > has an extra Port Data Direction Register (PDDR) used to configure the
> > individual port pins for input or output.
> >
> > We introduce a FSL_GPIO_HAVE_PDDR with fsl_gpio_soc_data data to
> > distinguish this differences. And we support getting the output status
> > by checking the GPIO direction in PDDR.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Fugang Duan <fugang.duan@nxp.com>
> > Cc: Peter Chen <peter.chen@nxp.com>
> > Acked-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> This is mostly OK but I want a change.
> 
> > +struct fsl_gpio_soc_data {
> > +       u32 flags;
> > +};
> 
> Why introduce complex things like bitwise flags. That looks like premature
> optimization and trying to outsmart the compiler, don't do that.
> 

It's for conveniently adding new flags in the future.
But it's true that it may be premature optimization.

> Add a bool have_paddr;
> 
> simply, and use that in the code.
> 

Will do it.
Thanks for the advice.

Regards
Dong Aisheng

> Apart from that it is fine.
> 
> Yours,
> Linus Walleij
