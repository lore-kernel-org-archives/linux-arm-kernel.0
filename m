From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Jun 2011 15:06:19 +0100
Subject: [PATCH 1/2] pxa2xx viper: pcmcia - free gpios on exist rather
	than	requesting them again.
In-Reply-To: <1307368345-13445-2-git-send-email-jic23@cam.ac.uk>
References: <1307368345-13445-1-git-send-email-jic23@cam.ac.uk>
	<1307368345-13445-2-git-send-email-jic23@cam.ac.uk>
Message-ID: <4DECDEDB.8090309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On 06/06/11 14:52, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
> ---
>   drivers/pcmcia/pxa2xx_vpac270.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
> index 435002d..413dc7d 100644
> --- a/drivers/pcmcia/pxa2xx_vpac270.c
> +++ b/drivers/pcmcia/pxa2xx_vpac270.c
> @@ -75,10 +75,10 @@ static int vpac270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
>   static void vpac270_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
>   {
>   	if (skt->nr == 0)
> -		gpio_request_array(vpac270_pcmcia_gpios,
> +		gpio_free_array(vpac270_pcmcia_gpios,
>   					ARRAY_SIZE(vpac270_pcmcia_gpios));
>   	else
> -		gpio_request_array(vpac270_cf_gpios,
> +		gpio_free_array(vpac270_cf_gpios,
>   					ARRAY_SIZE(vpac270_cf_gpios));
>   }
>

You may want to update the subject to reflect the fact that you're 
updating the voipac driver, and not the viper one.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
