From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 19 Aug 2016 13:46:02 +0000
Subject: [PATCH v3 0/4] Add DT support for NAND to LCDK via ti-aemif
In-Reply-To: <m2vayxn5gw.fsf@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <m2wpjeqa0o.fsf@baylibre.com> <m2vayxn5gw.fsf@baylibre.com>
Message-ID: <20160819134602.GA3056@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 04:15:59PM -0500, Kevin Hilman wrote:
> Kevin Hilman <khilman@baylibre.com> writes:
> 
> > Karl Beldan <kbeldan@baylibre.com> writes:
> >
> >> Here is another spin. I could get my hands on an EVM and test the
> >> changes on it as well. Doing so, I could also observe that 4bit ECC
> >> on 8bits NANDS is currently broken in mailine. Apparently there had
> >> already been some alerts on the mailing list some months ago.
> >
> > [...]
> >
> >> Karl Beldan (4):
> >>   ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock matching
> >>   ARM: davinci_all_defconfig: Enable AEMIF as a module
> >>   ARM: dts: da850,da850-evm: Add an aemif node and use it for the NAND
> >>   ARM: dts: da850-lcdk: Add NAND to DT
> >
> > Tested on DA850-LCDK with UBIFS.
> >
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> >
> 
> I forgot to mention that I had to enable:
> 
> CONFIG_UBIFS_FS=y
> CONFIG_MTD_UBI=y
> 
> in order to test with ubifs. Care to send a patch adding these as
> modules to davinci_all_defconfig?
> 

Sure, I'll add it to the series when resending.
 
Karl
