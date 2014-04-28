From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 28 Apr 2014 19:03:29 +0200
Subject: [PATCH v2 2/7] pinctrl: berlin: add the BG2Q pinctrl driver
In-Reply-To: <535B7C8A.6000003@gmail.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398268276-9696-3-git-send-email-antoine.tenart@free-electrons.com>
 <535B7C8A.6000003@gmail.com>
Message-ID: <20140428170329.GA4211@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Sat, Apr 26, 2014 at 11:29:46AM +0200, Sebastian Hesselbarth wrote:
> On 04/23/2014 05:51 PM, Antoine T?nart wrote:

[?]

> > +	BERLIN_PINCTRL_GROUP("G2", 0x18, 0x3, 0x06,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "arc"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "lvds_vsync")),
> 
> Shouldn't the above be:
> 
> BERLIN_PINCTRL_FUNCTION(0x3, "lvds"))), /* vsync */

Sure.

[?]

> > +	BERLIN_PINCTRL_GROUP("G6", 0x18, 0x3, 0x12,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "soc"),
> 
> Uhm, any idea what "soc" is for? If not, just leave it.

That should be 'jtag', I'll update.

[?]

> > +	BERLIN_PINCTRL_GROUP("G13", 0x1c, 0x3, 0x09,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "gpio"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "sts1"),
> 
> Any idea what "sts" means, maybe "ts" is for Transport Stream?
> No need to change it, I am just curious.

STS stands for Serial Transport Stream. There may be a more common name
for this, any idea ?

> > +	BERLIN_PINCTRL_GROUP("GAV11", 0x28, 0x3, 0x0c,
> > +			BERLIN_PINCTRL_FUNCTION(0x0, "avio"),
> > +			BERLIN_PINCTRL_FUNCTION(0x1, "dv0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x2, "fp"),
> > +			BERLIN_PINCTRL_FUNCTION(0x3, "i2s0"),
> > +			BERLIN_PINCTRL_FUNCTION(0x4, "avio_pwm"),
> 
> Is it the same "pwm" as for GAV8? If so, remove the "avio_"
> prefix?

Not the same, but 'pwm' makes sense here.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
