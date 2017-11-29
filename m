From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 29 Nov 2017 09:24:32 +0530
Subject: problem of kexec
In-Reply-To: <33D4DBCAC5F2D74E96B07F6E7632BF732EEA37A4@G08CNEXMBPEKD01.g08.fujitsu.local>
References: <33D4DBCAC5F2D74E96B07F6E7632BF732EEA03D3@G08CNEXMBPEKD01.g08.fujitsu.local>
 <CAHM4w1k0ZhiuYKuqQc2+V0=FbMCgUASR8Q6o43JY_9eP6t3X5w@mail.gmail.com>
 <CAAbOZyeXCM9UMZSQenbjAZb3oVruBhJaKt--=A6Ou4=2bG+kGQ@mail.gmail.com>
 <CACi5LpMUJPRCjbbahSeLkQ8oWUMjp1RBn4AGZeEbmj-h=1YQEw@mail.gmail.com>
 <33D4DBCAC5F2D74E96B07F6E7632BF732EEA37A4@G08CNEXMBPEKD01.g08.fujitsu.local>
Message-ID: <CACi5LpOE3yTfibRNH1SNor_iZwgsNH5QEfaS7ZTOEDM3NF8c=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zheng,

On Fri, Nov 24, 2017 at 7:10 AM, Zheng, Ruoqin
<zhengrq.fnst@cn.fujitsu.com> wrote:
> Hi Bhupesh
>   Thank you for your help, and here is my output as you mentioned:
>
>>>3. Also can you please share the output of the following commands on the primary kernel boot:
>
>>>      # cat /sys/kernel/kexec_crash_size
>
>>>      # cat /proc/iomem
>
> # cat /sys/kernel/kexec_crash_size
> 0

Hmm.. If this value is taken with the primary kernel boot'ed it would
suggest that there was no memory reserved for the crashkernel.

Usually this command should give an idea of the memory reserved for
crashkernel (for e.g. 512M).
So you will not be able to use the crashdump but can use the kexec -l
and kexec -e combination.

> # cat /proc/iomem
> 01080000-01080fff : fsl_mc_err
> 01550000-0155ffff : QuadSPI
> 01560000-0156ffff : /soc/esdhc at 1560000
> 01580000-0158ffff : /soc/msi-controller at 1580000
> 01590000-0159ffff : /soc/msi-controller at 1590000
> 015a0000-015affff : /soc/msi-controller at 15a0000
> 01a00000-01afffff : fman
>   01a00000-01a5ffff : fman-muram
>   01a82000-01a82fff : fman-port-hc
>   01a83000-01a83fff : fman-port-hc
>   01a84000-01a84fff : fman-port-hc
>   01a85000-01a85fff : fman-port-hc
>   01a86000-01a86fff : fman-port-hc
>   01a87000-01a87fff : fman-port-hc
>   01a88000-01a88fff : fman-port-hc
>   01a89000-01a89fff : fman-port-hc
>   01a8a000-01a8afff : fman-port-hc
>   01a8b000-01a8bfff : fman-port-hc
>   01a8c000-01a8cfff : fman-port-hc
>   01a8d000-01a8dfff : fman-port-hc
>   01a90000-01a90fff : fman-port-hc
>   01a91000-01a91fff : fman-port-hc
>   01aa8000-01aa8fff : fman-port-hc
>   01aa9000-01aa9fff : fman-port-hc
>   01aaa000-01aaafff : fman-port-hc
>   01aab000-01aabfff : fman-port-hc
>   01aac000-01aacfff : fman-port-hc
>   01aad000-01aadfff : fman-port-hc
>   01ab0000-01ab0fff : fman-port-hc
>   01ab1000-01ab1fff : fman-port-hc
>   01adc000-01adcfff : fman-vsp
>   01ae4000-01ae4fff : mac
>   01ae6000-01ae6fff : mac
>   01ae8000-01ae8fff : mac
>   01aea000-01aeafff : mac
>   01afe000-01afefff : fman-rtc
> 01ee0000-01ee0fff : /soc/dcfg at 1ee0000
> 01ee2140-01ee2143 : FlexTimer1
> 02180000-0218ffff : /soc/i2c at 2180000
> 021b0000-021bffff : /soc/i2c at 21b0000
> 021c0500-021c05ff : serial
> 021c0600-021c06ff : serial
> 021d0500-021d05ff : serial
> 021d0600-021d06ff : serial
> 029d0000-029dffff : ftm
> 02ad0000-02adffff : /soc/watchdog at 2ad0000
> 02c00000-02c0ffff : /soc/edma at 2c00000
> 02c10000-02c1ffff : /soc/edma at 2c00000
> 02c20000-02c2ffff : /soc/edma at 2c00000
> 02f00000-02f07fff : /soc/usb at 2f00000
>   02f00000-02f07fff : /soc/usb at 2f00000
> 02f0c100-02f0ffff : /soc/usb at 2f00000
> 03000000-03007fff : /soc/usb at 3000000
>   03000000-03007fff : /soc/usb at 3000000
> 0300c100-0300ffff : /soc/usb at 3000000
> 03100000-03107fff : /soc/usb at 3100000
>   03100000-03107fff : /soc/usb at 3100000
> 0310c100-0310ffff : /soc/usb at 3100000
> 03200000-0320ffff : ahci
> 03400000-034fffff : regs
> 03500000-035fffff : regs
> 03600000-036fffff : regs
> 20140520-20140523 : sata-ecc
> 40000000-4fffffff : QuadSPI-memory
> 80000000-ffffffff : System RAM
>   80080000-8113ffff : Kernel code
>   81260000-8145bfff : Kernel data
> 880000000-9f7ffffff : System RAM
> 9fb800000-9fbdfffff : System RAM
> 4040000000-407fffffff : MEM
>   4040000000-40400007ff : 0000:00:00.0
> 4840000000-487fffffff : MEM
>   4840000000-48400007ff : 0001:00:00.0
> 5040000000-507fffffff : MEM
>   5040000000-50400fffff : PCI Bus 0002:01
>     5040000000-504000ffff : 0002:01:00.0
>   5040100000-50401fffff : PCI Bus 0002:01
>     5040100000-5040103fff : 0002:01:00.0
>     5040104000-5040104fff : 0002:01:00.0
>   5040200000-50402007ff : 0002:00:00.0

