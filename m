From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 16 Sep 2010 22:43:03 +0530
Subject: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
In-Reply-To: <4C924F6E.6040804@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com>
	<87sk19eneu.fsf@deeprootsystems.com>	<4C92386F.2070600@ti.com>
	<87vd65bsfs.fsf@deeprootsystems.com>
	<AANLkTim1DD5FOqqxfdV+BoMiq2wmzz6ZuDV6u5_=zUeb@mail.gmail.com>
	<4C924F6E.6040804@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD26065F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, September 16, 2010 10:40 PM
> To: Linus Walleij
> Cc: Kevin Hilman; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific
> OPPs
> 
> Linus Walleij had written, on 09/16/2010 12:07 PM, the following:
> > 2010/9/16 Kevin Hilman <khilman@deeprootsystems.com>:
> >
> >> lib/opp/* seems more appropriate to me with the header at
> >> include/linux/opp.h as Linus suggested.
> >
> > I second this. I would love to see the generic OPP stuff in
> > lib/opp/* so we put it in the right place from the beginning and
> > don't have to painfully refactor everything later (clk.h
> > especially comes to mind.)
> cool.. digging a bit deeper into lib directory, I propose the following:
> lib/opp.c
> include/linux/opp.h
> 
> any soc specific data (for registration etc) -> goes to
> arch/<arch>/mach-<soc>/oppdata_xyz.c or what ever they choose
> 
> the intent being lib/ is no place to put mach or arch specific data
> definitions.. it is just noise..
> 
> if folks are ok with this, will post a new rev soonish..
> 
If you like may be you can take this thread over lkml just to get more
wider perspective
