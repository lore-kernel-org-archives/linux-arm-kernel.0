From: bhaskarbudiredla@gmail.com (Bhaskara rao Budiredla)
Date: Tue, 21 Apr 2015 00:23:17 +0530
Subject: Programming the boundary between Inner and Outer caches on ARM
 architecture
In-Reply-To: <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
References: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
 <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
Message-ID: <CAJWVF-xvca0MpKF1=GoyyffGTzxtvy_LoaZfjhwU27vSuyOHFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin - The above said desired configuration was with respect to
a specific requirement of mine on Cortex A15. Seems it is confusing.
Let me give you the complete details. Along with PRRR/NMRR registers,
I am using [TEX[0], C, B] to configure the memory system attributes.
The inner cacheable attribute of NMRR normal memory region is
"write-back, write-allocate" and the corresponding outer cacheable
attribute is "write-back, no write-allocate". Since the lowest level
(level zero) cache defaults to inner cacheable attribute and the
highest level (level two) defaults to outer cacheable attribute, level
one cache is the remaining that I need to program explicitly. Hence
the requirement to configure the boundary between the inner and outer
cacheable attributes to group the level one cache either with level
zero (or) level two.

1. I am unable to find the register name that can be used for the
above said purpose from Cortex A15 documentation. Please help me in
providing that register details, if there is any such register (or)
some other procedure by which the same can be achieved.
2. Configuration of the boundary between inner and outer caches is not
needed for a system where in the inner and outer cacheable attributes
are same. Does the current Linux kernel for ARM architecture assumes
this?

NOTE: The Normal memory of PRRR in my case is configured as Outer Shareable.

Thanks,
Bhaskara

On Mon, Apr 20, 2015 at 3:31 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Apr 09, 2015 at 09:45:08PM +0530, Bhaskara rao Budiredla wrote:
>> Hi - can someone please provide the register details to configure the
>> boundary between Inner and Outer caches? In a three level cache
>> system, it is desired to apply Inner cacheable attributes to level 1
>> cache and Outer cacheable attributes to level two & level three
>> caches.
>
> Who told you that?
>
> --
> Catalin



-- 
.
