From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Nov 2017 08:55:53 +0100
Subject: [PATCH] ARM: dts: imx6: Remove unneeded address-cells/size-cells
In-Reply-To: <62f3cb01-ff85-0fe0-2afa-0fe4732a7421@rwth-aachen.de>
References: <1510348378-18150-1-git-send-email-festevam@gmail.com>
 <62f3cb01-ff85-0fe0-2afa-0fe4732a7421@rwth-aachen.de>
Message-ID: <20171113075553.vseyq3swmzwja3ld@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Nov 11, 2017 at 03:24:47PM +0100, Christopher Spinrath wrote:
> (I'm sorry if I've missed some recipients or broke the email thread but
> I got Fabio's email from the infradead archive.)
> 
> On 11/10/2017 10:12 PM, festevam at gmail.com (Fabio Estevam) wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > According to Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt:
> > 
> > "- #address-cells, #size-cells : Must be present if the device has
> > sub-nodes representing partitions."
> > 
> > Remove the occurrences of #address-cells/size-cells where no sub-nodes
> > representing partitions are present.
> 
> This results in a regression for those devices where U-Boot is supposed
> to inject the partition sub-nodes. For example, this is the case for
> cm-fx6 module based devices like the Utilite Pro.

sounds like an U-Boot bug that it inserts partition nodes, but doesn't
ensure matching #address-cells/size-cells are specified.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
