From: cjb@laptop.org (Chris Ball)
Date: Thu, 27 Jun 2013 11:18:56 -0400
Subject: [PATCH] mmc: sirf: fix sdhci_pltfm_init sequence
In-Reply-To: <24753444.e6CjWoyOih@wuerfel> (Arnd Bergmann's message of "Tue,
 04 Jun 2013 00:02:13 +0200")
References: <24753444.e6CjWoyOih@wuerfel>
Message-ID: <87ppv7ponz.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jun 03 2013, Arnd Bergmann wrote:
> Patch "mmc: sdhci: Add size for caller in init+register" changed the
> interface for sdhci_pltfm_init, while patch "mmc: sdhci-sirf: add mmc
> host sdhci-pltfm based driver for SiRF SoCs" added a new driver
> with the old interface.
>
> This changes the sirf driver to use the new interface, avoiding
> one warning, and simplifying the init sequence. Since we're here
> already, this also adds an error path for failed clk_prepare_enable.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: Barry Song <Baohua.Song@csr.com>
> Cc: Chris Ball <cjb@laptop.org>

Thanks, fixed the conflict and pushed to mmc-next for 3.11; sorry for
the delay.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
