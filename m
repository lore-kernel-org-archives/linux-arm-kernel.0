From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 12 Nov 2013 08:40:28 +0100
Subject: [PATCH 0/4] Socfpga: clk: trivial fixes and cleanup
In-Reply-To: <5281A332.6060300@gmail.com>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
 <1384215177.17054.2.camel@linux-builds1>
 <5281A332.6060300@gmail.com>
Message-ID: <20131112074028.GW28790@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Mon, Nov 11, 2013 at 09:40:34PM -0600, Dinh Nguyen wrote:
> 
> On 11/11/13 6:12 PM, Dinh Nguyen wrote:
> > Hi Steffen,
> >
> > On Thu, 2013-11-07 at 16:07 +0100, Steffen Trumtrar wrote:
> >> Hi!
> >>
> >> This series includes two trivial fixes to the code (1,2),
> >> then goes on to split the single clk.c file up into clock-type
> >> specific files (3) and finally adds a divider to the peripheral
> >> clock path.
> >>
> >> The patches are rebased to the for-next branch of
> >>
> >>         git://git.rocketboards.org/linux-socfpga-next.git
> >>
> >> Regards,
> >> Steffen
> >>
> >> Steffen Trumtrar (4):
> >>   ARM: socfpga: clk: remove unused field
> >>   ARM: socfpga: clk: fix define typo
> > The first two patches are fine.
> >
> >>   ARM: socfpga: clk: split clk code
> >>   ARM: socfpga: clk: add clk_divider to periph
> > These two patches are causing the ethernet driver to not be able to grab
> > the correct clock during probe.
> >
> > Lets wait for 3.13-rc1 and I will push a new for-next that will be more
> > up-to-date.
> 

Hm, okay. It works fine on my SoCKit. But maybe I missed something in the
split up.

> Also the values do not look correct with your patch:
> 
> per_nand_mmc_clk         1           1            52631578
>           nand_clk              0           0            13157894
>           nand_x_clk            0           0            52631578
>           sdmmc_clk             1           1            52631578
> 
> Without your patch:
> 
>  per_nand_mmc_clk         1           1            50000000
>           nand_clk              0           0            12500000
>           nand_x_clk            0           0            50000000
>           sdmmc_clk             1           1            50000000
> 

Yes. I can confirm that on my board, too. I actually seem to have read over
those three values and missed them.

Let's wait for 3.13-rc1, then.

I actually also wanted to change the l3_sp_clk, as it seems to be neglect
the "1 or 2" divider from l3_mp_clk IIRC, but I couldn't come up with a good
way without changing the binding or something. What do you thing about that?
Is that wrong at the moment or do I miss something?


Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
