From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Oct 2010 08:36:19 -0500
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <20101027090921.GB8554@pengutronix.de>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>	<20101027082958.GA6797@angua.secretlab.ca>
	<20101027090921.GB8554@pengutronix.de>
Message-ID: <4CC82AD3.6090300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2010 04:09 AM, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Wed, Oct 27, 2010 at 09:29:59AM +0100, Grant Likely wrote:
>>> ---
>>>   arch/arm/plat-mxc/include/mach/iomux-mx53.h |  301 +++++++++++++++++++
>>>   arch/arm/plat-mxc/include/mach/mx53.h       |  433 +++++++++++++++++++++++++++
>>
>> Hi Dinh.
>>
>> In general, these definitions should not be added until they are
>> actually needed by driver code.
> ack.
>
>> Also, from my understanding, the mx53 is very similar to the mx51.
>> If I'm correct, then they should be sharing the same set of #defines.
> Note, I asked for a seperate header file.  See
> http://thread.gmane.org/gmane.linux.kernel/1051001/focus=1051352
>
>> What is the diff between *mx51.h and *mx53.h?
> Just from a quick look at least some base addresses are different.
> (e.g. MX51_DEBUG_BASE_ADDRESS = 0x60000000, MX53_DEBUG_BASE_ADDRESS =
> 0x40000000; SPBA0, AIPS1 and AIPS2 differ, too)

It is quite simple for these buses. Subtract 0x20000000 from MX51 
address and you have the MX53 address. MX53 has some additional 
peripherals, but otherwise the common peripherals are all at the same 
relative offsets. A 3rd MX5 derivative also has the same memory map as 
MX53 with slightly different peripheral mix.

Rob
