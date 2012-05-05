From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 05 May 2012 19:16:50 +0200
Subject: [PATCH] ARM: move
 =?UTF-8?Q?read=5F=7Bboot=2C=20persistent=7D=5Fclock?=
 =?UTF-8?Q?=20to=20the=20architecture=20level?=
In-Reply-To: <20120505164753.GP897@n2100.arm.linux.org.uk>
References: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
 <20120505164753.GP897@n2100.arm.linux.org.uk>
Message-ID: <f91fc31ded5595a14101dffb4cab937f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 May 2012 17:47:53 +0100, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Apr 28, 2012 at 01:45:45PM +0100, Marc Zyngier wrote:
>> At the moment, read_persistent_clock is implemented at the
>> platform level, which makes it impossible to compile these
>> platforms in a single kernel.
>> 
>> Implement these two functions at the architecture level, and
>> provide a thin registration interface for both read_boot_clock
>> and read_persistent_clock. The two affected platforms (OMAP and
>> Tegra) are converted at the same time.
>> 
>> Compile tested only.
> 
> As this now has tested-bys for OMAP and Tegra, I guess it's ready. 
Who's
> planning to take this?

If you're happy to take it, and unless someone objects to it, I'll put it
in the patch system.

Thanks Stephen and Tony for testing it.

        M.
-- 
Fast, cheap, reliable. Pick two.
