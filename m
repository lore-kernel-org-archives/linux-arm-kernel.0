From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Nov 2011 08:53:49 +0100
Subject: Error for machine_is_m28evk
In-Reply-To: <4EB8CC7B.5060503@denx.de>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de>
Message-ID: <20111108075349.GK2854@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 07:30:19AM +0100, Stefano Babic wrote:
> On 11/08/2011 02:49 AM, Fabio Estevam wrote:
> > On a 3.2-rc1 kernel I get the following error when trying to build
> > mxs_defconfig:
> > 
> >   CHK     include/generated/compile.h
> >   CC      arch/arm/mach-mxs/clock-mx28.o
> > arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
> > arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
> > function 'machine_is_m28evk'
> > make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
> > make: *** [arch/arm/mach-mxs] Error 2
> 
> This is due to the missing mach-id for the M28. The mach-id for this
> board was requested and it is 3613, already set as "mainlined" at
> http://www.arm.linux.org.uk/developer/machines/. We need an update of
> mach-types.
Maybe add a

	#ifndef machine_is_m28evk
	#define machine_is_m28evk() 0
	#endif

to one of the headers until Russell is willing to update mach-types
again?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
