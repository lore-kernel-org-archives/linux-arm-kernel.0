From: robherring2@gmail.com (Rob Herring)
Date: Tue, 06 Mar 2012 16:49:24 -0600
Subject: [PATCH v5 5/7] ARM: ixp4xx: use runtime ioremap hook
In-Reply-To: <20120306221152.GC15201@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
 <1331070317-9598-5-git-send-email-robherring2@gmail.com>
 <20120306221152.GC15201@n2100.arm.linux.org.uk>
Message-ID: <4F569474.5090706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 04:11 PM, Russell King - ARM Linux wrote:
> On Tue, Mar 06, 2012 at 03:45:15PM -0600, Rob Herring wrote:
>> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
>> index a6329a0..c60e7b8 100644
>> --- a/arch/arm/mach-ixp4xx/common.c
>> +++ b/arch/arm/mach-ixp4xx/common.c
>> @@ -31,6 +31,7 @@
>>  
>>  #include <mach/udc.h>
>>  #include <mach/hardware.h>
>> +#include <mach/io.h>
> 
> I'll assume you have a good reason for this, inspite of there being
> no mention of it in the commit log...

To explicitly pick up is_pci_address(). Yes, it gets implicitly
included, but that could change (hopefully).

Rob
