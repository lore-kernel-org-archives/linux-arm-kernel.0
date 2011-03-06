From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 12:09:21 +0800
Subject: [PATCH 1/3] video: mxsfb: smarten the code a little bit
In-Reply-To: <201103051741.12167.arnd@arndb.de>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
	<1299341931-30241-2-git-send-email-shawn.guo@freescale.com>
	<201103051741.12167.arnd@arndb.de>
Message-ID: <20110306040920.GA1223@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sat, Mar 05, 2011 at 05:41:11PM +0100, Arnd Bergmann wrote:
> On Saturday 05 March 2011 17:18:49 Shawn Guo wrote:
> > @@ -882,7 +884,6 @@ static struct platform_device_id mxsfb_devtype[] = {
> >         }, {
> >                 .name = "imx28-fb",
> >                 .driver_data = MXSFB_V4,
> > -       }, {
> >         },
> >  };
> 
> This is broken, you need to have an empty entry as the end marker,
> otherwise, the match function will interpret whatever comes in 
> memory after the last entry as input data, until it hits zeroes.
> 
Ah, my dumb.  Thanks for pointing this out.  I will recover it with
a marker, and also prepare a patch to fix the exactly same issue I
created in fec.c :)

-- 
Regards,
Shawn
