From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 7 Jul 2014 17:20:27 +0530
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
In-Reply-To: <20140707110249.GO28884@atomide.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
 <20140617131935.GB9070@saruman.home> <20140701194704.GG13396@saruman.home>
 <20140702081142.GU28884@atomide.com> <20140707104727.GM28884@atomide.com>
 <20140707104944.GS3705@n2100.arm.linux.org.uk>
 <20140707110249.GO28884@atomide.com>
Message-ID: <53BA8983.3030803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 July 2014 04:32 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140707 03:51]:
>> On Mon, Jul 07, 2014 at 03:47:27AM -0700, Tony Lindgren wrote:
>>> That's now merged into v3.16-rc4, so applying this into
>>> omap-for-v3.16/fixes.
>>
>> I intentionally left the warning in the hope that someone would update
>> it to write to the register.
>>
>> From the comments in the patch, it seems that firmware doesn't provide
>> a method to do that, which is a tad annoying.
> 
> So it seems.. Santosh, might be worth checking if this is set
> up the same way for all omaps? Or do some have extra commands
> for OMAP4_MON_L2X0_*  for ROM code calls?

OMAP4430 had L2 cache controller version r2p0 (per the public TRM) which
does not have this register. So unless there is a ROM API that was
introduced after OMAP4430, this would not be there even for other
OMAP4s. Public TRM of OMAP4470 does not indicate an API for this.

Before creating the patch, I checked with ROM team handling AM437x and
they denied an API to write to this register was present in AM437x ROM.

Thanks,
Sekhar
