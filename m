From: dianders@chromium.org (Doug Anderson)
Date: Mon, 16 May 2016 10:22:41 -0700
Subject: [PATCH v10 7/8] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1463407503-41466-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
 <1463407503-41466-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=UZ+HF-21UJv1xS4a-yssYGC5Y71ngn2=wGSOkceiV+yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Mon, May 16, 2016 at 7:05 AM, David Wu <david.wu@rock-chips.com> wrote:
> - new method to caculate i2c timings for rk3399:
>   There was an timing issue about "repeated start" time at the I2C
>   controller of version0, controller appears to drop SDA at .875x (7/8)
>   programmed clk high. On version 1 of the controller, the rule(.875x)
>   isn't enough to meet tSU;STA
>   requirements on 100k's Standard-mode. To resolve this issue,
>   sda_update_config, start_setup_config and stop_setup_config for I2C
>   timing information are added, new rules are designed to calculate
>   the timing information at new v1.
> - pclk and function clk are separated at rk3399
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Tested-by: Caesar Wang <wxt@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Change in v10:
> - fix the clean of con register in rk3x_i2c_stop()
>
> Change in v9:
> - add spin lock for tuning updated in rk3x_i2c_adapt_div() (Doug)
>
> Changes in v8:
> - update tuning in RKI2C_CON register by doing a read-modify-write (Doug)
> - new method to use pclk and clk (Doug)
>
> Changes in v7:
> - transform into a 9 series patches (Doug)
> - drop highspeed with mastercode, and support fast-mode plus (Doug)
>
>  drivers/i2c/busses/i2c-rk3x.c | 294 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 274 insertions(+), 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
