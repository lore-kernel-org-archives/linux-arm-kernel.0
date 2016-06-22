From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 22 Jun 2016 16:36:50 +0200
Subject: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
In-Reply-To: <1466601964.5316.19.camel@localhost>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <20160622123222.GD26943@ulmo.ba.sec>
 <1466601964.5316.19.camel@localhost>
Message-ID: <20160622143650.GO26943@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 09:26:04AM -0400, Sylvain Lemieux wrote:
> Hi Thierry,
> 
> On Wed, 2016-06-22 at 14:32 +0200, Thierry Reding wrote:
> > On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
> > > From: Sylvain Lemieux <slemieux@tycoint.com>
> > > 
> > > If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> > > disable the PWM, the PWM output is always set as a logic 1.
> > 
> > I presume there's a reason why the bootloader set this bit to 1. Why do
> > you assume it's the right thing to clear it?
> > 
> There is an alternative mode for the PWM output pin; using the 
> PWM_PIN_LEVEL bit to control the PWM output (logical 0 or 1 on 
> output) when the PWM is disable.
> 
> In this case, the bootloader is using the PWM_PIN_LEVEL bit
> to control the PWM output (always 1) to enable the LCD; the 
> application is using the PWM to control the intensity of the 
> LCD output. When disabling the PWM, the line level should be 
> setup to 0.

But doesn't that mean that if the pin is used in PWM mode there's never
a use-case for having it go high when disabled? Given that this is a PWM
driver I don't see how we'd ever be in the case where the alternate
setting makes sense.

> A version 2 of this patch will be send with support to select 
> the alternate PWM disable level high from the device tree.
> 
> For details, you can refer to:
> http://thread.gmane.org/gmane.linux.pwm/3882/focus=508758

Given the above I don't think we should add this new device tree
property until we encounter a setup where it's needed.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/de943625/attachment.sig>
