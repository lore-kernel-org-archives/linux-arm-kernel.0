From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 11:42:18 +0100
Subject: [PATCH v5 0/13] arm64: allwinner: a64: Enable MMC support
In-Reply-To: <CAGb2v67stC=EaFMpTSrOirSqQL6r_jPDKsKQNishb=8g=278Gw@mail.gmail.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67stC=EaFMpTSrOirSqQL6r_jPDKsKQNishb=8g=278Gw@mail.gmail.com>
Message-ID: <20170130104218.34zftrdyr3m6422w@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 28, 2017 at 08:44:02PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jan 28, 2017 at 5:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > Here is a new attempt at getting the MMC controllers running, following the
> > work done by Andre.
> >
> > This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> > and a Kingston eMMC with 1.8V IOs.
> >
> > For SDIO, the HS DDR mode works just fine. That serie also enables the
> > SDR104 mode to work on the devices that are capable of this.
> >
> > For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> > moment, but since it's significantly more complex, and at the same time
> > Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> > any benefits. If there's any at some point, this can be added later.
> 
> Whole series is
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Seems that we don't need to increase the signal drive strength for eMMC
> on the A64? This is probably a good thing.

>From what I've seen, Allwinner still recommends using a 30mA drive
strength, so that doesn't seem needed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/4a4f6beb/attachment.sig>
