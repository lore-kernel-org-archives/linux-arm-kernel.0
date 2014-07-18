From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Jul 2014 09:40:30 +0100
Subject: HYP panic with 3.16-rc5, arm64 + 64k pages
In-Reply-To: <53C8086E.5060903@amd.com>
References: <20140717152808.GO21153@arm.com>
 <53C8086E.5060903@amd.com>
Message-ID: <20140718084030.GA9548@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel, Don,

On Thu, Jul 17, 2014 at 06:31:26PM +0100, Joel Schopp wrote:
> 
> On 07/17/2014 10:28 AM, Will Deacon wrote:
> > Initializing cgroup subsys cpu
> > Linux version 3.16.0-rc5 (will at edgewater-inn) (gcc version 4.9.0 20140214 (experimental) (aarch64-trunk.530) ) #1 SMP PREEMPT Thu Jul 17 16:19:36 BST 2014
> > CPU: AArch64 Processor [410fd070] revision 0
> > Early serial console at I/O port 0x0 (options '')
> > bootconsole [uart0] enabled
> > efi: Getting parameters from FDT:
> > efi: Can't find System Table in device tree!
> > cma: CMA: failed to reserve 512 MiB
> > psci: probing for conduit method from DT.
> > psci: Using PSCI v0.1 Function IDs from DT
> > PERCPU: Embedded 1 pages/cpu @fffffe0023e80000 s13120 r8192 d44224 u65536
> > Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 9208
> > Kernel command line: console=hvc0,38400 earlycon=uart8250,0x3f8 root=/dev/root rw rootflags=rw,trans=virtio,version=9p2000.L rootfstype=9p init=/virt/init  ip=dhcp
> > PID hash table entries: 4096 (order: -1, 32768 bytes)
> > Dentry cache hash table entries: 131072 (order: 4, 1048576 bytes)
> > Inode-cache hash table entries: 65536 (order: 3, 524288 bytes)
> > Memory: 579264K/589824K available (4359K kernel code, 455K rwdata, 1536K rodata, 332K init, 280K bss, 10560K reserved)
> > Virtual kernel memory layout:
> >     vmalloc : 0xfffffc0000000000 - 0xfffffdfbffff0000   (2080767 MB)
> >     vmemmap : 0xfffffdfc001c0000 - 0xfffffdfc0023e000   (     0 MB)
> >     modules : 0xfffffdfffc000000 - 0xfffffe0000000000   (    64 MB)
> >     memory  : 0xfffffe0000000000 - 0xfffffe0024000000   (   576 MB)
> >       .init : 0xfffffe0000660000 - 0xfffffe00006b3340   (   333 kB)
> >       .text : 0xfffffe0000080000 - 0xfffffe0000651f94   (  5960 kB)
> >       .data : 0xfffffe00006c0000 - 0xfffffe0000731ca8   (   456 kB)
> > SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> > Preemptible hierarchical RCU implementation.
> > 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
> > RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> > NR_IRQS:64 nr_irqs:64 0
> 
> Not a lot to go on there.  If you get desperate you can configure FTRACE
> and pass "ftrace=function ftrace_dump_on_oops" as additional additional
> kernel command line arguments.  If you get really desperate you can do
> the same on the host.  Just beware the output is really long.

Cheers for the replies. It could be that I'm tickling something with kvmtool
that qemu doesn't do, so I'll add some traces and try to figure out some more
information later on today.

Will
