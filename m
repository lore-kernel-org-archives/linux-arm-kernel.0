From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Jul 2013 15:44:01 -0400
Subject: gpio_blink_set + Kirkwood
In-Reply-To: <51DEFED8.4050402@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <1a9bcb9094ae695c6707c4835417dd5b@harsszegi.com>
 <20130710073706.GA28212@lunn.ch> <51DEDB32.4080101@harsszegi.com>
 <20130711164456.GA3095@lunn.ch> <51DEFA4A.6010303@harsszegi.com>
 <20130711183737.GX11908@titan.lakedaemon.net>
 <51DEFED8.4050402@harsszegi.com>
Message-ID: <20130711194401.GY11908@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 08:52:08PM +0200, Tibor Harsszegi wrote:
> On 2013-07-11 20:37, Jason Cooper wrote:
> >On Thu, Jul 11, 2013 at 08:32:42PM +0200, Tibor Harsszegi wrote:
> >>>On Thu, Jul 11, 2013 at 06:20:02PM +0200, Tibor Harsszegi wrote:
> >>>>Hello guys,
> >>>>
> >>>>can anyone explain me how does the gpio_blink_set member gets filled
> >>>>in leds-gpio through platform_get_drvdata()?
> >>>>I can't seem to follow how the specific function pointer can be set
> >>>>to orion_gpio_set_blink() for example.
> >>>>Sorry for the dumb question :(
> >>>Hi Tibor
> >>>
> >>>For DT based board, hardware blinking is not supported, as far as i
> >>>remember.
> >>>
> >>>	Andrew
> >>Hello Andrew,
> >>
> >>is there an example for "mixed machine setup" (if there is anything
> >>like that) ?
> >>I'm thinking about:
> >>
> >>* DT based initialization starts
> >>* then if supported board based "after-DT-init-board-code" executes
> >>
> >>similar what we have in board-*.c files just that it would be
> >>executed after kirkwood has initialized the board
> >>based upon the .DTB
> >>[I'm thinking about getting rid of the LED setup from the .DTB and
> >>move it back to .C land - at least for a trial]
> >As a testing hack, just add the following to board-dt.c:
> >
> >	if (of_machine_is_compatible("keymile,whizbang-board")) {
> >		/* GPIO hackery here */
> >	}
> >
> >hth,
> >
> >Jason.
> Ok, but isn't board-dt.c is the very first thing (kinda) which is
> executed prior the .DTB is parsed
> and executed?
> E.g. if I add the GPIO hack there, I assume that kirkwood and orion
> is already initialized.
> Or is the board-dt.c executed after the .DTB is loaded/parsed?

The last line parses the dtb.  Perhaps late_initcall()?

hth,

Jason.
