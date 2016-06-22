From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 22 Jun 2016 09:26:04 -0400
Subject: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
In-Reply-To: <20160622123222.GD26943@ulmo.ba.sec>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <20160622123222.GD26943@ulmo.ba.sec>
Message-ID: <1466601964.5316.19.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Wed, 2016-06-22 at 14:32 +0200, Thierry Reding wrote:
> On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> > disable the PWM, the PWM output is always set as a logic 1.
> 
> I presume there's a reason why the bootloader set this bit to 1. Why do
> you assume it's the right thing to clear it?
> 
There is an alternative mode for the PWM output pin; using the 
PWM_PIN_LEVEL bit to control the PWM output (logical 0 or 1 on 
output) when the PWM is disable.

In this case, the bootloader is using the PWM_PIN_LEVEL bit
to control the PWM output (always 1) to enable the LCD; the 
application is using the PWM to control the intensity of the 
LCD output. When disabling the PWM, the line level should be 
setup to 0.

A version 2 of this patch will be send with support to select 
the alternate PWM disable level high from the device tree.

For details, you can refer to:
http://thread.gmane.org/gmane.linux.pwm/3882/focus=508758


Sylvain

> Thierry
