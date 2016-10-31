From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 31 Oct 2016 08:16:43 +0000
Subject: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
In-Reply-To: <954adfa7-94d9-f785-aeab-6f20c8f4c3b9@kernel.org>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com>
 <20160927194045.GK21388@dell>
 <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
 <20161026121730.GS8574@dell>
 <954adfa7-94d9-f785-aeab-6f20c8f4c3b9@kernel.org>
Message-ID: <20161031081643.GN13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 30 Oct 2016, Jonathan Cameron wrote:

> On 26/10/16 13:17, Lee Jones wrote:
> > On Fri, 30 Sep 2016, Mugunthan V N wrote:
> > 
> >> On Wednesday 28 September 2016 01:10 AM, Lee Jones wrote:
> >>> On Wed, 21 Sep 2016, Mugunthan V N wrote:
> >>>
> >>>> store the physical address of the device in its priv to use it
> >>>> for DMA addressing in the client drivers.
> >>>>
> >>>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> >>>> ---
> >>>>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
> >>>>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
> >>>>  2 files changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> >>>> index c8f027b..0f3fab4 100644
> >>>> --- a/drivers/mfd/ti_am335x_tscadc.c
> >>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
> >>>> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >>>>  		tscadc->irq = err;
> >>>>  
> >>>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>> +	tscadc->tscadc_phys_base = res->start;
> >>>
> >>> This is unusual.  Can't you use a virt_to_phys() variant instead?
> >>>
> >>
> >> I tried using virt_to_phys(), but its not working for me.
> >> Also saw many drivers uses like this to get physical address
> >> ("git grep -n " res->start;" drivers/*").
> > 
> > Very well:
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Let me know how you wish this set to be handled.
> I'm happy to pick up the whole series.  There are some more mfd
> header changes in patch 2 but as they only add defines, I
> don't mind that much if I don't an Ack from you on those
> (btw this got to V3 but as patch 1 didn't change I'll carry
> your ack forwards).
> 
> Do you want an immutable branch?  Seems unlikely to cause
> much trouble even if there is a merge issue on all 10ish
> lines of mfd code in the next merge window.

Not at the moment, but if you could set things up so it's possible to
create one at a later date if things go Pete Tong, that would be
great.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
