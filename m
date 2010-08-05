From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Thu, 5 Aug 2010 11:44:54 +0530
Subject: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
In-Reply-To: <20100729142011.GG18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
	<AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
	<20100729142011.GG18923@n2100.arm.linux.org.uk>
Message-ID: <20100805061453.GA7524@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 16:20:11 +0200, Russell King - ARM Linux wrote:
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 4917af9..8ca38d9 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -541,7 +541,11 @@ static int mmci_get_cd(struct mmc_host *mmc)
>  	else
>  		status = gpio_get_value(host->gpio_cd);
>  
> -	return !status;
> +	/*
> +	 * Use positive logic throughout - status is zero for no card,
> +	 * non-zero for card inserted.
> +	 */
> +	return status;
>  }

Your patch in -next has a !gpio_get_value, so are you OK with the
cd_noinvert addition (for the GPIO case)?  Or a cd_invert and a patch to
existing platforms?

Rabin
