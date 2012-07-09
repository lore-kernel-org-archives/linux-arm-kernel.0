From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 9 Jul 2012 18:52:21 -0500
Subject: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
In-Reply-To: <873950x4ng.fsf@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <873950x4ng.fsf@ti.com>
Message-ID: <4FFB6EB5.8020306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/09/2012 11:47 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> OMAP socs has a legacy and a highlander version of the
>> 32k sync counter IP. The register offsets vary between the
>> highlander and the legacy scheme. So use the 'SCHEME'
>> bits(30-31) of the revision register to distinguish between
>> the two versions and choose the CR register offset accordingly.
> 
> Do these scheme bits exist on *all* OMAPs?  including OMAP1?

By the way, I believe that for early devices only the lower 8-bits were
used and the upper bits return 0. For OMAP5912 I read 0x00000010 from
the REV register and so this change should be safe for OMAP1 devices.

Cheers
Jon
