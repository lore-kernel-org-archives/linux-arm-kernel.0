From: ben-i2c@fluff.org (Ben Dooks)
Date: Mon, 13 Feb 2012 23:14:01 +0000
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <4F301E25.5060507@samsung.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <4F301E25.5060507@samsung.com>
Message-ID: <20120213231401.GE2999@freya.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 07:38:29PM +0100, Karol Lewandowski wrote:
> On 05.02.2012 11:38, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> Hi!
> 
> >+Device-Tree bindings for i2c gpio driver
> >+
> >+Required properties:
> >+	- compatible = "gpio-i2c";
> 
> Driver name is "i2c-gpio" in file i2c-gpio.c. Previous version of
> patch adding DT-support (prepared by Thomas Chou[1]) used i2c-gpio -
> could we stick to that name?
> 
> [1] https://lkml.org/lkml/2011/2/23/584
> 
> >+	- gpios: sda and scl gpio
> >+
> >+
> >+Optional properties:
> >+	- gpio-i2c,sda_is_open_drain: sda as open drain
> >+	- gpio-i2c,scl_is_open_drain: scl as open drain
> >+	- gpio-i2c,scl_is_output_only: scl as output only
> 
> Most of DT-properties I've seen used hyphen, not underscore.  Could
> we stick to that convention?
> 
> (Nitpick: I think that "is" in property names is redundant too.)
> 
> >+	- udelay: half clock cycle time in us (may depend on each platform)
> 
> Could we use "clock-frequency" as Grant have suggested during review
> of previous patch to i2c-gpio?

I'm with Grant on that, it would be nice to have a reasonably sane set of
default i2c dt bindings that everyone uses.
