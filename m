From: roger.quadros@nokia.com (Roger Quadros)
Date: Thu, 22 Jul 2010 14:35:29 +0300
Subject: [PATCH v2 18/20] mmc: sdio: enable a default power off mode of
	the card
In-Reply-To: <1279733634-21974-19-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-19-git-send-email-ohad@wizery.com>
Message-ID: <4C482D01.1040109@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2010 08:33 PM, ext Ohad Ben-Cohen wrote:
> Add support for an SDIO device to stay powered off even without
> the presence of an SDIO function driver. A host should explicitly
> ask for it by means of MMC_CAP_DONT_POWER_CARD, and the SDIO
> function driver should know it needs to call sdio_claim_power
> before accessing the device.
>
> Signed-off-by: Ohad Ben-Cohen<ohad@wizery.com>

Shouldn't this be the default behaviour? If there is no function driver for any 
of the functions of the card, then sdio core shold power off the card.

I don't see a need for a special capability flag for this.

in fact MMC_CAP_DONT_POWER_CARD does not seem like an mmc host's capability 
flag, it seems more like a request from the board to keep the card powered off.

regards,
-roger
