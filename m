From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 9 Jul 2012 18:21:45 -0500
Subject: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
In-Reply-To: <873950x4ng.fsf@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
 <873950x4ng.fsf@ti.com>
Message-ID: <4FFB6789.2000100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

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
> 
> This driver is used on OMAP1 as well as OMAP2+.  
> 
> The cover letter says this was only build tested on OMAP1 so I suggest
> this actually be tested on OMAP1 before merging.

I have tested this on an omap5912 osk. I booted and verified that the
offset is good.

Santosh, add my tested-by for OMAP1 ...

Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
