From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Wed, 09 May 2012 01:00:12 +0800
Subject: [PATCH] mfd: da9052: fix of_match_node() arguments
In-Reply-To: <1336258968-6423-1-git-send-email-olof@lixom.net>
References: <1336258968-6423-1-git-send-email-olof@lixom.net>
Message-ID: <4FA9511C.5060007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?05?06? 07:02), Olof Johansson wrote:
> The driver calls of_match_node() with the arguments swapped.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/mfd/da9052-i2c.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
> index d8abdb3..8410065 100644
> --- a/drivers/mfd/da9052-i2c.c
> +++ b/drivers/mfd/da9052-i2c.c
> @@ -104,7 +104,7 @@ static int __devinit da9052_i2c_probe(struct i2c_client *client,
>  		struct device_node *np = client->dev.of_node;
>  		const struct of_device_id *deviceid;
>  
> -		deviceid = of_match_node(np, dialog_dt_ids);
> +		deviceid = of_match_node(dialog_dt_ids, np);
>  		id = (const struct i2c_device_id *)deviceid->data;
>  	}
>  #endif

Tested-by: Ying-Chun Liu <paul.liu@linaro.org>


Sorry. I don't know how my code works and tested previously.
But your patch is definited correct.
