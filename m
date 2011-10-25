From: khilman@ti.com (Kevin Hilman)
Date: Tue, 25 Oct 2011 15:36:10 +0200
Subject: [PATCH] ARM: remove NR_IRQS dependency for ARM-specific
	HARDIRQ_BITS definition
In-Reply-To: <alpine.LFD.2.02.1110251343580.31312@xanadu.home> (Nicolas
	Pitre's message of "Tue, 25 Oct 2011 13:45:27 +0200 (CEST)")
References: <1319541948-10035-1-git-send-email-khilman@ti.com>
	<alpine.LFD.2.02.1110251343580.31312@xanadu.home>
Message-ID: <87wrbtnqgl.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 25 Oct 2011, Kevin Hilman wrote:
>
>> As a first step towards removing NR_IRQS, remove the ARM customization
>> of HARDIRQ_BITS based on NR_IRQS.
>> 
>> The generic code in <linux/hardirq.h> already has a default value of
>> 10 for HARDIRQ_BITS which is the max used on ARM, so let's just remove
>> the NR_IRQS based customization and use the generic default.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks.

FYI, this is now in Russell's patch system as 7140/1:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7140/1

Kevin
