From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 11 Apr 2014 22:47:33 +0200
Subject: [PATCH 00/11] Fixes for omap PM for making omap3 DT only
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Message-ID: <20140411204732.GA17997@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Apr 10, 2014 at 04:47:08PM -0700, Tony Lindgren wrote:
> As we're planning to make omap3 device tree only soon, I was poking
> around and noticed that PM is not working properly. As we're planning
> to drop about 20k lines of code, I just had to try to fix this so we
> know what is going on and don't have to go back. I was pretty bummed
> out to find that we've had non-working PM code in mainline for
> really long time.
> 
> Anyways, I got the voltage scaling and N900 debug leds working, so
> with those we can notice any future regressions immediately :)

cool :)

> These are against v3.14, then you might want to also apply the
> following two patches:
> 
> [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
> https://lkml.org/lkml/2014/4/10/620
> 
> [PATCH] serial: omap: Fix missing pm_runtime_resume handling by simplifying code
> http://www.spinics.net/lists/linux-omap/msg104782.html
> 
> Note that for the actual voltage scaling to happen, the twl4030
> PMIC scripts are also needed. I have some uncleaned patches to
> load those based on the compatible flag, will post those
> separately. This series alone fixes the idle state signaling to
> the PMIC, so we can monitor sys_clkreq and sys_off_idle pins
> properly.
> 
> Please review, comment and test,

I'm on vacation from tomorrow until next week's weekend, but I will
have a look the week after next (if still needed).

I have not yet read much of TWL/OMAP PM documentation, but I wonder
if it makes sense to move the powerscripting stuff into the DTS file
somehow. On a first look the added N900 tables in
drivers/mfd/twl4030-power.c seem like a step back to me.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/b58efdb5/attachment.sig>
