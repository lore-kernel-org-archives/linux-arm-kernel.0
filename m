From: carlo@caione.org (Carlo Caione)
Date: Sun, 20 Dec 2015 12:51:04 +0100
Subject: [PATCH] mmc: core: Enable tuning according to the actual timing
In-Reply-To: <1450474474-2666-1-git-send-email-carlo@caione.org>
References: <1450474474-2666-1-git-send-email-carlo@caione.org>
Message-ID: <CAOQ7t2ZEQborWOvEbVSbqp227N_kAPfqD=YO8fN5k5hr7ybt5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 10:34 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> While in sdhci_execute_tuning() the choice whether or not to enable the
> tuning is done on the actual timing, in the mmc_sdio_init_uhs_card() the
> check is done on the capability of the card.
>
> This difference is causing some issues with some SDIO cards in DDR50
> mode where the CDM19 is wrongly issued.
>
> With this patch we modify the check in both
> mmc_(sd|sdio)_init_uhs_card() functions to take the proper decision
> only according to the actual timing specification.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Uhm, apparently this is causing some issues with the eMMC on another
laptop I'm testing this patch on.
Please, disregard this patch. I'll post a v2 once I understand what's going on.

Thanks,

-- 
Carlo Caione
