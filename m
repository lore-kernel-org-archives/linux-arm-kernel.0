From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 11 Oct 2016 11:51:32 -0400
Subject: [PATCH] ARM: dts: lpc32xx: set pwm1 & pwm2 default clock rate
In-Reply-To: <1475676679.23405.15.camel@localhost>
References: <1474916056-11336-1-git-send-email-slemieux.tyco@gmail.com>
 <1443ec62-4936-c70a-b323-6980a9240a1e@mleia.com>
 <1475676679.23405.15.camel@localhost>
Message-ID: <1476201092.7075.19.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2016-10-05 at 10:11 -0400, Sylvain Lemieux wrote:
> Hi Vladimir,
> 
> On Wed, 2016-10-05 at 05:08 +0300, Vladimir Zapolskiy wrote:
> > Hi Sylvain,
> > 
> > On 26.09.2016 21:54, Sylvain Lemieux wrote:
> > > From: Sylvain Lemieux <slemieux@tycoint.com>
> > > 
> > > Probably most of NXP LPC32xx boards have 13MHz main oscillator
> > > and therefore for HCLK PLL and ARM core clock rate default
> > > hardware setting of 16 * 13MHz = 208MHz and the AHB bus clock
> > > rate of 208MHz / 2 = 104MHz.
> > > 
> > > The change explicitly defines the peripheral PWM1/PWM2 default
> > > clock output rate of 104MHz. If needed it can be redefined
> > > in a board DTS file.
> > > 
> > > Signed-off-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> > > ---
[...]
> 
> I can submit a version 2 with the proper value and update
> the patch description to list the default peripheral clock
> setup of 13MHz.
> 
> This change is adding a default value for the PWM clock
> (setup to CLK_PERIPH) to the PWM device node, allowing the
> board specific DTS to only enable the PWM to get it work.
> 
> If the PWM clock output is not setup with a default value,
> only enabling the PWM in the board specific DTS file is not
> enough; the PWM divider will keep the default value of zero
> (i.e. PWM clock off).
> 

This patch is no longer needed;
the following patch is handle the issue:
http://www.spinics.net/lists/arm-kernel/msg535313.html

The PWM clock will match the parent clock (i.e. update at
initialization) if the PWM divider value was setup to 0
(i.e. gating functionality).

> > --
> > With best wishes,
> > Vladimir
> 
> Sylvain
> 
> 
