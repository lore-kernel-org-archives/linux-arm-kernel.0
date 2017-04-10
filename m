From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 10 Apr 2017 17:23:06 +0100
Subject: [PATCH v3 5/9] arm, arm64: factorize common cpu capacity default
 code
In-Reply-To: <20170410081806.GB27538@e104818-lin.cambridge.arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-6-juri.lelli@arm.com>
 <20170410081806.GB27538@e104818-lin.cambridge.arm.com>
Message-ID: <20170410162306.GH30804@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/04/17 09:18, Catalin Marinas wrote:
> On Mon, Mar 27, 2017 at 02:18:21PM +0100, Juri Lelli wrote:
> > arm and arm64 share lot of code relative to parsing CPU capacity
> > information from DT, using that information for appropriate scaling and
> > exposing a sysfs interface for chaging such values at runtime.
> > 
> > Factorize such code in a common place (driver/base/arch_topology.c) in
> > preparation for further additions.
> > 
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> > 
> > Changes from v2:
> >  - make capacity_scale and raw_capacity static
> >  - added SPDX header
> >  - improved indent
> >  - misc. whitespaces/newlines fixes
> > 
> > Changes from v1:
> >  - keep the original GPLv2 header
> > ---
> >  arch/arm/Kconfig             |   1 +
> >  arch/arm/kernel/topology.c   | 213 ++-----------------------------------
> >  arch/arm64/Kconfig           |   1 +
> >  arch/arm64/kernel/topology.c | 219 +--------------------------------------
> >  drivers/base/Kconfig         |   8 ++
> >  drivers/base/Makefile        |   1 +
> >  drivers/base/arch_topology.c | 242 +++++++++++++++++++++++++++++++++++++++++++
> 
> For arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for reviewing the series.

Best,

- Juri
