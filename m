From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Sat, 25 Mar 2017 12:18:38 +0900
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <20170323105456.GB9287@leverpostej>
References: <01822423-a46e-842a-e21e-07d4b9af7f1e@riken.jp>
 <20170323105456.GB9287@leverpostej>
Message-ID: <103308db-852c-167b-f16b-40348c1d9b8a@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/03/23 19:54, Mark Rutland wrote:
> On Fri, Mar 17, 2017 at 11:11:47AM +0900, Itaru Kitayama wrote:
>> I've tried your branch on Mustang. It does boot, but perf doesn't
>> list hardware events.
>
> Can you please dump the dmesg here?

I think this time I booted into correctly the kernel based upon your 
branch and got a proper set of events.

> What exactly do you see if you run:
>
> $ perf list

   branch-misses                                      [Hardware event]
   cache-misses                                       [Hardware event]
   cache-references                                   [Hardware event]
   cpu-cycles OR cycles                               [Hardware event]
   instructions                                       [Hardware event]
   alignment-faults                                   [Software event]
   bpf-output                                         [Software event]
   context-switches OR cs                             [Software event]
   cpu-clock                                          [Software event]
   cpu-migrations OR migrations                       [Software event]
   dummy                                              [Software event]
   emulation-faults                                   [Software event]
   major-faults                                       [Software event]
   minor-faults                                       [Software event]
   page-faults OR faults                              [Software event]
   task-clock                                         [Software event]
   L1-dcache-load-misses                              [Hardware cache event]
   L1-dcache-loads                                    [Hardware cache event]
   L1-dcache-store-misses                             [Hardware cache event]
   L1-dcache-stores                                   [Hardware cache event]
   L1-icache-load-misses                              [Hardware cache event]
   L1-icache-loads                                    [Hardware cache event]
   branch-load-misses                                 [Hardware cache event]
   branch-loads                                       [Hardware cache event]
   dTLB-load-misses                                   [Hardware cache event]
   iTLB-load-misses                                   [Hardware cache event]
   armv8_pmuv3_0/br_mis_pred/                         [Kernel PMU event]
   armv8_pmuv3_0/br_pred/                             [Kernel PMU event]
   armv8_pmuv3_0/bus_access/                          [Kernel PMU event]
   armv8_pmuv3_0/cid_write_retired/                   [Kernel PMU event]
   armv8_pmuv3_0/cpu_cycles/                          [Kernel PMU event]
   armv8_pmuv3_0/exc_return/                          [Kernel PMU event]
   armv8_pmuv3_0/exc_taken/                           [Kernel PMU event]
   armv8_pmuv3_0/inst_retired/                        [Kernel PMU event]
   armv8_pmuv3_0/inst_spec/                           [Kernel PMU event]
   armv8_pmuv3_0/l1d_cache/                           [Kernel PMU event]
   armv8_pmuv3_0/l1d_cache_refill/                    [Kernel PMU event]
   armv8_pmuv3_0/l1d_cache_wb/                        [Kernel PMU event]
   armv8_pmuv3_0/l1d_tlb_refill/                      [Kernel PMU event]
   armv8_pmuv3_0/l1i_cache/                           [Kernel PMU event]
   armv8_pmuv3_0/l1i_cache_refill/                    [Kernel PMU event]
   armv8_pmuv3_0/l1i_tlb_refill/                      [Kernel PMU event]
   armv8_pmuv3_0/l2d_cache/                           [Kernel PMU event]
   armv8_pmuv3_0/l2d_cache_refill/                    [Kernel PMU event]
   armv8_pmuv3_0/l2d_cache_wb/                        [Kernel PMU event]
   armv8_pmuv3_0/mem_access/                          [Kernel PMU event]
   armv8_pmuv3_0/memory_error/                        [Kernel PMU event]
   armv8_pmuv3_0/sw_incr/                             [Kernel PMU event]
   armv8_pmuv3_0/ttbr_write_retired/                  [Kernel PMU event]
   rNNN                                               [Raw hardware 
event descriptor]
   cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware 
event descriptor]
   mem:<addr>[/len][:access]                         [Hardwarebreakpoint]

I've verified this on an APM Mustang with the FW 3.06.25.

Itaru
