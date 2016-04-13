From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 13 Apr 2016 20:11:47 +0800
Subject: [PATCH] i2c: designware-platdrv: get fast/std speed scl
 high/low count from DT
In-Reply-To: <20160407175759.GO32257@rob-hp-laptop>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
 <20160407175759.GO32257@rob-hp-laptop>
Message-ID: <20160413201147.5621a17c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob,

On Thu, 7 Apr 2016 12:57:59 -0500 Rob Herring wrote:

> On Wed, Apr 06, 2016 at 03:28:00PM +0800, Jisheng Zhang wrote:
> > Sometimes, it's convenient to define the scl's high/low count directly,
> > e.g HW people would do some measurement then directly give out the
> > optimum counts. Previously, we solved the sda falling time and scl
> > falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put them
> > into dt, but what we really care isn't the sda/scl falling time.  
> 
> This is just so you can put specific clock count instead of converting 
> from nanoseconds with standard properties or you gain some additional 
> control of the timing. If only the former, then I prefer we stick with 
> the common properties.

To be honest, both. Let me show how I gain additional control of the timing
with this patch while I can't do this w/o it.

I want the similar high percent of SCL high for both standard-mode and
fast-mode. Before this patch, this is not achievable because the parameters
to cal the hcnt/lcnt via i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt() are different
for standard-mode and fast-mode.

Thanks,
Jisheng



> 
> > From another side, the dw_i2c_acpi_configure() on ACPI platform also
> > get hcnt/lcnt values rather than the sda/scl falling time from ACPI
> > method, we want similar feature for DT platforms.  
> 
> That's nice, but not really a reason IMO.
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 16 ++++++++++++++++
> >  drivers/i2c/busses/i2c-designware-platdrv.c              |  8 ++++++++
> >  2 files changed, 24 insertions(+)  
