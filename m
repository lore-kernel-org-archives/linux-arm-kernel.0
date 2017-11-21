From: hanetzer@startmail.com (Marty E. Plummer)
Date: Tue, 21 Nov 2017 05:56:12 -0600
Subject: [PATCH v2 1/3] clk: hisilicon: add CRG driver Hi3521A SoC
In-Reply-To: <20171024184250.d4wmzr6osd4o53oz@rob-hp-laptop>
References: <20171017223854.6980-1-hanetzer@startmail.com>
 <20171017223854.6980-2-hanetzer@startmail.com>
 <20171024184250.d4wmzr6osd4o53oz@rob-hp-laptop>
Message-ID: <20171121115611.bmdriap3uoazmyiw@proprietary-killer.fossland>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 01:42:50PM -0500, Rob Herring wrote:
> On Tue, Oct 17, 2017 at 05:38:52PM -0500, Marty E. Plummer wrote:
> > Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> > generates clock and reset signals used by other module blocks on SoC.
> > 
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > ---
> > Changes in v2:
> >   - Switched to SPDX tags and GPL-2.0+
> > 
> >  drivers/clk/hisilicon/Kconfig             |   7 ++
> >  drivers/clk/hisilicon/Makefile            |   1 +
> >  drivers/clk/hisilicon/crg-hi3521a.c       | 196 ++++++++++++++++++++++++++++++
> 
> >  include/dt-bindings/clock/hi3521a-clock.h |  23 ++++
> 
> Acked-by: Rob Herring <robh@kernel.org>
Actually nack this for now. I need to change some stuff over to use a
different clock for the sp804 timer at 12000000, apparently I'm going to
need to use CLK_OF_DECLARE to get the clock in question working that
early in boot.
