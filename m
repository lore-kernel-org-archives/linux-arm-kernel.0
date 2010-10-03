From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Oct 2010 17:20:21 +0100
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <4CA8A06B.3070103@eukrea.com>
References: <4CA739B4.1020506@eukrea.com>
	<20101003114103.GC32736@n2100.arm.linux.org.uk>
	<4CA8A06B.3070103@eukrea.com>
Message-ID: <20101003162021.GD32736@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 03, 2010 at 05:25:31PM +0200, Eric B?nard wrote:
> Hi Russell,
>
> Le 03/10/2010 13:41, Russell King - ARM Linux a ?crit :
>> The common theme here looks like instruction cache corruption in
>> default_idle() - iow, the CPU isn't executing the code which is in
>> memory.
>>
> thanks for the analysis.
> This problem seems to be related to the ARM11 bug described in page 4 of  
> this PDF :
> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf?fpsp=1
>
> ENGcm09472 ARM: WFI and interrupt problems
>
> Description:
> There are two issues:
> ? The behavior of the FIQ signal to the ARM11 core can cause a problem  
> when exiting WFI mode.

Are you using FIQs?  The kernel normally uses IRQs unless you explicitly
do something that with FIQs.
