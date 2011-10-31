From: hskinnemoen@gmail.com (=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=)
Date: Mon, 31 Oct 2011 14:21:56 -0700
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
References: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
Message-ID: <CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 9:14 AM, Voss, Nikolaus <N.Voss@weinmann.de> wrote:
> If pdata->scl_is_open_drain was set, the driver used push-pull output
> for SCL, not open-drain output.
>
> Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>

{sda,scl}_is_open_drain indicates that the GPIO hardware is set up to
do open drain so the software doesn't have to, i.e.
gpio_set_value(pin, 1) will turn off the output driver rather than
drive the pin high, so the _val functions will do the right thing.

In other words, the existing code is correct.

Havard
