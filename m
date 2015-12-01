From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 14:21:45 +0100
Subject: [PATCH,
 RESEND] regulator: core: fix regulator_lock_supply regression
In-Reply-To: <20151201131639.GH1929@sirena.org.uk>
References: <3504080.aWaTxHbgxH@wuerfel> <20151201131639.GH1929@sirena.org.uk>
Message-ID: <1708414.D0FXtrOgf1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 13:16:39 Mark Brown wrote:
> On Fri, Nov 27, 2015 at 02:46:41PM +0100, Arnd Bergmann wrote:
> > As noticed by Geert Uytterhoeven, my patch to avoid a harmless build warning
> > in regulator_lock_supply() was total crap and introduced a real bug:
> 
> I'm going to drop both this and the commit it's fixing for now as this
> is causing boot failures on several boards (none of which I have sadly)
> in -next:
> 
>   http://kernelci.org/boot/all/job/broonie-regulator/kernel/v4.4-rc3-17-ga6498dba8869/
> 
> which were bisected by Tyler to this:
> 
>   http://hastebin.com/noluripepa.sm
> 
> I'm not seeing anything obvious in the code at the minute having looked
> for several seconds, I'll have a proper look later today all being well.
> 

Ok, sorry about the double screwup and thanks for looking into it.

	Arnd
