From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 15:56:33 +0530
Subject: [PATCH 3/3] ARM: davinci: hawk: use gpio descriptor for card
 detect
In-Reply-To: <20161121161541.27048-4-ahaslam@baylibre.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
 <20161121161541.27048-4-ahaslam@baylibre.com>
Message-ID: <51a13cb8-082c-c6c8-c1a1-c39de252d022@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 09:45 PM, Axel Haslam wrote:
> Currently the mmc driver is polling the gpio to know if the
> card was removed.
> 
> By using a gpio descriptor instead of the platform callbacks, the
> driver will be able to register the gpio with the mmc core with API's
> designed for this purpose.
> 
> This has the advantage that an irq will be registered,
> and polling is no longer needed. Also, platform callbacks can be removed.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

This patch looks good, provided it is not based of 1/3 and 2/3. There
are other boards in mach-davinci using the card detect and wp callbacks.
And some like board-dm365-evm.c have those pins routed through a CPLD.
So I guess there is more work to be done before platform callbacks can
completely be removed from MMC/SD driver. But the closer we get, the
better it is :)

Thanks,
Sekhar
