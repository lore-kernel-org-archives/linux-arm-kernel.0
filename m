From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 1 Nov 2011 06:59:46 +0100
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
In-Reply-To: <CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
References: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
	<CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B34BE8B@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Havard,

> {sda,scl}_is_open_drain indicates that the GPIO hardware is set up to
> do open drain so the software doesn't have to, i.e.
> gpio_set_value(pin, 1) will turn off the output driver rather than
> drive the pin high, so the _val functions will do the right thing.

gpio_set_value(pin, 1) drives the output high same as
gpio_direction_output(pin, 1) does (documented in Documentation/gpio.txt),
so the gpio will be changed from open-drain to push-pull.

In contrast, gpio_direction_input(pin) will turn off the output driver.

Open-drain io is bound to "!is_open_drain" and push-pull io is bound to
"is_open_drain", so I still think this should be the other way round.

Niko
