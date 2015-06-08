From: xose.vazquez@gmail.com (Xose Vazquez Perez)
Date: Mon, 08 Jun 2015 15:04:39 +0200
Subject: Generic kernel features that need architecture(arm) support
Message-ID: <557592E7.6000508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

If there is anything wrong, please report it in this thread:
https://marc.info/?t=143332955700003


The meaning of entries in the tables is:

    | ok |  # feature supported by the architecture
    |TODO|  # feature not yet supported by the architecture
    | .. |  # feature cannot be supported by the hardware

#
# Kernel feature support matrix of the 'arm' architecture:
#
     sched/ numa-balancing       :  ..  |        ARCH_SUPPORTS_NUMA_BALANCING #  arch supports NUMA balancing
        vm/ numa-memblock        :  ..  |              HAVE_MEMBLOCK_NODE_MAP #  arch supports NUMA aware memblocks
      core/ BPF-JIT              :  ok  |                        HAVE_BPF_JIT #  arch supports BPF JIT optimizations
      core/ generic-idle-thread  :  ok  |             GENERIC_SMP_IDLE_THREAD #  arch makes use of the generic SMP idle thread facility
      core/ jump-labels          :  ok  |                HAVE_ARCH_JUMP_LABEL #  arch supports live patched, high efficiency branches
      core/ tracehook            :  ok  |                 HAVE_ARCH_TRACEHOOK #  arch supports tracehook (ptrace) register handling APIs
     debug/ gcov-profile-all     :  ok  |           ARCH_HAS_GCOV_PROFILE_ALL #  arch supports whole-kernel GCOV code coverage profiling
     debug/ kgdb                 :  ok  |                      HAVE_ARCH_KGDB #  arch supports the kGDB kernel debugger
     debug/ kprobes              :  ok  |                        HAVE_KPROBES #  arch supports live patched kernel probe
     debug/ kretprobes           :  ok  |                     HAVE_KRETPROBES #  arch supports kernel function-return probes
     debug/ optprobes            :  ok  |                      HAVE_OPTPROBES #  arch supports live patched optprobes
     debug/ stackprotector       :  ok  |              HAVE_CC_STACKPROTECTOR #  arch supports compiler driven stack overflow protection
     debug/ uprobes              :  ok  |               ARCH_SUPPORTS_UPROBES #  arch supports live patched user probes
        io/ dma-api-debug        :  ok  |                  HAVE_DMA_API_DEBUG #  arch supports DMA debug facilities
        io/ dma-contiguous       :  ok  |                 HAVE_DMA_CONTIGUOUS #  arch supports the DMA CMA (continuous memory allocator)
        io/ dma_map_attrs        :  ok  |                      HAVE_DMA_ATTRS #  arch provides dma_*map*_attrs() APIs
        io/ sg-chain             :  ok  |                   ARCH_HAS_SG_CHAIN #  arch supports chained scatter-gather lists
   locking/ lockdep              :  ok  |                     LOCKDEP_SUPPORT #  arch supports the runtime locking correctness debug facility
      perf/ kprobes-event        :  ok  |      HAVE_REGS_AND_STACK_ACCESS_API #  arch supports kprobes with perf events
      perf/ perf-regs            :  ok  |                      HAVE_PERF_REGS #  arch supports perf events register access
      perf/ perf-stackdump       :  ok  |           HAVE_PERF_USER_STACK_DUMP #  arch supports perf events stack dumps
   seccomp/ seccomp-filter       :  ok  |            HAVE_ARCH_SECCOMP_FILTER #  arch supports seccomp filters
      time/ arch-tick-broadcast  :  ok  |             ARCH_HAS_TICK_BROADCAST #  arch provides tick_broadcast()
      time/ clockevents          :  ok  |                 GENERIC_CLOCKEVENTS #  arch support generic clock events
      time/ context-tracking     :  ok  |               HAVE_CONTEXT_TRACKING #  arch supports context tracking for NO_HZ_FULL
      time/ irq-time-acct        :  ok  |            HAVE_IRQ_TIME_ACCOUNTING #  arch supports precise IRQ time accounting
      time/ virt-cpuacct         :  ok  |            HAVE_VIRT_CPU_ACCOUNTING #  arch supports precise virtual CPU time accounting
        vm/ ELF-ASLR             :  ok  |              ARCH_HAS_ELF_RANDOMIZE #  arch randomizes the stack, heap and binary images of ELF binaries
        vm/ pmdp_splitting_flush :  ok  |    __HAVE_ARCH_PMDP_SPLITTING_FLUSH #  arch supports the pmdp_splitting_flush() VM API
        vm/ pte_special          :  ok  |             __HAVE_ARCH_PTE_SPECIAL #  arch supports the pte_special()/pte_mkspecial() VM APIs
        vm/ THP                  :  ok  |      HAVE_ARCH_TRANSPARENT_HUGEPAGE #  arch supports transparent hugepages
     debug/ KASAN                : TODO |                     HAVE_ARCH_KASAN #  arch supports the KASAN runtime memory checker
     debug/ kprobes-on-ftrace    : TODO |              HAVE_KPROBES_ON_FTRACE #  arch supports combined kprobes and ftrace live patching
     debug/ user-ret-profiler    : TODO |           HAVE_USER_RETURN_NOTIFIER #  arch supports user-space return from system call profiler
       lib/ strncasecmp          : TODO |             __HAVE_ARCH_STRNCASECMP #  arch provides an optimized strncasecmp() function
   locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
   locking/ queued-rwlocks       : TODO |             ARCH_USE_QUEUED_RWLOCKS #  arch supports queued rwlocks
   locking/ queued-spinlocks     : TODO |           ARCH_USE_QUEUED_SPINLOCKS #  arch supports queued spinlocks
   locking/ rwsem-optimized      : TODO |               Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
      time/ modern-timekeeping   : TODO |            !ARCH_USES_GETTIMEOFFSET #  arch does not use arch_gettimeoffset() anymore
        vm/ huge-vmap            : TODO |                 HAVE_ARCH_HUGE_VMAP #  arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
        vm/ ioremap_prot         : TODO |                   HAVE_IOREMAP_PROT #  arch has ioremap_prot()
        vm/ PG_uncached          : TODO |               ARCH_USES_PG_UNCACHED #  arch supports the PG_uncached page flag
