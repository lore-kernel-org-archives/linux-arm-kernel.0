From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 29 Jan 2011 21:53:50 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D447E5E.6060007@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2011 01:21 PM, Sascha Hauer wrote:
> Hi all,
> 
> While implementing just another pwm driver I thought it's time to implement
> generic pwm support. The following series adds drivers/pwm/pwmlib.c and
> a i.MX23/28 pwm driver which serves as a usage example for pwmlib. The
> code is inspired by gpiolib support and tested using the backlight pwm
> driver by Eric Miao.
> 
> Currently the pwm_request, pwm_add, pwm_remove and pwm_free operations are
> protected with a single mutex wherea the pwm_enable, pwm_disable and
> pwm_config operations are unlocked. It is assumed that the owners of the
> pwm handle the serialization of the pwm accesses. This may not be enough, so
> i'd like to discuss the locking (and type of locking) here.
> 
> I Cced the people working with PWMs in the kernel in the hope that they can
> give input on what's missing / wrong in this implementation
> 
> Sascha
> 

Hi

There have been two other proposals for a generic PWM api during the last year.
You might want to take a look at them.

https://lkml.org/lkml/2010/2/9/275
https://lkml.org/lkml/2010/9/28/107

I've added Bill Gatliff and Arun Murthy to Cc.

- Lars
