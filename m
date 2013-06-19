From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Jun 2013 05:27:15 -0700
Subject: [PATCH v2 1/4] ARM: dts: omap4-panda: Add USB Host support
In-Reply-To: <51C183AC.8040801@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com>
 <1371571487-14389-2-git-send-email-rogerq@ti.com>
 <51C106A1.9030001@ti.com> <51C15F7E.5020305@ti.com>
 <20130619074605.GW5523@atomide.com> <51C183AC.8040801@ti.com>
Message-ID: <20130619122715.GA5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [130619 03:17]:
> On 06/19/2013 02:46 AM, Tony Lindgren wrote:
> >
> >We have a similar issue with the MMC1 PBIAS. I think in the long run we
> >should expand regulator (and possibly pinctrl) framework(s) to handle
> >comparators. We could just assume that a comparatator is a regulator,
> >and have a comparator binding that just uses the regulator code.
> 
> In the case of pbias, the pinctrl seems to be a much better fit for
> my point of view. pinctrl can handle pin configuration and this is
> what the pbias is in the case of MMC pins.

Well just recently Linus W specifically wanted us to use regulator
framework for the MMC1 PBIAS rather than pinctrl. That's because
from consumer driver point of view, it changes voltage and there's
a delay involved. So I guess no conclusion yet, and it's best to
do stand alone drivers to deal with those that use pinctrl for the
pinctrl specific parts and export it as a regulator for the consumer
devices. That's pretty much along the lines what Roger has done,
except the transceiver could use the pinctrl-single,bits for the
muxing and pinconf.

Regards,

Tony
