From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 05 Oct 2016 11:07:31 -0400
Subject: [PATCH] ARM: dts: lpc32xx: add pwm-cells to base dts file
In-Reply-To: <1474979658.10588.18.camel@localhost>
References: <1474915641-11209-1-git-send-email-slemieux.tyco@gmail.com>
 <aaf0fc9c-ea2f-0081-cf58-b5024e450030@mleia.com>
 <1474979658.10588.18.camel@localhost>
Message-ID: <1475680051.23405.36.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-09-27 at 08:34 -0400, Sylvain Lemieux (gmail) wrote:
> Hi Vladimir,
> 
> On Tue, 2016-09-27 at 01:07 +0300, Vladimir Zapolskiy wrote:
> > Hi Sylvain,
> > 
> > On 26.09.2016 21:47, Sylvain Lemieux wrote:
> > > From: Sylvain Lemieux <slemieux@tycoint.com>
> > > 
> > > There is no need to define the "pwm-cells" in the board
> > > specific dts file; move the entry to the base dts file.
> > > 
> > > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > > ---
> > > Note:
> > > * This patch should be apply after
> > >   "ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2"
> > >   http://www.spinics.net/lists/arm-kernel/msg530277.html
> > >   - There is no dependency between the patches.
> > > 
> > >  arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> [...] 
> > 
> > that's something I have done locally and in a different manner, but I haven't
> > published it yet, please find below a draft.
> > 
> > First of all from multiple places in the User's Manual you can find that there
> > are "two single output PWM blocks" or "the LPC32x0 provides two 8-bit PWMs" etc.
> > 
> > In this case it does not make sense to set PWM cells to 2 (there is only one
> > channel), and 1 cell for frequency is good enough, and that's the proposed
> > change to support it:
> > 
[..]
> > 
> > What is your opinion about this proposal?
> > 
> I agree with you, this clean-up make sense; the PWM cell should be 1.
> 
> > If this change is applied, then lpc32xx.dtsi should contain #pwm-cells = <1>.
> > 
> Can you submit your change on the mailing list?
> I will send a version 2 of this patch after.
> 
> If it is helping, I can take care of submitting a patch
> to update the documentation (lpc32xx-pwm.txt).
> 
Just doing a quick follow-up; 
when do you think you can submit your change to the mailling list?

> > --
> > With best wishes,
> > Vladimir
> 
> Sylvain
> 
Regards,
Sylvain
