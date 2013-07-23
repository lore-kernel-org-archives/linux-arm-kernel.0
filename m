From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Jul 2013 08:30:16 -0700
Subject: [PATCH v4 00/20] Samsung PWM support cleanup
In-Reply-To: <2036745.TWe3OlGh9t@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <9102768.ef8LAvpunv@flatron> <0ac901ce867f$638a7530$2a9f5f90$@org>
 <2036745.TWe3OlGh9t@flatron>
Message-ID: <20130723153015.GA2066@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 09:49:49AM +0200, Tomasz Figa wrote:
> On Monday 22 of July 2013 11:01:32 Kukjin Kim wrote:
> > Kukjin Kim wrote:
> > > Tomasz Figa wrote:
> > > > On Monday 22 of July 2013 00:22:16 Sylwester Nawrocki wrote:
> > > > > On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> > > > > > Since we now have a proper Samsung PWM clocksource driver in
> > > > > > place,
> > > > > > we can proceed with further cleanup of PWM timers support on
> > > > > > Samsung
> > > > > > SoCs.>
> > > > > > 
> > > > > > This series attempts to achieve this goal by:
> > > > > >   1) fixing up few things in samsung_pwm_timer clocksource
> > > > > >   driver,
> > > > > >   2) moving remaining Samsung platforms to the new clocksource
> > > 
> > > driver,
> > > 
> > > > > >   3) removing old clocksource driver,
> > > > > >   4) adding new multiplatform- and DT-aware PWM driver,
> > > > > >   5) moving all Samsung platforms to use the new PWM driver,
> > > > > >   6) removing old PWM driver,
> > > > > >   7) removing all PWM-related code that is not used anymore.
> > > > > > 
> > > > > > Cleaning up the PWM driver is a bit tricky, because the design
> > > > > > of
> > > > > > current driver makes it completely unsuitable for DT and
> > > > > > multiplatform and would require a heavy rework to make it
> > > > > > usable,
> > > > > > breaking any existing Samsung PWM users by the way. To avoid any
> > > > > > breakage this series first renames the old driver, then adds new
> > > > > > one
> > > > > > using original name, migrates all platforms to use it and then
> > > > > > finally removes the old driver.
> > > > > > 
> > > > > > See particular patches for more detailed descriptions.
> > > > > > 
> > > > > > [On S3C6410-based Tiny6410 (Mini6410-compatible) with
> > > > > > pwm-beeper,
> > > > > > SMDK6410 with PWM backlight and Exynos4210-based Origen board
> > > > > > (with
> > > > > > PWM0 attached to a scope)]
> > > > > > Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> > > > > > 
> > > > > > [On S3C2440-based Mini2440 board]
> > > > > > Tested-by: Sylwester Nawrocki<sylvester.nawrocki@gmail.com>
> > > > > 
> > > > > I have retested this series on top of v3.11-rc1 with pwm-backlight
> > > 
> > > (and
> > > 
> > > > > buzzer
> > > > > as the output :)) on Mini2440. It seems to work well - generated
> > > > > frequencies are correct. I'll check pulse widths with a scope
> > 
> > tomorrow,
> > 
> > > > > as it's a bit late
> > > > > now. FWIW you can add to this series my:
> > > > > 
> > > > > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > > 
> > > > Thanks. I hope we can finally get this series merged soon.
> > > 
> > > Yes, this whole patches look good to me, and I'd like to take this
> > > whole patches into the samsung tree...but need to get any response
> > > from PWM guy, Thierry Reding. Let's wait for his response...
> > 
> > To be clarify, because his ack was on v3 and I remember he had a
> > comment. So would be better if we could get his ack on pwm change
> > again.
> 
> Sure.

Patches 12, 13 and 16:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/6a086acb/attachment.sig>
