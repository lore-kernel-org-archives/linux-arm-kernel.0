From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Tue, 12 Aug 2014 11:27:42 +0800
Subject: [PATCH] arch: Kconfig: Let all little endian architectures define
 CPU_LITTLE_ENDIAN explicitly
In-Reply-To: <20140811225326.GF30401@n2100.arm.linux.org.uk>
References: <53E93334.5000205@gmail.com>
 <20140811225326.GF30401@n2100.arm.linux.org.uk>
Message-ID: <53E989AE.7070808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/12/14 6:53, Russell King - ARM Linux wrote:
> On Tue, Aug 12, 2014 at 05:18:44AM +0800, Chen Gang wrote:
>> x86, ia64, and arm(64) are little endian, and also another architectures
>> may be little endian (mips, sh, powerpc, and m32r) which already marked
>> CPU_LITTLE_ENDIAN explicitly.
> 
> This is incorrect.  ARM can be either endian.
> 
> arch/arm/mm/Kconfig:
> 
> config CPU_BIG_ENDIAN
>         bool "Build big-endian kernel"
>         depends on ARCH_SUPPORTS_BIG_ENDIAN
>         help
>           Say Y if you plan on running a kernel in big-endian mode.
>           Note that your board must be properly built and your board
>           port must properly enable any big-endian related features
>           of your chipset/board/processor.
> 

OK, thanks, I shall check all CPU_BIG_ENDIAN and send patch v2 for it.

And still welcome another ideas, suggestions or completions, especially
for another architectures.


Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
