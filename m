From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Jan 2014 16:23:56 +0100
Subject: [PATCH v2] pwm: add CSR SiRFSoC PWM driver
In-Reply-To: <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
References: <1391061145-2078-1-git-send-email-21cnbao@gmail.com>
 <201401302049.27521.arnd@arndb.de>
 <CAGsJ_4xFKytv=Mj9eVwGY7RjyUy2W=iSXvnULKyBETYVzMVbOg@mail.gmail.com>
Message-ID: <201401311623.56902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014, Barry Song wrote:
> >
> > Is SRC_OSC_RATE the rate of spwm->clk? If so, it would be nice to just call
> > clk_get_rate() here, in case you ever have a chip with a different rate.
> >
> 
> SRC_OSC_RATE is the fixed frequency of crystal oscillator, but
> spwm->clk comes from the IO bus. the design is a little strange, pwm
> channels don't use the clock of PWM controller to generate
> period/duty, but use other sources.

How about modeling  that other source as a fixed-rate clock in DT
then?

	Arnd
