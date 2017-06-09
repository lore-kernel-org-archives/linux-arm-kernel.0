From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Fri, 09 Jun 2017 15:23:48 +0200
Subject: [RFC PATCH 0/7] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <20170609093651.nfhthfdjn2jfkpxx@pd.tnic>
References: <20170609083123.6539-1-jlu@pengutronix.de>
 <20170609093651.nfhthfdjn2jfkpxx@pd.tnic>
Message-ID: <1497014628.3536.60.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On Fr, 2017-06-09 at 11:36 +0200, Borislav Petkov wrote:
> Before we go any further, pls put all the Marvell RAS functionality
> into a single file - I don't want a separate compilation unit per an
> IP block.
The L2 cache and DDR RAM controller are completely separate IP cores,
with separate register spaces, interrupts and so on. The cache is an ARM
design (some L2x0) extended by Marvell, while the DDR controller seems
to be unique to Marvell. It wouldn't surprise me if Marvell would decide
to reuse the DDR controller in another SoC using newer ARM cores with a
different cache.

> Also, some of your commit messages are empty and I'm sure they could
> use some text.
Sure, I mainly wanted to start the discussion with Chris. :-)

> And yes, it'd be very productive not to get conflicting submissions
> from you and Chris. :-)
Of course!

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
