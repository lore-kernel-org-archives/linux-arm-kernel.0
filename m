From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Apr 2015 15:27:15 +0900
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <20150407124209.GA12633@lunn.ch>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
 <20150407124209.GA12633@lunn.ch>
Message-ID: <CAK7LNAR0+Xi191BftRD7d=LFiU-n_8=KVEkX96TwrG6FVz2A=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,


2015-04-07 21:42 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
> On Tue, Apr 07, 2015 at 12:34:30PM +0900, Masahiro Yamada wrote:
>> Hello experts,
>> I hope this is the correct ML to ask this question.
>>
>> I am struggling to port Linux-4.0-rc7 onto my SoC/board,
>> based on ARM cortex-A9 (single CPU), but the kernel fails to boot
>> with the error:
>> "not syncing: Attempted to kill init! exitcode=0x00000004"
>>
>>
>> I want to use NS16550-compatible UART, Global Timer, and GIC.
>> I wrote a simple device tree source for my own board like this:
>>
>> ------------------>8------------------------------
>> /dts-v1/;
>> /include/ "skeleton.dtsi"
>>
>> / {
>>         compatible = "socionext,ph1-ld4";
>>
>>         memory {
>>                 device_type = "memory";
>>                 reg = <0x80000000 0x20000000>;
>>         };
>>
>>         chosen {
>>                 bootargs = "root=/dev/ram0 console=ttyS0,115200";
>>         };
>>
>>         aliases {
>>                 serial0 = &uart0;
>>         };
>>
>>         cpus {
>>                 #size-cells = <0>;
>>                 #address-cells = <1>;
>>
>>                 cpu at 0 {
>>                         device_type = "cpu";
>>                         compatible = "arm,cortex-a9";
>>                         reg = <0>;
>>                 };
>>         };
>>
>>         clocks {
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> [    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>> [    0.000000]       .text : 0xc0208000 - 0xc0d03b7c   (11247 kB)
>> [    0.000000]       .init : 0xc0d04000 - 0xc0dce000   ( 808 kB)
>> [    0.000000]       .data : 0xc0dce000 - 0xc0ecbde0   (1016 kB)
>> [    0.000000]        .bss : 0xc0ecbde0 - 0xc0f1aee8   ( 317 kB)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> [    0.000000] Hierarchical RCU implementation.
>> [    0.000000]  Additional per-CPU info printed with stalls.
>> [    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>> [    0.000000] GIC CPU mask not found - kernel will fail to boot.
>> [    0.000000] GIC CPU mask not found - kernel will fail to boot.
>
> I assume you have seen this, have taken a deeper look, and know it is
> not your issue?
>

According to Dennis's pointer (https://lkml.org/lkml/2013/7/12/173),
this message is a false alarm for Uni-processor implementation.

I guess it is not related to the problem I am having now.


-- 
Best Regards
Masahiro Yamada
