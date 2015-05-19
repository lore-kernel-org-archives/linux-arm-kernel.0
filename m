From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 19 May 2015 22:53:05 +0300
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible
 string
In-Reply-To: <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20150519195305.GA2586@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, May 19, 2015 at 03:34:11PM +0200, Javier Martinez Canillas wrote:
> Google Chromebooks have a SPI flash that is used to store firmware and
> different system parameters and data (i.e: Google Binary Block flags).
> 
> Since there isn't a driver for it yet, the spidev interface is used to
> access the flash from user-space (i.e: using the flashrom tool).
> 
> Add a "google,spi-flash" compatible string so the Device Tree sources
> use it instead of the "spidev" compatible which does not describe the
> real HW and is just a Linux implementation detail.
> 
> A generic "google,spi-flash" OF device ID is used instead of the actual
> vendor/model because these chips are commodity parts that are sourced
> from multiple vendors. So specifying the exact vendor and model in the
> DTS will add a maintenance burden with no real gain (the parts are 100%
> compatible anyways) and will likely result in it simply being wrong for
> a sizeable fraction of the machines.

The compatible string and dt binding should be documented somewhere under 
Documentation/devicetree/bindings/. Also, please keep the dt list on Cc for dt 
related patches.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
