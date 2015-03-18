From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Mar 2015 19:05:09 +0000
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150318190509.GM10863@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun,

On Wed, Mar 11, 2015 at 12:39:26PM +0000, Hanjun Guo wrote:
> This patch set already tested on multi platforms:
>  - AMD Seattle board;
>  - Cavium Thunder board;
>  - Huawei D02 board;
>  - Qualcomm ARM64 platform
> 
> This version 10 patch set address some minor comments and collect ACKs and
> Reviewed-bys for v9:
> 
>  - new Acks from Rafael, Olof, Grant, Lorenzo
>  - new way to handle typdef phys_cpuid_t which suggested by Rafael,
>    but no functional change
>  - Remove if(!phys) for early ioremappings
>  - Rework sleep function for ARM64
>  - Introduce linux/acpi_irq.h to hold acpi_irq_init()
>  - Disable ACPI if not HW_REDUCED_ACPI compliant
>  - Remove the doc of why ACPI on ARM

So I've had a look at the current state of this series and I think there
are a few immediate things left to do:

  (1) Resolve the acpi=force cmdline issue highlighted by Lorenzo and
      Catalin

  (2) I believe Sudeep and Lorenzo have concerns about patch 13 (SMP init),
      so I'm assuming there will be additional patches from them that are
      required.

  (3) I have an open comment about moving the IRQ domain code into the
      core, which I'd like to see addressed.

  (4) We need an ack from Daniel on the arch-timer patch

If you can get that in place, I'm not opposed to putting this into
linux-next ahead of the firmware summit in San Jose next week. Note that
this is not a commitment for 4.1, since I'm keen to see the outcomes of
next week before setting anything in stone.

Also, there's no need to repost patches if you're just adding Acks. I
think I'm up to speed with those on my local branch and the Tested-by
party is starting to look a little silly.

Will
