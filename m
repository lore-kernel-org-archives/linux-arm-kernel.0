From: dianders@chromium.org (Doug Anderson)
Date: Wed, 4 May 2016 16:45:59 -0700
Subject: [PATCH v7 1/9] i2c: rk3x: add documentation to fields in "struct
 rk3x_i2c"
In-Reply-To: <1462371194-5809-2-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462371194-5809-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=VyAie7NcO3q4qQWEdHaiUUHbRN-6iWV3y+kvgSYPpkEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wrote:
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Change in v7:
> - none
>
>  drivers/i2c/busses/i2c-rk3x.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 80bed02..7e45d51 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -90,6 +90,26 @@ struct rk3x_i2c_soc_data {
>         int grf_offset;
>  };
>
> +/**
> + * struct rk3x_i2c - private data of the controller
> + * @adap: corresponding I2C adapter
> + * @dev: device for this controller
> + * @soc_data: related soc data struct
> + * @regs: virtual memory area
> + * @clk: clock of i2c bus
> + * @clk_rate_nb: i2c clk rate change notify
> + * @t: I2C known timing information

You're a little ahead of yourself.  The @t element doesn't exist as of
this patch.  Instead all the sub-elements are there.  This in this
patch you need to document scl_frequency, scl_rise_ns, ....  In a
later patch you'd change it to t.


-Doug
