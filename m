From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Jan 2013 17:21:04 +0100
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <20130108161310.GD3392@lunn.ch>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
 <20130108144954.GC3392@lunn.ch>
 <20130108150907.GM1357@kw.sim.vm.gnt>
 <20130108161310.GD3392@lunn.ch>
Message-ID: <20130108172104.7238e24a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 8 Jan 2013 17:13:10 +0100, Andrew Lunn wrote:
> > I was not sure about that. As gpio_request triggers the mpp
> > configuration at run time, IMHO there is no point for an initial and
> > statical configuration, except for a documentation purpose.
> 
> [Goes away and reads Docunmentation/gpio.txt]
> 
> Yes, you appear to be correct. Its not necessary. Don't know that.

Yes, Simon is correct.

 gpio_request()
  -> gpio/gpio-mvebu.c:mvebu_gpio_request()
    -> pinctrl/core.c:pinctrl_request_gpio()
      -> pinctrl/pinmux.c:pinmux_request_gpio()
        -> pinctrl/pinmux.c:pin_request()
          -> pinctrl/mvebu/pinctrl-mvebu.c:mvebu_pinmux_gpio_request_enable()
            -> which muxes the pin as GPIO

Pffiou :-)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
