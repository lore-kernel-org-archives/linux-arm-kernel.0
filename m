From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Sat, 18 Jan 2014 13:32:21 +0530
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <20140116134550.GA7496@arm.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <20140116134550.GA7496@arm.com>
Message-ID: <CALicx6tQu2O8o4pr-N8Xc=D-Y9kOMsFNsn6BLVDqRo0Pbay00Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Jan 16, 2014 at 7:15 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Dec 19, 2013 at 11:50:48AM +0000, vijay.kilari at gmail.com wrote:
>> Vijaya Kumar K (3):
>>   AArch64: KGDB: Add Basic KGDB support
>>   AArch64: KGDB: Add step debugging support
>>   KGDB: make kgdb_breakpoint() as noinline
>
> I gave them a try and now I have some doubts about your testing
> methodology:
>
> 1. There is no HAVE_ARCH_KGDB anywhere in these patches, so
> the code here isn't compiled.
>
OK, I will send a patch

> 2. There are several compiler warnings that need to be addressed.
>
> 3. I enabled CONFIG_KGDB_TESTS and CONFIG_KGDB_TESTS_ON_BOOT and that's
> what really scared me.
>

Are you refering to these warning?. I don't see any warning in the
patched files. I will fix these.

drivers/misc/kgdbts.c: In function 'check_single_step':
drivers/misc/kgdbts.c:353:2: warning: format '%lx' expects argument of
type 'long unsigned int', but argument 2 has type 'u64' [-Wformat]
drivers/misc/kgdbts.c:379:3: warning: format '%lx' expects argument of
type 'long unsigned int', but argument 2 has type 'u64' [-Wformat]
drivers/misc/kgdbts.c: In function 'emul_sstep_put':
drivers/misc/kgdbts.c:494:3: warning: format '%lx' expects argument of
type 'long unsigned int', but argument 2 has type 'u64' [-Wformat]
kernel/debug/debug_core.c: In function 'kgdb_cpu_enter':
kernel/debug/debug_core.c:498:4: warning: value computed is not used
[-Wunused-value]
kernel/debug/debug_core.c:513:5: warning: value computed is not used
[-Wunused-value]

> Please address these before we can consider the patches for merging.
>
> --
> Catalin
