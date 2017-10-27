From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Oct 2017 08:24:36 +0100
Subject: v4.14-rc3 kernel issue
In-Reply-To: <cc5b77ca-45a1-a7a4-08c9-8aa62c4f53c6@riken.jp>
References: <cc5b77ca-45a1-a7a4-08c9-8aa62c4f53c6@riken.jp>
Message-ID: <20171027072435.hqgoacedozwcxs7f@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 01:12:21PM +0900, Itaru Kitayama wrote:
> Hi,

Hi,

> I've seen this on a guest on KVM. Observed this after system booted, not
> special commands were issued.
> 
> [   82.124767] ==================================================================
> [   82.129867] BUG: KASAN: slab-out-of-bounds in pud_huge+0x24/0x48
> [   82.133893] Read of size 8 at addr ffff8000c43f79e8 by task kworker/u96:1/373
> [   82.138675]
> [   82.139709] CPU: 35 PID: 373 Comm: kworker/u96:1 Not tainted 4.14.0-rc3-dev+ #8
> [   82.144616] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [   82.149292] usercopy: kernel memory overwrite attempt detected to ffff8000c43f7610 (thread_stack) (8 bytes)
> [   82.156031] ------------[ cut here ]------------
> [   82.159139] kernel BUG at mm/usercopy.c:72!
> [   82.161972] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>  [   82.165650] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables sunrpc vfat fat crc32_ce crct10dif_ce ghash_ce virtio_net button xfs libcrc32c virtio_console virtio_scsi virtio_pci qemu_fw_cfg virtio_mmio virtio_ring virtio
> [   82.199893] CPU: 35 PID: 373 Comm: kworker/u96:1 Not tainted 4.14.0-rc3-dev+ #8
> [   82.204806] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [   82.209408] usercopy: kernel memory overwrite attempt detected to ffff8000c43f6d10 (thread_stack) (8 bytes)
> [   82.215969] ------------[ cut here ]------------
> [   82.219070] kernel BUG at mm/usercopy.c:72!

I see that you have both KASAN and HARDENED_USERCOPY enabled. Could you share
your .config?

Do you see the same behaviour with v4.14-rc6?

Thanks,
Mark
