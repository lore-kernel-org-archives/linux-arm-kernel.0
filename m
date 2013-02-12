From: amit.virdi@st.com (Amit Virdi)
Date: Tue, 12 Feb 2013 18:08:36 +0530
Subject: ARM/Kernel: Problems with multiple VIC registration
In-Reply-To: <CACRpkdYMwijN_eE11wH-PxVazutfszBFni31_UX3PaFDcSeoUQ@mail.gmail.com>
References: <5110D55F.9040509@st.com>
 <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
 <5111D387.9040803@st.com>
 <CACRpkdYMwijN_eE11wH-PxVazutfszBFni31_UX3PaFDcSeoUQ@mail.gmail.com>
Message-ID: <511A37CC.8030600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 2/6/2013 2:45 PM, Linus Walleij wrote:
> On Wed, Feb 6, 2013 at 4:52 AM, Amit Virdi<amit.virdi@st.com>  wrote:
>> On 2/5/2013 9:57 PM, Linus Walleij wrote:
>>>
>>> On Tue, Feb 5, 2013 at 10:48 AM, Amit Virdi<amit.virdi@st.com>   wrote:
>>>
>>>> The first controller is registered throu' irq_domain_add_linear API. As a
>>>> result of this call, a new domain is allocated to the VIC device.
>>>
>>>
>>> This is a bug. Do you have this patch in your tree:
>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7611/1
>>
>> Yes, I have this patch (from rc2) and still the bug!
>
> You have to post your code for your SoC board support for us to help
> out.
>
> There are several things you can do wrong. For example a common mistake
> is to offset the IRQs on a new platform from zero. So that the first
> parameter to vic_init() is zero. This is not legal because Linux IRQ 0
> is NO_IRQ and shall not be used. If this is your problems, IRQs shall
> offset from something like 64 so you can even use SPARSE_IRQ.
>

Yes, I was using 0 as the first offset in IRQs and my IRQs were defined 
from 0 to n. I changed it to 1 to n+1 and I'm now not using 0. Every 
problem seems to have resolved now.

Thanks
Amit Virdi
