From: nm@ti.com (Nishanth Menon)
Date: Thu, 16 May 2013 13:18:10 -0500
Subject: [PATCH v4] ARM:dts:omap4-panda: Update the LED support for the
 panda DTS
In-Reply-To: <5194FCDD.8080209@ti.com>
References: <1368636386-17138-1-git-send-email-dmurphy@ti.com>
 <20130515170516.GA6135@kahuna> <5194FCDD.8080209@ti.com>
Message-ID: <CAGo_u6pX+DdVNWqdPXDChzMr27YAXL_Zvt7DxWBijOCW0rXpkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 10:35 AM, Dan Murphy <dmurphy@ti.com> wrote:
> I am not sure you really want to do this.
> If I make the pinctrl part of the led structure then the only way the gpio_wk7 on a1-a3 to be configured is when
> the CONFIG_LEDS_GPIO flag is set.
>
> Do you really want that dependency?  You did say it was a key fix
> At least this way the pins are configured regardless of that flag.

That is better as the system will be left in the pinmux configuration
handed over from bootloader.

The point being, muxing up pins even when not needed(config switched
off) has no real benefit - in this case albeit, the default mux was
causing a bug.
pinctrl IMHO should be considered as any other resource, if it is not
mandatory for boot, and needed only for a device functionality when
probed, it should done there only.

just my 2 cents.
