From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 22:27:06 +0100
Subject: [PATCH v4 0/13] arm64: allwinner: a64: Enable MMC support
In-Reply-To: <e4133504-8bc7-a9ac-209d-3d8cba119fed@heig-vd.ch>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
 <e4133504-8bc7-a9ac-209d-3d8cba119fed@heig-vd.ch>
Message-ID: <20170127212706.c65js5aw7itugfky@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Fri, Jan 27, 2017 at 11:37:27AM +0100, Florian Vaussard wrote:
> Hi Maxime,
> 
> On 01/26/2017 10:05 AM, Maxime Ripard wrote:
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
> > 
> > Let me know what you think,
> > Maxime
> > 
> 
> FWIW I tested this series and got decent throughput (190 Mbps in UDP) with a
> Marvell SDIO Wifi chip. The board becomes unresponsive between 30 to 60 minutes
> of iperf torture, but I strongly suspect a hardware issue underneath. Feel free
> to add my Tested-by on the MMC patches if you need it.

Thanks for testing!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/d5ff7823/attachment.sig>
