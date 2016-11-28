From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 28 Nov 2016 13:20:50 +0100
Subject: [PATCH net-next v3 1/4] net: phy: add an option to disable EEE
 advertisement
In-Reply-To: <1480326409-25419-2-git-send-email-jbrunet@baylibre.com>
References: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
 <1480326409-25419-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <34d6415d-aea9-6e92-cb3d-898ebe01202f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.11.2016 um 10:46 schrieb Jerome Brunet:
> This patch adds an option to disable EEE advertisement in the generic PHY
> by providing a mask of prohibited modes corresponding to the value found in
> the MDIO_AN_EEE_ADV register.
> 
> On some platforms, PHY Low power idle seems to be causing issues, even
> breaking the link some cases. The patch provides a convenient way for these
> platforms to disable EEE advertisement and work around the issue.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/net/phy/phy.c        |  3 ++
>  drivers/net/phy/phy_device.c | 80 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/phy.h          |  3 ++
>  3 files changed, 77 insertions(+), 9 deletions(-)

Tested-by: Andreas F?rber <afaerber@suse.de>

With this and the corresponding .dts change, Odroid-C2 survived a
317-package zypper update for me.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
