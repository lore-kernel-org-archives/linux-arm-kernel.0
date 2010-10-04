From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Oct 2010 20:30:58 +0100
Subject: [PATCH 03/10] ARM: hotplug cpu: Keep processor information,
	startup code & __lookup_processor_type
In-Reply-To: <4CAA2A2F.7010901@codeaurora.org>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
	<4CAA2A2F.7010901@codeaurora.org>
Message-ID: <20101004193058.GB25241@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 12:25:35PM -0700, Jeff Ohlstein wrote:
> Russell King - ARM Linux wrote:
>> When hotplug CPU is enabled, we need to keep the list of supported CPUs,
>> their setup functions, and __lookup_processor_type in place so that we
>> can find and initialize secondary CPUs.  Move these into the __CPUINIT
>> section.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>  arch/arm/kernel/head-common.S |   81 +++++++++++++++++++++++------------------
>>  arch/arm/kernel/vmlinux.lds.S |   24 +++++++++----
>>  arch/arm/mm/proc-arm1020e.S   |    2 +-
>>  arch/arm/mm/proc-arm1022.S    |    2 +-
>>  arch/arm/mm/proc-arm1026.S    |    2 +-
>>  arch/arm/mm/proc-arm6_7.S     |    2 +-
>>  arch/arm/mm/proc-arm720.S     |    2 +-
>>  arch/arm/mm/proc-arm740.S     |    2 +-
>>  arch/arm/mm/proc-arm7tdmi.S   |    2 +-
>>  arch/arm/mm/proc-arm920.S     |    2 +-
>>  arch/arm/mm/proc-arm922.S     |    2 +-
>>  arch/arm/mm/proc-arm925.S     |    2 +-
>>  arch/arm/mm/proc-arm926.S     |    2 +-
>>  arch/arm/mm/proc-arm940.S     |    2 +-
>>  arch/arm/mm/proc-arm946.S     |    2 +-
>>  arch/arm/mm/proc-arm9tdmi.S   |    2 +-
>>  arch/arm/mm/proc-fa526.S      |    2 +-
>>  arch/arm/mm/proc-feroceon.S   |    2 +-
>>  arch/arm/mm/proc-mohawk.S     |    2 +-
>>  arch/arm/mm/proc-sa110.S      |    2 +-
>>  arch/arm/mm/proc-sa1100.S     |    2 +-
>>  arch/arm/mm/proc-v6.S         |    6 +++-
>>  arch/arm/mm/proc-v7.S         |    6 +++-
>>  arch/arm/mm/proc-xsc3.S       |    2 +-
>>  arch/arm/mm/proc-xscale.S     |    2 +-
>>  25 files changed, 93 insertions(+), 66 deletions(-)
>>
> Any reason you skipped proc-arm1020.S?

Either it wasn't found by $(grep -l __INIT arch/arm/mm/proc*.S) or
I missed committing that file.

PS, no need to include all that context.  You're lucky to get a reply as
I normally end up giving up after a few pages of pure context.
