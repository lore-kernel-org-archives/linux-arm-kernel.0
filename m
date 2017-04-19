From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 16:09:16 +0100
Subject: [PATCH v24 08/11] acpi: Introduce acpi_unregister_irq function
In-Reply-To: <20170418155841.GK17866@leverpostej>
References: <20170414184014.8524-1-fu.wei@linaro.org>
 <20170414184014.8524-9-fu.wei@linaro.org>
 <20170418155841.GK17866@leverpostej>
Message-ID: <20170419150916.GI27829@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 04:58:41PM +0100, Mark Rutland wrote:
> On Sat, Apr 15, 2017 at 02:40:11AM +0800, fu.wei at linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> > 
> > This patch introduces acpi_unregister_irq function to free a
> > linux IRQ number<->GSI mapping by a given linux IRQ number.
> > 
> > Even we have successfully registered the GSI, when some error occurs, we
> > may need to unmap it for freeing the IRQ resource. But in some cases, we
> > only have IRQ, but not GSI.
> > 
> > This patch is the preparation for memory-mapped timer support in GTDT
> > driver.
> > 
> > Signed-off-by: Fu Wei <fu.wei@linaro.org>
> > ---
> >  drivers/acpi/irq.c   | 10 ++++++++++
> >  include/linux/acpi.h |  7 +++++++
> >  2 files changed, 17 insertions(+)
> 
> This will need comments/acks from the ACPI folk.

I've now reworked the cleanup to not require this API, and will drop
this patch.

Thanks,
Mark.