Thanks. This looks ok at the first glance.

Could you please use the following command line to load the
crashkernel rather than using the '-dtb' option to load the
crashkernel:
# kexec -l <path to Image or vmlinuz> --initrd=<path to initramfs>
--reuse-cmdline

for e.g. assuming the images are installed inside /boot, use:

# kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
-r`.img --reuse-cmdline

And then use:

# kexec -e

And share the results you get with the same.

Regards,
Bhupesh


>
>
> --------------------------------------------------
> Zheng Ruoqin
> Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
> ADDR.: No.6 Wenzhu Road, Software Avenue,
>        Nanjing, 210012, China
> MAIL : zhengrq.fnst at cn.fujistu.com
>
>
> -----Original Message-----
> From: Bhupesh Sharma [mailto:bhsharma at redhat.com]
> Sent: Thursday, November 23, 2017 6:22 PM
> To: Zheng, Ruoqin/? ?? <zhengrq.fnst@cn.fujitsu.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>; FNST fnst-ulinux <fnst-ulinux@cn.fujitsu.com>; Bhupesh SHARMA <bhupesh.linux@gmail.com>; linux-arm-kernel at lists.infradead.org; kexec at lists.fedoraproject.org
> Subject: Re: problem of kexec
>
> Hello Zheng Ruoqin,
>
>>> On Tue, Nov 7, 2017 at 9:41 AM, Pratyush Anand
>>> <pratyush.anand@gmail.com>
>> wrote:
>>>
>>> Thanks for contacting. A bit busy..will look into all your log in weekend.
>>> Meanwhile, have added Bhupesh, if he has some quick input.
>>>
>>>
>>>
>>> On Nov 7, 2017 8:58 AM, "Zheng, Ruoqin" <zhengrq.fnst@cn.fujitsu.com>
>>> wrote:
>>>
>>> Hi pratyush?
>>>
>>> I am a member of Fujistu, and I want to run kexec in arm64, my arm
>>> board is ls1046a(a Cortex-A72 soc based board).
>>>
>>>
>>>
>>> I have used kexec-tool v2.0.15 to start a new kernel, my test log is
>>> in attachment. The kernel version is 4.9.35.
>>>
>>>
>>>
>>> 1. First, I boot the kernel in uboot with a itb file which includes
>>> Image and dtb.
>>>
>>>        Well, In my first boot, it works well.
>>>
>>>              uboot command:
>>>
>>>                   =>setenv ipaddr 192.168.246.59; setenv serverip
>>> 192.168.246.2; tftp a0000000 ....../ls1046/kernel-64le.itb
>>>
>>>          =>setenv bootargs root=/dev/nfs rw
>>> nfsroot=192.168.246.2:....../target_64le,vers=3 ip=dhcp rw
>>> console=ttyS0,115200 earlycon=uart8250,mmio,0x21c0500;bootm
>>> a0000000#ls1046a-edac
>>>
>>>
>>>
>>> 2.       After the first kernel booted, I use kexec to boot the new kernel
>>> with dtb file, the kernel is failed to allocate memory for node
>>> 'qman-fqd', 'qman-pfdr' and 'bman-fbpr', then went Kernel panic. The
>>> log is in ?kexec-dtb-64le_kernel.log?.
>>>
>>>
>>>
>>> 3.       And without dtb file, the kexec boot kernel will go farer and
>>> print a lot of stack message, but finally, it can?t mount the NFS rootfs.
>>> The log is in ?kexec-without-dtb-64le_kernel.log?
>>>
>>>
>>>
>>> Can you give me some help about how to use kexec to start a new
>>> kernel normally?
>>>
>
> Cc: linux-arm and kexec mailing lists for further inputs (Hoping some NXP guys would see this and be able to help with the DPAA issue - Q/BMAN issues you are seeing the crash boot logs)..
>
> I had a look at the logs:
>
> 1. crashkernel logs with DTB being passed:
>
> a. I am pasting the logs below again for reference -
>
> root at ubinux-armv8:~# kexec -l ./Image --dtb="./fsl-ls1046a-rdb-sdk.dtb" --comman d-line="$(cat /proc/cmdline)"
> root at ubinux-armv8:~#
> root at ubinux-armv8:~#
> root at ubinux-armv8:~# kexec -e
> [  139.778840] kvm: exiting hardware virtualization [  139.785916] kexec_core: Starting new kernel [  139.790103] Disabling non-boot CPUs ...
> 2017 Nov  6 08:39:10 ubinux-armv8 [  139.785916] kexec_core: Starting new kernel [  139.816312] IRQ53 no longer affine to CPU1 [  139.820404] IRQ57 no longer affine to CPU1 [  139.824496] IRQ61 no longer affine to CPU1 [  139.828611] CPU1: shutdown [  139.831316] psci: CPU1 killed.
> [  139.880310] IRQ54 no longer affine to CPU2 [  139.884405] IRQ58 no longer affine to CPU2 [  139.888496] IRQ62 no longer affine to CPU2 [  139.892682] CPU2: shutdown [  139.895386] psci: CPU2 killed.
> [  139.944268] IRQ55 no longer affine to CPU3 [  139.948362] IRQ59 no longer affine to CPU3 [  139.952453] IRQ63 no longer affine to CPU3 [  139.956579] CPU3: shutdown [  139.959282] psci: CPU3 killed.
> [  139.983716] Bye!
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.35-g1e65b65 (zhengrq at force) (gcc version 5.4.0
> 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) ) #1 SMP PREEMPT Tue Oct 24 14:1
> 1:03 JST 2017
> [    0.000000] Boot CPU: AArch64 Processor [410fd082]
> [    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0500 (options '')
> [    0.000000] bootconsole [uart8250] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'qman-fqd'
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'qman-pfdr'
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'bman-fbpr'
> [    0.000000] cma: Failed to reserve 16 MiB
> [    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 byte
> s below 0x0.
> [    0.000000]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.35-g1e65b65 #1
> [    0.000000] Hardware name: LS1046A RDB Board (DT)
> [    0.000000] Call trace:
> [    0.000000] [<ffff000008088498>] dump_backtrace+0x0/0x238
> [    0.000000] [<ffff0000080886e4>] show_stack+0x14/0x20
> [    0.000000] [<ffff0000084ec084>] dump_stack+0x9c/0xc0
> [    0.000000] [<ffff000008173a54>] panic+0x11c/0x284
> [    0.000000] [<ffff000009158158>] memblock_alloc_base+0x30/0x3c
> [    0.000000] [<ffff000009158174>] memblock_alloc+0x10/0x18
> [    0.000000] [<ffff000009146660>] early_pgtable_alloc+0x18/0x70
> [    0.000000] [<ffff000009146804>] paging_init+0x30/0x558
> [    0.000000] [<ffff000009143584>] setup_arch+0x19c/0x580
> [    0.000000] [<ffff000009140844>] start_kernel+0x70/0x390
> [    0.000000] [<ffff0000091401e0>] __primary_switched+0x64/0x6c
> [    0.000000] ---[ end Kernel panic - not syncing: ERROR: Failed to allocate 0x
> 1000 bytes below 0x0.
> [    0.000000]
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual addre
> ss 00000000
> [    0.000000] pgd = ffff000009458000
> [    0.000000] [00000000] *pgd=0000000081459003[    0.000000] Unable to handle k
> ernel paging request at virtual address ffff800081459000
> [    0.000000] pgd = ffff000009458000
> [    0.000000] [ffff800081459000] *pgd=0000000000000000[    0.000000]
> [    0.000000] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.35-g1e65b65 #1
> [    0.000000] Hardware name: LS1046A RDB Board (DT)
> [    0.000000] task: ffff0000092744c0 task.stack: ffff000009260000
> [    0.000000] PC is at show_pte+0xa0/0x118
> [    0.000000] LR is at show_pte+0x48/0x118
> [    0.000000] pc : [<ffff000008097430>] lr : [<ffff0000080973d8>] pstate: 60000
> 1c5
> [    0.000000] sp : ffff000009213d80
> [    0.000000] x29: ffff000009213d80 x28: ffff0000092744c0
> [    0.000000] x27: ffff000008c82000 x26: ffff000009214050
> [    0.000000] x25: ffff000009210060 x24: 0000000000000021
> [    0.000000] x23: 0000000086000004 x22: 0000000000000000
> [    0.000000] x21: 0000000000000000 x20: ffff0000090a8000
> [    0.000000] x19: ffff800081459000 x18: 0000000000000010
> [    0.000000] x17: ffff000009394c18 x16: 0000000000000000
> [    0.000000] x15: ffff00008936af9f x14: 0000000000000006
> [    0.000000] x13: ffff00000936afad x12: 000000000000000f
> [    0.000000] x11: 0000000000000006 x10: 000000000000001d
> [    0.000000] x9 : ffff000009213b90 x8 : 3330303935343138
> [    0.000000] x7 : 3030303030303030 x6 : ffff00000936afcf
> [    0.000000] x5 : ffff000009304d68 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.000000] x1 : 0000000081459000 x0 : ffff000008fafcc0
> [    0.000000]
> [    0.000000] Process swapper (pid: 0, stack limit = 0xffff000009260000)
> [    0.000000] Stack: (0xffff000009213d80 to 0xffff000009264000)
> [    0.000000] 3d80: ffff000009213db0 ffff00000809a154 0000000000000000 ffff0000
> 09213f10
> [    0.000000] 3da0: 0000000086000004 696e6170206c656e ffff000009213de0 ffff0000
> 080978e4
>
> b. I would suggest to use the following command line to load the crashkernel rather than using the '-dtb' option to laod the
> crashkernel:
> # kexec -l <path to Image or vmlinuz> --initrd=<path to initramfs> --reuse-cmdline
>
> for e.g. assuming the images are installed inside /boot, use:
>
> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img --reuse-cmdline
>
> c. And then use:
>
> # kexec -e
>
> 2. The following logs show that the memory allocation for the Q/BMAN nodes for the DPAA hardware network accelerator (as mentioned in the
> DTB) failed:
>
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'qman-fqd'
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'qman-pfdr'
> [    0.000000] OF: reserved mem: failed to allocate memory for node 'bman-fbpr'
> [    0.000000] cma: Failed to reserve 16 MiB
>
> 3. Also can you please share the output of the following commands on the primary kernel boot:
>
> # cat /sys/kernel/kexec_crash_size
>
> # cat /proc/iomem
>
> Regards,
> Bhupesh
>
>
>>>
>>> --------------------------------------------------
>>>
>>> Zheng Ruoqin
>>>
>>> Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
>>>
>>> ADDR.: No.6 Wenzhu Road, Software Avenue,
>>>
>>>        Nanjing, 210012, China
>>>
>>> MAIL : zhengrq.fnst at cn.fujistu.com
>>>
>>>
>>>
>>>
>>
>
>
>
>
