From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 19:05:24 +0200
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <5507947.WEhmSUi7vd@amdc1227>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <20130405163958.GP17363@zurbaran> <5507947.WEhmSUi7vd@amdc1227>
Message-ID: <201304051905.24644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Tomasz Figa wrote:
> On Friday 05 of April 2013 18:39:58 Samuel Ortiz wrote:
> > Hi Tomasz,
> > 
> > On Thu, Apr 04, 2013 at 06:37:01PM +0200, Tomasz Figa wrote:
> > > This patch adds master driver for PWM/timer block available on many
> > > Samsung SoCs providing clocksource and PWM output capabilities.
>
> > Why is that an MFD driver, and why aren't you using the PWM APIs for it ?
> > Also, you probably want to look at using the regmap APIs for your IO.
> 
> The case of Samsung PWM timers is rather complicated. It is a hardware block 
> that can be used at the same time to generate PWM signal and as a system 
> clocksource.
> 
> There was a discussion on how to solve the problem of sharing the hardware:
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16480/focus=16500
> (see the linked post and replies to it).
> 

I don't think anyone ever suggested using a private API though. I think
it's ok if the driver lives in drivers/mfd when it doesn't fit anywhere
else easily, but you should really register it to the pwm subsystem to
expose that functionality, not export functions that can be used by
a pwm shim driver, which even seems to be missing from the series.

	Arnd
