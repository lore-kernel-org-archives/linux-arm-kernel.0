From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Wed, 24 Oct 2012 16:34:13 +0200
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5087FC65.30904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le 10/10/2012 04:25 PM, ludovic.desroches at atmel.com a ?crit :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> If the i2c message length is zero, i2c-at91 will directly return an error
> instead of trying to send a zero-length message.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> fix for 3.7
>
>   drivers/i2c/busses/i2c-at91.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index aa59a25..eaddc77 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -263,6 +263,9 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
>   	unsigned int_addr_flag = 0;
>   	struct i2c_msg *m_start = msg;
>
> +	if (!msg->len)
> +		return -EINVAL;
> +
>   	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
>
>   	/*
>

Could you take this fix for 3.7?

Thanks

Regards

Ludovic
