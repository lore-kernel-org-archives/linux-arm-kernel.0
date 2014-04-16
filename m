From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 16 Apr 2014 09:42:11 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <20140416101243.GA6952@n2100.arm.linux.org.uk>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140416101243.GA6952@n2100.arm.linux.org.uk>
Message-ID: <CADHgK6vyWU1HCueN=F5D0JxzknV==h-jOG9JmcXeOrH_RGV4JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2014 03:12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Mar 05, 2014 at 02:50:05AM -0800, Sebastian Capella wrote:
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index 8756e4b..d32adbb 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -291,6 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>   */
>>  #define __pa(x)                      __virt_to_phys((unsigned long)(x))
>>  #define __va(x)                      ((void *)__phys_to_virt((phys_addr_t)(x)))
>> +#define __pa_symbol(x)               __pa((unsigned long)(x))
>>  #define pfn_to_kaddr(pfn)    __va((pfn) << PAGE_SHIFT)
>
> I don't see the appropriate version on the mailing list, so I'll comment
> here instead.  In 8011/1, you added here:
>
> +#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
>
> which conflicts with my solution (which fixes some rather horrid assembly
> code).  You can find my change as e26a9e00afc4 (ARM: Better virt_to_page()
> handling).  I can drop this from your patch, but it would be a good idea
> if you could re-validate against v3.15-rc1.

Hi Russell,

Thanks!  I'll validate it with e26a9e00afc4 added to my 3.13
hibernation branch, which includes the OMAP patches, and post the
results.  I can also verify against 3.15-rc1 + hibernation patches,
but there's not much to be done, other than compile test, as the
platform support is not there yet.  I can try rebasing the OMAP stuff
to v3.15-rc1, but I'm not sure what to expect out of that.

In any event, I'll let you know.

Thanks!

Sebastian
