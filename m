From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 20 Jun 2017 14:03:35 -0500
Subject: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20170620144243.GB23750@n2100.armlinux.org.uk>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com>
 <20170620144243.GB23750@n2100.armlinux.org.uk>
Message-ID: <fdfa1059-17f7-74f7-4b88-2941af07a538@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 06/20/2017 09:42 AM, Russell King - ARM Linux wrote:
> On Fri, May 19, 2017 at 12:57:08PM -0500, Dave Gerlach wrote:
>> +	.arm
>> +	.align 3
>> +
>> +ENTRY(ti_emif_sram)
> 
> Will you ever want to have any of this code as Thumb?

I cannot see any requirement for that. I will say it is tested and
inter-operates happily with CONFIG_THUMB_KERNEL, but because it's constrained to
am335x and am437x I don't think there are unknown situations where every single
instruction must be THUMB.

> 
>> +extern inline void ti_emif_offsets(void)
>> +{
> 
> "extern inline" is frowned upon in the kernel - any reason this
> can't be "static inline" ?

It should be static.

> 
> Any reason not to provide a stub for when it's not configured,
> and eliminate the ifdef in arch/arm/kernel/asm-offsets.c ?
> 

No, I just was following the ifdef example set by others in the file, a stub
would be cleaner I agree.

Regards,
Dave
