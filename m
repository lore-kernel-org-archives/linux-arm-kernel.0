From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 10 Jul 2018 22:47:28 -0700
Subject: [PATCH] i2c: aspeed: Fix initial values of master and slave state
In-Reply-To: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g45=SkyLWRy=DnYOZCXcmHkrbTdOSBi=n=kUgyvRPoU8Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 2:20 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This patch changes the order of enum aspeed_i2c_master_state and
> enum aspeed_i2c_slave_state defines to make their initial value to
> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
> In case of multi-master use, if a slave data comes ahead of the
> first master xfer, master_state starts from an invalid state so
> this change fixes the issue.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..2714c7fbe7c9 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -111,22 +111,22 @@
>  #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>
>  enum aspeed_i2c_master_state {
> +       ASPEED_I2C_MASTER_INACTIVE,
>         ASPEED_I2C_MASTER_START,
>         ASPEED_I2C_MASTER_TX_FIRST,
>         ASPEED_I2C_MASTER_TX,
>         ASPEED_I2C_MASTER_RX_FIRST,
>         ASPEED_I2C_MASTER_RX,
>         ASPEED_I2C_MASTER_STOP,
> -       ASPEED_I2C_MASTER_INACTIVE,
>  };
>
>  enum aspeed_i2c_slave_state {
> +       ASPEED_I2C_SLAVE_STOP,
>         ASPEED_I2C_SLAVE_START,
>         ASPEED_I2C_SLAVE_READ_REQUESTED,
>         ASPEED_I2C_SLAVE_READ_PROCESSED,
>         ASPEED_I2C_SLAVE_WRITE_REQUESTED,
>         ASPEED_I2C_SLAVE_WRITE_RECEIVED,
> -       ASPEED_I2C_SLAVE_STOP,
>  };
>
>  struct aspeed_i2c_bus {
> --
> 2.17.1
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

BTW, sorry for the delay, just got back from vacation. I will review
the rest tomorrow.
