From: khilman@ti.com (Kevin Hilman)
Date: Wed, 19 Jan 2011 13:38:24 -0800
Subject: [PATCH v2] OMAP: use fncpy to copy the PM code functions to SRAM
In-Reply-To: <87vd1ksq2i.fsf@ti.com> (Kevin Hilman's message of "Wed, 19 Jan
	2011 10:31:33 -0800")
References: <1295352126-29171-1-git-send-email-j-pihet@ti.com>
	<87vd1ksq2i.fsf@ti.com>
Message-ID: <87mxmwr2un.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The new fncpy API is better suited for copying some
>> code to SRAM at runtime. This patch changes the ad-hoc
>> code to the more generic fncpy API.
>>
>> Tested OK on OMAP3 in low power modes (RET/OFF)
>> using omap2plus_defconfig with !CONFIG_THUMB2_KERNEL.
>> Compile tested on OMAP1/2 using omap1_defconfig.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Boot tested on OMAP1 & OMAP2 as well.  Note that neither OMAP1 or OMAP2
> has had working suspend/resume for a long time now, so I did not test
> suspend/resume.

For OMAP2:

Tested-by: Kevin Hilman <khilman@ti.com>

to test a little more on OMAP2, I just removed the WFI from the
low-level code and tested suspend that way.  That's enough to be sure
the copied code is copied and executed.

Worked fine on OMAP2420/n810.

For OMAP1, this didn't work and would require more serious hacking on
the OMAP1 suspend path, which I currently have no plans to do.

Kevin
