From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Feb 2013 10:15:45 +0100
Subject: ARM/Kernel: Problems with multiple VIC registration
In-Reply-To: <5111D387.9040803@st.com>
References: <5110D55F.9040509@st.com>
 <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
 <5111D387.9040803@st.com>
Message-ID: <CACRpkdYMwijN_eE11wH-PxVazutfszBFni31_UX3PaFDcSeoUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 6, 2013 at 4:52 AM, Amit Virdi <amit.virdi@st.com> wrote:
> On 2/5/2013 9:57 PM, Linus Walleij wrote:
>>
>> On Tue, Feb 5, 2013 at 10:48 AM, Amit Virdi<amit.virdi@st.com>  wrote:
>>
>>> The first controller is registered throu' irq_domain_add_linear API. As a
>>> result of this call, a new domain is allocated to the VIC device.
>>
>>
>> This is a bug. Do you have this patch in your tree:
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7611/1
>
> Yes, I have this patch (from rc2) and still the bug!

You have to post your code for your SoC board support for us to help
out.

There are several things you can do wrong. For example a common mistake
is to offset the IRQs on a new platform from zero. So that the first
parameter to vic_init() is zero. This is not legal because Linux IRQ 0
is NO_IRQ and shall not be used. If this is your problems, IRQs shall
offset from something like 64 so you can even use SPARSE_IRQ.

Yours,
Linus Walleij
