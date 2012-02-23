From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 11:38:01 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <4F462444.8060406@st.com>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <20120223095345.GJ22562@n2100.arm.linux.org.uk> <4F461A97.1090201@st.com>
 <20120223111906.GS22562@n2100.arm.linux.org.uk> <4F462444.8060406@st.com>
Message-ID: <20120223113801.GV22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:04:28PM +0530, Pratyush Anand wrote:
> On 2/23/2012 4:49 PM, Russell King - ARM Linux wrote:
>> On Thu, Feb 23, 2012 at 04:23:11PM +0530, Viresh Kumar wrote:
>>> On 2/23/2012 3:23 PM, Russell King - ARM Linux wrote:
>>>> 1. Using the PCI/ISA IO macros for non-PCI/ISA IO purposes is silly
>>>
>>> We mistakenly placed it outside #ifdef __io, #endif
>>> Sorry, i am still missing your point.
>>
>> inb() et.al. are for PCI/ISA IO, not for general platform MMIO.
>>
>
> Ok.. So, will it be fine if we keep it outside #ifdef __io and do not  
> use __io macro in their implementation?

No, I refuse to add another set of accessors to ARMs io.h.  They're private
to PPC - it even says so in their header file.  They should not have leaked
out of PPC.

The fact that 73 drivers in the kernel source use their accessors is their
problem to solve.
