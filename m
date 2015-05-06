From: johan@kernel.org (Johan Hovold)
Date: Wed, 6 May 2015 14:43:54 +0200
Subject: [PATCH  0/2] gpio: Allow userspace export from DT
In-Reply-To: <20150506112449.GQ2067@n2100.arm.linux.org.uk>
References: <20150413110515.9681.58848.stgit@localhost>
 <20150504084925.GB4047@localhost>
 <20150506112449.GQ2067@n2100.arm.linux.org.uk>
Message-ID: <20150506124354.GA5302@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:24:50PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 04, 2015 at 10:49:25AM +0200, Johan Hovold wrote:
> > Firmware should describe pin directionality and function, and undefined
> > pins should never be allowed to be accessed from userspace.
> 
> No, that's totally wrong if you consider one of the most common use
> cases out there...
> 
> Think about something like a Raspberry Pi, where you have a header with
> GPIOs on it, which can be used for multiple different purposes (and are
> even multiplexed with some on-SoC functions.)
> 
> "Firmware" can't know about all possible configurations of those IO pins.
> 
> That's why Raspberry Pi uses a userspace helper and programs stuff up
> appropriately for the users application.

I'm not familiar with exactly how the RPi handles its pin muxing, but
even if it requires userspace interaction that should not prevent having
firmware describe the pins.

In general, if the hardware configuration is static we use device trees.

If the configuration is dynamic we use device-tree overlays; either
loaded manually or by some service (e.g. Beaglebone capes). Perhaps this
could be handled by the RPi helper.

And for experimentation / development, firmware could even be totally
non-restrictive by simply declaring generic pin "functions" like
"expansion-pin-4" and even allow for the direction to be changed.

Johan
