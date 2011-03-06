From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 14:30:55 +0800
Subject: [PATCH 1/3] video: mxsfb: smarten the code a little bit
In-Reply-To: <20110306040920.GA1223@S2101-09.ap.freescale.net>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
	<1299341931-30241-2-git-send-email-shawn.guo@freescale.com>
	<201103051741.12167.arnd@arndb.de>
	<20110306040920.GA1223@S2101-09.ap.freescale.net>
Message-ID: <20110306063054.GB1223@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 12:09:21PM +0800, Shawn Guo wrote:
> Hi Arnd,
> 
> On Sat, Mar 05, 2011 at 05:41:11PM +0100, Arnd Bergmann wrote:
> > On Saturday 05 March 2011 17:18:49 Shawn Guo wrote:
> > > @@ -882,7 +884,6 @@ static struct platform_device_id mxsfb_devtype[] = {
> > >         }, {
> > >                 .name = "imx28-fb",
> > >                 .driver_data = MXSFB_V4,
> > > -       }, {
> > >         },
> > >  };
> > 
> > This is broken, you need to have an empty entry as the end marker,
> > otherwise, the match function will interpret whatever comes in 
> > memory after the last entry as input data, until it hits zeroes.
> > 
> Ah, my dumb.  Thanks for pointing this out.  I will recover it with
> a marker, and also prepare a patch to fix the exactly same issue I
> created in fec.c :)
> 
Just found that fec has been fixed by the following commit on David's
tree.

commit 9eb0e6f26e48ef22cc56a2b81b1572ace999f70f
Author: Axel Lin <axel.lin@gmail.com>
Date:   Tue Feb 22 23:28:46 2011 +0000

    net/fec: fix unterminated platform_device_id table

    The platform_device_id table is supposed to be zero-terminated.

-- 
Regards,
Shawn
