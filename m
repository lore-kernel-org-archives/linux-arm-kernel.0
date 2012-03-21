From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 21 Mar 2012 19:26:04 +0300
Subject: [PATCH 1/3] mmc: atmel-mci: correct data timeout computation
In-Reply-To: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4F6A011C.3000900@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/21/2012 06:41 PM, ludovic.desroches at atmel.com wrote:

> From: Ludovic Desroches<ludovic.desroches@atmel.com>

> The HSMCI operates at a rate of up to Master Clock divided by two.

> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> ---
>   drivers/mmc/host/atmel-mci.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e4449a5..e161452 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -480,7 +480,7 @@ err:
>   static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
>   					unsigned int ns)
>   {
> -	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
> +	return (ns * ((host->bus_hz/2) / 1000000) + 999) / 1000;

    Why don't you keep the notation by addign spaces around '/'?
    BTW, could use DIV_ROUND_UP() here.

WBR, Sergei
