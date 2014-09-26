From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 22:51:49 +0800
Subject: [PATCH v3 4/5] ARM: dts: vf610: use new GPIO support
In-Reply-To: <f3bba83ea15d680c852eb7d6e45de08a@agner.ch>
References: <cover.1411662961.git.stefan@agner.ch>
 <590a5fbc4f8b552355a93c1002041765352cd1c3.1411662961.git.stefan@agner.ch>
 <20140926012126.GC21077@dragon>
 <f3bba83ea15d680c852eb7d6e45de08a@agner.ch>
Message-ID: <20140926145147.GA5737@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 09:40:34AM +0200, Stefan Agner wrote:
> This GPIO's are meant to be used from user space by default. The latest
> implementation of imx_pmx_gpio_request_enable not only takes care of the
> muxing, but also applies the whole pad settings. Hence we do not need
> the pinctrl subsystem to apply it (through pinctrl-* dt properties).
> 
> I changed this now in v3, in v2 I had still to use the pinctrl-*
> properties. I like that 3rd version much more, this way the pin only
> really gets muxed when the user uses it (e.g. we save power because the
> pad is disabled when the GPIO is not in use). If the pin needs to be in
> a defined state, then we would have to explicitly configure/enable it
> through a pinctrl-* properties, but this is not the case for these
> external GPIO's.

Ah, yes, you're right.  I was still thinking about the way how it worked
before your patch.

Patch applied, thanks.
