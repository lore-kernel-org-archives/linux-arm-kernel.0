From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Aug 2016 14:01:57 +0530
Subject: [PATCH 3/4] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <20160809171518.22690-4-kbeldan@baylibre.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-4-kbeldan@baylibre.com>
Message-ID: <57AAE67D.4000404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 August 2016 10:45 PM, Karl Beldan wrote:
> This adds DT support for the NAND connected to the SoC AEMIF.
> The parameters (timings, ecc) are the same as what the board ships with
> (default AEMIF timings, 1bit ECC) and improvements will be handled in
> due course.

I disagree that we need to be compatible to the software that ships with
the board. Thats software was last updated 3 years ago. Instead I would
concern with what the hardware supports. So, if the hardware can support
4-bit ECC, I would use that.

If driver is broken for 4-bit ECC, please fix that up first.

> This passed elementary tests hashing a 20MB file on top of ubifs on my
> LCDK.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Thanks,
Sekhar
