From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Feb 2012 15:03:17 -0800
Subject: [PATCH v2] pinctrl: pin configuration states
In-Reply-To: <1328124889-9780-1-git-send-email-linus.walleij@stericsson.com>
References: <1328124889-9780-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120202230317.GA1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Linus Walleij <linus.walleij@stericsson.com> [120201 11:04]:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This introduce a pin configuration state structure and activation
> functions similar to the pinmux map. It basically names a few
> states and define the custom configuration values to be applied to
> groups and pins alike when switching to a certain state.
...

> +For simple systems that just configure the pins on boot and then forget about
> +them, the first configuration table may be sufficient. However some systems
> +may need to switch configuration states at runtime, and in that case the
> +system may want to ground both pins by simply calling:
> +
> +ret = pinconf_activate_state("pinctrl-foo", "idle");

For dynamic changing of pin states during runtime we should not change
the states based on string parsing. This is because some of these pins
may need to be changed every time when entering and exiting idle.

Or did I miss something after a quick glance of this?

Regards,

Tony
