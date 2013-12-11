From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Dec 2013 10:44:40 +0100
Subject: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <1386042188-12246-1-git-send-email-balbi@ti.com>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
Message-ID: <20131211094440.GG18888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 09:42:54PM -0600, Felipe Balbi wrote:
> we could build that as a driver.
What is "that". How can it not be a driver? Do you mean modular? In that
case there is no problem, the only thing that doesn't work is unloading
the module.

Best regards
Uwe
 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index ad25bfa..975ff9e 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1262,7 +1262,7 @@ fail:
>  	return err;
>  }
>  
> -static int __exit menelaus_remove(struct i2c_client *client)
> +static int menelaus_remove(struct i2c_client *client)
>  {
>  	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
>  
> @@ -1283,7 +1283,7 @@ static struct i2c_driver menelaus_i2c_driver = {
>  		.name		= DRIVER_NAME,
>  	},
>  	.probe		= menelaus_probe,
> -	.remove		= __exit_p(menelaus_remove),
> +	.remove		= menelaus_remove,
>  	.id_table	= menelaus_id,
>  };
>  

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
