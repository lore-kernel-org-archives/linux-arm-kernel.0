From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 23 Feb 2012 17:04:28 +0530
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <20120223111906.GS22562@n2100.arm.linux.org.uk>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <20120223095345.GJ22562@n2100.arm.linux.org.uk> <4F461A97.1090201@st.com>
 <20120223111906.GS22562@n2100.arm.linux.org.uk>
Message-ID: <4F462444.8060406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2012 4:49 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 23, 2012 at 04:23:11PM +0530, Viresh Kumar wrote:
>> On 2/23/2012 3:23 PM, Russell King - ARM Linux wrote:
>>> 1. Using the PCI/ISA IO macros for non-PCI/ISA IO purposes is silly
>>
>> We mistakenly placed it outside #ifdef __io, #endif
>> Sorry, i am still missing your point.
>
> inb() et.al. are for PCI/ISA IO, not for general platform MMIO.
>

Ok.. So, will it be fine if we keep it outside #ifdef __io and do not 
use __io macro in their implementation?

>>> 2. We should have readb_be() etc instead.
>>
>> Actually, existing drivers are using out_be32(), etc in their implementation.
>> What do you suggest in order to use these drivers for SPEAr/ARM.
>
> Which drivers?
> .
>

We have used these macros in dwc_otg driver, which is still to be added 
in the main line , but is under discussion.

http://comments.gmane.org/gmane.linux.usb.general/53348

However, I do see that these macros have been used in several mainline 
driver also, e.g. drivers/usb/gadget/fsl_qe_udc.c.

Regards
Pratyush
