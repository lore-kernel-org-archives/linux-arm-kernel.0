From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 26 Nov 2012 11:00:55 +0100
Subject: [PATCH v3 2/4] ARM: kirkwood: DT board setup for Network Space
 v2 and parents
In-Reply-To: <20121126090253.GI9580@quad.lixom.net>
References: <1350468546-25901-1-git-send-email-simon.guinot@sequanux.org>
 <1350468546-25901-3-git-send-email-simon.guinot@sequanux.org>
 <20121126090253.GI9580@quad.lixom.net>
Message-ID: <20121126100055.GX10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

We are getting near to having boards fully described in DT. The last
major piece we are missing is a DT binding for the Ethernet driver.
Once that is in we can remove many of these per-board files and C code
in board-dt.c. However, this is not going to happen before this merge
window :-(

> Same here. I actually think this is a table that is no longer needed -- the
> board compat can/should be done on the generic compatible string instead of for
> each most-specific board string.
> 
> > +static void ns2_power_off(void)
> > +{
> > +	gpio_set_value(NS2_GPIO_POWER_OFF, 1);
> > +}
> 
> This kind of thing should be possible to generalize through a generic binding.

Such a generic binding is part of the pull requests. We converted two
existing boards to this new binding. However, the new boards don't
make use of a lot of new features we added this cycle, including this
generic binding and pinctrl. We might have time to convert them before
the merge window, otherwise it will be one of the first things we do
for the next cycle.

	Andrew
