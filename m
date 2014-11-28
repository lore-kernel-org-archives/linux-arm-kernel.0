From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 21:57:34 +0100
Subject: [PATCH RESEND] ARM: vexpress: Enable regulator framework when
 MMCI is in use
In-Reply-To: <1417193071-801-1-git-send-email-pawel.moll@arm.com>
References: <1417192440.4371.15.camel@arm.com>
 <1417193071-801-1-git-send-email-pawel.moll@arm.com>
Message-ID: <2719121.hRCeH8rxZM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 16:44:31 Pawel Moll wrote:
> The MMCI driver, when used with a Device Tree described device, relies
> on the "vmmc" voltage regulator supply to set the OCR register voltage bits,
> using MMC core's mmc_regulator_get_supply() function.
> 
> Without the regulator framework present there are no valid operating
> voltages reported and the device initialisation fails:
> 
> mmci-pl18x 10005000.mmci: No vmmc regulator found
> mmci-pl18x 10005000.mmci: no support for card's volts
> mmc0: error -22 whilst initialising SD card
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 

Applied on top, thanks!

	Arnd
