From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 23 Mar 2011 00:57:30 +0900
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
Message-ID: <20110322155730.GD30303@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 12:43:54AM +0900, Magnus Damm wrote:
> On Wed, Mar 23, 2011 at 12:32 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, Mar 23, 2011 at 12:22:05AM +0900, Magnus Damm wrote:
> >> I believe all other i2c keyboard drivers use module_init().
> >>
> > We do not change initcall ordering around unless there is a reason to do
> > so, as it's assumed that a given initcall has been chosen for a reason.
> 
> Yes, obviously this driver is special and all other keypad drivers are wrong.
> 
I'm not sure why you're purposely trying to be dense. I was explaining
why it's not uncommon to find drivers using subsys_initcall for various
non-obvious reasons and why blindly changing them without valid rationale
generally causes more trouble than it prevents. In the case of a keypad
driver it's unlikely to matter, but someone may still have had a reason
for doing so. Given that your patch is fixing a problem, this is what
should be reflected in your commit text, not some vague hand-waving about
what everyone else is doing or what could hypothetically lead to
problems.

> It would be interesting to hear why subsys_initcall() was put there in
> the first place.
> 
In this case I would suspect general indifference or simply copying other
drivers. I2C is a bit of a tricky case with regards to ordering in
general, but at least input devices are relatively straightforward.

> The keypad driver tries to use the I2C bus before the I2C bus driver
> is initialized. Isn't that a pretty good reason to change the initcall
> order?
> 
Yes, and that part is also not mentioned anywhere in your commit text.
Starting to see a pattern?

> > You had a reason, great. Next time put it in your commit text.
> 
> Whatever. Let me know which lines you'd like to add and I'll send a V2.
> 
I don't think it's too much to ask that you write a commit text that
actually mentions what problem you are experiencing and fixing. I also
don't know why this needs to be pointed out. One shouldn't have to work
for an explanation of what purpose your patch serves when you're the one
trying to get it merged.
