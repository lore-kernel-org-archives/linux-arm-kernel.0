From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 11:40:22 -0500
Subject: [PATCH v1 03/10] regulator: act8865: Use
 of_is_system_power_controller helper function
In-Reply-To: <1414427215-14380-3-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-3-git-send-email-romain.perier@gmail.com>
Message-ID: <20141027164022.GC14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:26:48PM +0000, Romain Perier wrote:
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  drivers/regulator/act8865-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
> index 76301ed..435aba1 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -365,7 +365,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	if (of_system_has_poweroff_source(dev->of_node)) {
> +	if (of_is_system_power_controller(dev->of_node)) {

so building this driver is broken until this patch ? not very good
either.

Looks to me you should add of_is_system_power_controller without remove
of_system_has_poweroff_source() until all users of that have been
converted over.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/f6c2b806/attachment.sig>
