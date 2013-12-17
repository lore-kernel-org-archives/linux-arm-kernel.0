From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 10:16:13 +0800
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <20131217015939.GM3185@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
Message-ID: <20131217021610.GA7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:59:39AM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 07:29:12PM +0800, Shawn Guo wrote:
> > On Mon, Dec 16, 2013 at 03:31:29AM +0000, Li.Xiubo at freescale.com wrote:
> 
> [Deferring probe in non-DT cases]
> > > Where should this special handling be dealt with ? Is here or regulator_get_optional()
> > > will be better ?
> 
> > Anyway, this is another issue which should be addressed in regulator
> > core, IMO.
> 
> It's something that the platform needs to address - the core has no way
> of figuring out what devices might register in future if the platform
> doesn't tell them.

Okay.  But is there an established means for platform to tell that?

Shawn

> With DT we can do that because you can't create a
> device without providing information about what supplies will be made
> avaialable, other systems may be able to do the same thing.
