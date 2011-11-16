From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Nov 2011 19:48:39 +0100
Subject: Error for machine_is_m28evk
In-Reply-To: <20111116135857.GA14656@S2100-06.ap.freescale.net>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111116084258.GF9581@n2100.arm.linux.org.uk>
 <20111116135857.GA14656@S2100-06.ap.freescale.net>
Message-ID: <20111116184839.GS30612@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Nov 16, 2011 at 09:58:58PM +0800, Shawn Guo wrote:
> On Wed, Nov 16, 2011 at 08:42:58AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 16, 2011 at 01:59:41PM +0800, Shawn Guo wrote:
> > > Hi Russell,
> > > 
> > > On Tue, Nov 08, 2011 at 08:53:47PM +0800, Shawn Guo wrote:
> > > > On Tue, Nov 08, 2011 at 08:53:50AM +0000, Russell King - ARM Linux wrote:
> > > > [...]
> > > > > 
> > > > > Maybe the answer is to just update the file anyway, and ignore peoples
> > > > > complaints that their entries aren't present until they come to their
> > > > > senses and start COMMUNICATING properly about issues they have with
> > > > > their fscked up entry in the database.
> > > > > 
> > > > So I assume that you will update mach-types for -rc2.  Otherwise,
> > > > please let me know, and I will send a patch to disable m28evk build
> > > > from mxs_defconfig for -rc2.
> > > > 
> > > May I know your plan of mach-types updating?  The -rc2 is out with no
> > > update on mach-types.
> > 
> > There is *NO* bloody way I'm updating this *known* *build* *breaking*
> > thing in an -rc series.  I've already stated my reasons, and I _know_
> > it will break stuff.  I've pointed out what the changes are.  It's in
> > linux-next.  No one has responded to that.
> > 
> Then, can I send the following patch for -rc3 to fix the mxs build
> (I noticed the statement '# Please do not send patches to this file;
> it is automatically generated!' in the file)?  Or do I have to disable
> the m28evk from mxs build?
it would not be the first patch to mach-types. And the next update
doesn't harm as it should include the entry for m28evk.
> 
> Regards,
> Shawn
> 
> ---8<----
> commit acbff8107c90a4d2a436cca53535f2fd35d109e7
> Author: Shawn Guo <shawn.guo@linaro.org>
> Date:   Wed Nov 16 21:44:33 2011 +0800
> 
>     ARM: Update mach-types to fix mxs build breakage
> 
>     Add entry m28evk to fix the following mxs build breakage.
> 
>       CHK     include/generated/compile.h
>       CC      arch/arm/mach-mxs/clock-mx28.o
>     arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
>     arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
>     function 'machine_is_m28evk'
>     make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
>     make: *** [arch/arm/mach-mxs] Error 2
> 
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Alternatively do

	#ifndef machine_is_m28evk
	#define machine_is_m28evk() 0
	#endif

before it's use in arch/arm/mach-mxs/include/mach/mxs.h to fix the build
failure.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
