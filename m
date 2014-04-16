From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 16 Apr 2014 22:49:50 +0200
Subject: [PATCH 1/2] clk: socfpga: add divider registers to the main pll
 outputs
In-Reply-To: <534EE6AF.4040001@gmail.com>
References: <1397679270-29695-1-git-send-email-dinguyen@altera.com>
 <534EE6AF.4040001@gmail.com>
Message-ID: <20140416204950.GK16054@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Apr 16, 2014 at 03:23:11PM -0500, Dinh Nguyen wrote:
> 
> 
> On 04/16/2014 03:14 PM, dinguyen at altera.com wrote:
> >From: Dinh Nguyen <dinguyen@altera.com>
> >
> >The C0(mpu_clk), C1(main_clk), and C2(dbg_base_clk) outputs from the main
> >PLL go through a pre-divider before coming into the system. These registers
> >were hidden for the CycloneV platform, but are not used for the ArriaV
> 
> Sorry but this should be "but are now used"
> 

???

I don't get it. Do we have these registers on the cyclone V AND arria V or do
we only have them on the arria V ?

IIRC I had made a patch that adds dividers to some place in the clocktree, but
I can't remember if these are the same.

Regards,
Steffen

> >platform.
> >
> >This patch updates the clock driver to read the div-reg property for the
> >socfpga-periph-clk clocks. Also moves the div_mask define to clk.h for re-use.
> >
> >Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
