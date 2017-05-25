From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 15:19:42 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <486f703b-fc8a-ccc1-134d-a908df798b2e@cogentembedded.com>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
 <a74ee28c1c62fee5a5e75dda70a02990@agner.ch>
 <076f6258-f0b4-6ba5-9670-e2c0582a92b5@cogentembedded.com>
 <20170522182119.GN29447@lunn.ch>
 <486f703b-fc8a-ccc1-134d-a908df798b2e@cogentembedded.com>
Message-ID: <20170525071940.GV26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 09:02:27AM +0300, Nikita Yushchenko wrote:
> >> However, hi8435 driver historically was coded using inverted values
> >> passed to gpiolib calls.  And there are setups in the wild with device
> >> trees containing GPIO_ACTIVE_HIGH that I'd prefer not breaking.
> >>
> >> To solve, I submitted a patch on hi8435 driver that changes to _raw()
> >> gpio calls (thus making it independent of what is written in device
> >> tree), and want [future] device trees not to contain explicitly written
> >> gpio polarity.
> > 
> > So maybe add another #define, GPIO_ACTIVE_IGNORED, to make it clear
> > that it does not matter what value you put there, it is ignored.
> 
> "Crap origin" here is that in vast majority of cases, polarity is
> per-chip, not per-chip-use, knowledge. And proper location for per-chip
> knowledge is chip's driver.  Moving this knowledge to per-chip-use
> location in device trees only provides a source for errors, with little
> gain.
> 
> Vladimir Barinov mentions possibility that signal can be inverted by
> board between gpio provider and chip's pin ...   but do we have at least
> one practical case of this?  And if we even do, it's quite uncommon, and
> something special should be required in device tree for these special
> cases and not for "normal" cases.

I disagree.  Not for hi8435, but I have seen quite some board designs
invert GPIOs before getting them into board level components.  That's
why we should define those xxx-gpios properties on board level DTS,
where polarity can be chosen per board design.

Shawn
