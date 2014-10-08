From: Yuantian.Tang@freescale.com (Yuantian Tang)
Date: Wed, 8 Oct 2014 03:28:20 +0000
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <1412035075.13320.302.camel@snotra.buserror.net>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <d4a375f40b544cf1ae78ac82dc20569c@BL2PR03MB467.namprd03.prod.outlook.com>
 <1411675680.13320.201.camel@snotra.buserror.net>
 <20140925225406.19023.25065@quantum>
 <1411685780.13320.209.camel@snotra.buserror.net>
 <20140926232900.19023.35854@quantum>
 <d637914864824bda8d0dd62639e9097b@DM2PR03MB574.namprd03.prod.outlook.com>
 <1412035075.13320.302.camel@snotra.buserror.net>
Message-ID: <920830473fda4de3abcbf5ae11dd2360@DM2PR03MB574.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, September 30, 2014 7:58 AM
> To: Tang Yuantian-B29983
> Cc: Mike Turquette; linuxppc-dev at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Lu Jingchang-B35083
> Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
> CLK_OF_DECLARE support
> 
> On Sat, 2014-09-27 at 21:18 -0500, Tang Yuantian-B29983 wrote:
> > > -----Original Message-----
> > > From: Linuxppc-dev
> > > [mailto:linuxppc-dev-bounces+b29983=freescale.com at lists.ozlabs.org]
> > > On Behalf Of Mike Turquette
> > > Sent: Saturday, September 27, 2014 7:29 AM
> > > To: Wood Scott-B07421
> > > Cc: linuxppc-dev at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; Lu Jingchang-B35083
> > > Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
> > > CLK_OF_DECLARE support
> > >
> > > Quoting Scott Wood (2014-09-25 15:56:20)
> > > > On Thu, 2014-09-25 at 15:54 -0700, Mike Turquette wrote:
> > > > > Quoting Scott Wood (2014-09-25 13:08:00)
> > > > > > Well, like I said, I'd rather see the CLK_OF_DECLARE stuff be
> > > > > > made to work on PPC rather than have the driver carry around
> > > > > > two binding methods.
> > > > >
> > > > > I guess that is an existing problem, and not related directly to
> > > > > this patch? This patch is essentially just renames (though the
> > > > > V1.0/V2.0 stuff seems weird).
> > > >
> > > > This patch is adding CLK_OF_DECLARE.
> > >
> > > I'm fine taking this patch but your comments are still unresolved.
> > > What do you think needs to be done to fix the problems that you see?
> > >
> > CLK_OF_DECLARE is totally worked on PPC. I will do it in a separate patch.
> > Regarding V1.0 and V2.0, it is not wired just same for now. But we are not sure
> if it is same for v3.0 in the future.
> >
> > Besides updating drivers/cpufreq/Kconfig.powerpc, there is one more thing I
> am not comfortable with:
> > This patch uses " fixed-clock" as sysclk's compatible string, while on PPC we
> treated it as " fsl,qoriq-sysclk-[1-2].0".
> > That's inconsistent on both ARM and PPC platforms, neither did on bindings.
> 
> fsl,qoriq-sysclk-XXX is the way it is because of compatibility with the fixups in
> existing U-Boots.  It shouldn't be used as a model.
> 
> That said, I don't think you really mean "this patch", as it doesn't contain the
> device tree updates, and "fixed-clock" does not appear.
> 
"fixed-clock" will appear when ls102x platform DTS gets upstreamed eventually.
That would be fine if you don't think "fsl,qoriq-sysclk-xxx" having different meaning on ARM and PowerPC is a issue.

Thanks,
Yuantian
> -Scott
> 
