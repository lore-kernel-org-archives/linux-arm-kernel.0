From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 16 Jun 2013 12:45:29 +0200
Subject: [PATCH 1/5] pinctrl: update the documentation for some pinconfig
 params
In-Reply-To: <CACRpkdaV78wXxGPFWVffEfnqrmhq1rsdVYdSKNx5mWaOcYOWrQ@mail.gmail.com>
References: <201306141741.46077.heiko@sntech.de>
 <201306141742.21808.heiko@sntech.de>
 <CACRpkdaV78wXxGPFWVffEfnqrmhq1rsdVYdSKNx5mWaOcYOWrQ@mail.gmail.com>
Message-ID: <201306161245.30465.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 16. Juni 2013, 12:26:38 schrieb Linus Walleij:
> On Fri, Jun 14, 2013 at 5:42 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > The BIAS_DISABLE and BIAS_HIGH_IMPEDANCE generic pinconfig options were
> > missing information about their argument - which should be ignored.
> > 
> > Also the BIAS_PULL_* options may have the pull strength as argument
> > when they are activated, while simpler hardware can use any
> > non-0 value for it.
> > 
> > Update the kerneldoc to reflect this.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> I'm holding this patch off.
> 
> >   * @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with
> >   high
> > 
> > - *     impedance to VDD). If the argument is != 0 pull-up is enabled,
> > - *     if it is 0, pull-up is disabled.
> > + *     impedance to VDD). If the argument is != 0 pull-up is enabled. On
> > + *     hardware supporting this, the argument should contain the
> > strength of + *     the pull in Ohm. If it is 0, pull-up is disabled.
> 
> As noted by Laurent, a pull-up of 0 Ohm is a short-circuit (bascially the
> TOTAL pull-up) and it is pretty counter-intuitive to have that mean
> "disable pull-up". Can we avoid this?
> 
> >   * @PIN_CONFIG_BIAS_PULL_DOWN: the pin will be pulled down (usually with
> >   high
> > 
> > - *     impedance to GROUND). If the argument is != 0 pull-down is
> > enabled, - *     if it is 0, pull-down is disabled.
> > + *     impedance to GROUND). If the argument is != 0 pull-down is
> > enabled. On + *     hardware supporting this, the argument should
> > contain the strength of + *     the pull in Ohm. If it is 0, pull-down
> > is disabled.
> 
> Dito.
> 
> >   * @PIN_CONFIG_BIAS_PULL_PIN_DEFAULT: the pin will be pulled up or down
> >   based *     on embedded knowledge of the controller, like current mux
> >   function.
> > 
> > - *     If the argument is != 0 pull up/down is enabled, if it is 0,
> > - *     the pull is disabled.
> > + *     If the argument is != 0 pull up/down is enabled. On hardware
> > supporting + *     this, the argument should contain the strength of the
> > pull in Ohm. + *     If it is 0, pull is disabled.
> 
> Dito.
> 
> Can't we rely on PIN_CONFIG_BIAS_DISABLE for all this?

you're the boss on this, I'll do whatever you say :-)

I was going after the existing documentation of "bias-pull-X = <0>" being 
there to turn off this specific bias. So when reading the existing doc I was 
assuming somebody had needed this in the past.

Actually I'm too more comfortable with only using bias-disable.

So I'll redo this patch to remove the disabling of a pull via this method, if 
that's the right way to go.

Same with the rockchip driver.


Heiko
