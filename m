From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 20 Dec 2014 21:01:06 +0200
Subject: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
In-Reply-To: <8712967.RZO6JKCTcJ@vostro.rjw.lan>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <1649547.QECLmuJenN@avalon> <8712967.RZO6JKCTcJ@vostro.rjw.lan>
Message-ID: <3922440.p7KFeqxHrO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Friday 19 December 2014 03:27:35 Rafael J. Wysocki wrote:
> On Thursday, December 18, 2014 11:28:58 PM Laurent Pinchart wrote:
> > Hi Kevin,
> 
> [cut]
> 
>>>>> It would be better to be able to reference count the DMA engine from
>>>>> the bus master IMO and arguably you can use the runtime PM framework
>>>>> for that. Namely, give bus masters someting like
>>>>> 
>>>>> 	pm_runtime_get_my_DMA_engine(bus_master_device)
>>>>> 	pm_runtime_put_my_DMA_engine(bus_master_device)
>>>>> 
>>>>> and let them call these as they see fit.
>>>> 
>>>> Please note that we're not talking about DMA engines here, but about
>>>> IOMMUs. DMA is involved through the DMA mapping API which hides the
>>>> IOMMU completely from the bus master drivers, not the DMA engine API.
>>>> 
>>>> Exposing the IOMMU is something we want to avoid, but DMA mapping
>>>> start/stop operations could certainly be implemented.
>>> 
>>> The problem with that is it only solves the IOMMU problem.  We have a
>>> more generic PM dependency problem of which this IOMMU example is only a
>>> subset, so I think we need a more generic solution.
>> 
>> I agree that a more generic solution is needed at least to support ACPI
>> _DEP, but that might not be optimal in the IOMMU use case as explained
>> above.
>
> Well, since we need it anyway, why don't we implement it and then figure out
> if anything more specific needs to be done for the IOMMU case?

Patches are welcome ;-)

-- 
Regards,

Laurent Pinchart
