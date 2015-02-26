From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Feb 2015 06:54:06 +0100
Subject: [PATCH v5 1/6] clk: add of_clk_get_parent_rate function
In-Reply-To: <1423097705-22939-2-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
 <1423097705-22939-2-git-send-email-rjui@broadcom.com>
Message-ID: <20150226055406.GB28214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ray,

On Wed, Feb 04, 2015 at 04:55:00PM -0800, Ray Jui wrote:
> Sometimes a clock needs to know the rate of its parent before itself is
> registered to the framework. An example is that a PLL may need to
> initialize itself to a specific VCO frequency, before registering to the
> framework. The parent rate needs to be known, for PLL multipliers and
> divisors to be configured properly.
> 
> Introduce helper function of_clk_get_parent_rate, which can be used to
> obtain the parent rate of a clock, given a device node and index.

I can't see how this patch helps you. First it's not guaranteed that
the parent is already registered, what do you do in this case?
Then the clock framework doesn't require that you initialize the PLL
before registering. That can be done in the clk ops later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
