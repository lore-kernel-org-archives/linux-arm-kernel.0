From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 23 Jun 2013 09:06:59 -0700
Subject: [PATCHv8 1/1] Add support for GMT G762/G763 PWM fan controllers
In-Reply-To: <20130623153931.GD7626@kw.sim.vm.gnt>
References: <87a9mkttxr.fsf@natisbad.org> <20130623153931.GD7626@kw.sim.vm.gnt>
Message-ID: <20130623160659.GB17536@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 05:39:32PM +0200, Simon Guinot wrote:
> On Thu, Jun 20, 2013 at 10:21:04PM +0200, Arnaud Ebalard wrote:
> > 
> > GMT G762/763 fan speed PWM controller is connected directly to a fan
> > and performs closed-loop or open-loop control of the fan speed. Two
> > modes - PWM or DC - are supported by the chip. Introduced driver
> > provides various knobs to control the operations of the chip (via
> > sysfs interface). Specific characteristics of the system can be passed
> > either using board init code or via DT. Documentation for both the
> > driver and DT bindings are also provided.
> > 
> > Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> > ---
> > Hi Guenter,
> > 
> > I guess we can wait for Simon's tests against its 5Big Network to check
> > everything is ok on another platform. Note that I also tested the patch
> > on my (Armada 370 based) ReadyNAS 102 and it works as expected.
> > 
> > To be very accurate, I had to revert eda6bee6c7 to get both an out of
> > tree driver for ISL 12057 chip and the g762 work *on the 102*, but this
> > is an unrelated story (Debian bug #622325 [1] has more on the topic) for
> > which I will create a separate thread. Simon, the symptom you reported
> > for your read failures are different from those I get so I don't think
> > the revert will fix your problem but it may be worth trying it.
> > 
> > [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325
> 
> Hi Arnaud and Guenter,
> 
> Actually, reverting the commit eda6bee6c7 seems to solve the -ENODEV
> issue...
> 
Did you let the i2c maintainers know ?

> Then, I have been able to test successfully the g762 driver against the
> following boards:
> 
> - 2Big NAS (open-loop mode)
> - 2Big Network v2 (open-loop mode)
> - 5Big Network v2 (closed-loop mode)
> 
> For the last, I have also been able to configure the clock frequency
> through the platform_data structure.
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> 
Thanks a lot!

Guenter
