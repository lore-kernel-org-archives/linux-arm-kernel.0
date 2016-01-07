From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 7 Jan 2016 15:45:15 +0000
Subject: [PATCH] arm64/dts: Add missing DMA Abort interrupt to Juno
In-Reply-To: <2736927.0LiVxGZzgm@wuerfel>
References: <6a66d2ac442925e066fe9b67ee2883de5894b0d3.1452168063.git.robin.murphy@arm.com>
 <2736927.0LiVxGZzgm@wuerfel>
Message-ID: <568E880B.2090602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/16 14:36, Arnd Bergmann wrote:
> On Thursday 07 January 2016 12:01:59 Robin Murphy wrote:
>> The DMA-330 has an "irq_abort" interrupt line on which it signals faults
>> separately from the "irq[n:0]" channel interrupts. On Juno, this is
>> wired up to SPI 92; add it to the DT so that DMAC faults are correctly
>> reported for the driver to reset the thing, rather than leaving it
>> locked up and waiting to time out.
>>
>> CC: Liviu Dudau <liviu.dudau@arm.com>
>> CC: Sudeep Holla <sudeep.holla@arm.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>
> Nothing wrong with the patch, but could you please come up with
> a more structured way to get patches for Juno into the kernel?
>
> You have addressed the patch "to:" the arm-soc maintainers, but
> you are not listed in the maintainers file for the directory, so
> it's not clear what you expect to happen here.

I'll admit I got to the addressing point and wasn't entirely sure either 
- there still seemed to be a precedent of patches going to arm-soc 
picking up acks along the way, rather than via a sub-maintainer pull, 
hence what I ended up with.

> Ideally, we'd get patches from just one of the people listed
> in the MAINTAINERS file normally, and let us know if the
> primary maintainer changes, or if one of the others sends a
> patch because that person is unavailable.

Sure, I'll bear that in mind in future, especially when sending from an 
email domain which doesn't really make clear the context that I'm just 
another end-user posting a fix for something I found, rather than trying 
to assume any "official" capacity ;)

As a side note, the Juno dts* files don't actually seem to be covered by 
MAINTAINERS at all, which can't help the situation.

Sorry for the confusion,
Robin.
