From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 10:38:29 +0000
Subject: [PATCH 12/24] ARM: PXA: update clock source registration
In-Reply-To: <AANLkTi=tdaVXTk+0H1_w3kvsfVBi6P7H5STS9NhSU7cC@mail.gmail.com>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDvL-0008D4-Oi@rmk-PC.arm.linux.org.uk>
	<AANLkTi=tdaVXTk+0H1_w3kvsfVBi6P7H5STS9NhSU7cC@mail.gmail.com>
Message-ID: <20101216103829.GN9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 11:09:21AM +0800, Eric Miao wrote:
> On Tue, Dec 14, 2010 at 3:19 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> > interfaces were added which simplify (and optimize) the selection of the
> > divisor shift/mult constants. ?Switch over to using this new interface.
> >
> 
> Russell,
> 
> This has been already addressed in Haojian's previous patch posted and
> merged in my tree:
> 
> http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commitdiff;h=ee5ed917c3c412e0e13d1c198b5f09f82c03eea4
> 
> I'll send the pull request out early today to sort this out.

That's not quite the same.  clocksource_calc_mult_shift() was introduced
in November 2009, whereas clocksource_register_hz() was introduced in
May 2010.  I'm updating everything to the latest interface.

The newer interface removes the burden of having to figure out what to
pass as the 'minsec' parameter, as well as simplifying the clocksource
registration code down to one line.
