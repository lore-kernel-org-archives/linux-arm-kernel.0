From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Wed, 10 Feb 2010 18:48:56 +0100
Subject: Kernel Oops while cfi_amdstd_read()
Message-ID: <4F042A7030A6403DBB06FD3191EEE644@teltronic.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
 
I'm getting this in an ARM9-based platform:
 
picoFlash: 0x4000000 at 0x20000000

picoFlash: Found 1 x16 devices at 0x0 in 16-bit bank

Amd/Fujitsu Extended Query Table at 0x0040

picoFlash: CFI does not contain boot bank location. Assuming top.

number of CFI chips: 1

cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

Creating 8 MTD partitions on "picoFlash":

0x00000000-0x00040000 : "Boot"

0x00040000-0x00060000 : "Boot_Env"

0x00060000-0x00260000 : "uImage"

0x00260000-0x00860000 : "rootfs"

0x00860000-0x01c60000 : "usrfs"

0x01c60000-0x02060000 : "safe_mode"

0x02060000-0x03fc0000 : "temporal"

0x03fc0000-0x04000000 : "reserved"

pc20x SPI-GPIO driver, version 0.01 loaded

pc20x-spi-gpio pc20x-spi-gpio.0: registering c0267114: spidev

oprofile: using timer interrupt.

Netfilter messages via NETLINK v0.30.

ip_conntrack version 2.4 (320 buckets, 2560 max) - 224 bytes per conntrack

ctnetlink v0.90: registering with nfnetlink.

ip_conntrack_pptp version 3.1 loaded

ip_nat_pptp version 3.0 loaded

ip_tables: (C) 2000-2006 Netfilter Core Team

ClusterIP Version 0.8 loaded successfully

arp_tables: (C) 2002 David S. Miller

TCP bic registered

NET: Registered protocol family 1

NET: Registered protocol family 17

802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>

All bugs added by David S. Miller <davem@redhat.com>

SCTP: Hash tables configured (established 1024 bind 2048)

IP-Config: Complete:

device=eth0, addr=10.0.0.103, mask=255.255.255.0, gw=10.0.0.1,

host=cpegwtelmax, domain=, nis-domain=(none),

bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=

VFS: Mounted root (jffs2 filesystem).

Freeing init memory: 104K

Unable to handle kernel paging request at virtual address 7261749b

pgd = c0010000

[7261749b] *pgd=00000000

Internal error: Oops: 1 [#1]

Modules linked in:

CPU: 0

PC is at cfi_amdstd_read+0x18/0x30c

LR is at part_read+0x70/0xdc

pc : [<c01494ec>] lr : [<c013bfdc>] Not tainted

sp : c0387c68 ip : c0387cb0 fp : c0387cac

r10: c285d000 r9 : 72617473 r8 : c3889600

r7 : 00000000 r6 : c385f5a0 r5 : 00000000 r4 : 00327cc4

r3 : 00000000 r2 : 00327cc4 r1 : c0387d04 r0 : c385cce0

Flags: nzcv IRQs on FIQs on Mode SVC_32 Segment user

Control: 5317F Table: 00010000 DAC: 00000015

Process init (pid: 1, stack limit = 0xc0386258)

Stack: (0xc0387c68 to 0xc0388000)

7c60: c0386000 c3867120 00000000 00327c80 c0387d04 c3867158

7c80: c0387cac 000c7cc4 00000000 c385f5a0 00000000 c3889600 c0387d04
c285d000

7ca0: c0387cdc c0387cb0 c013bfdc c01494e4 0000086c c0387d04 c390f000
00000044

7cc0: c001d798 c390b528 c390f000 c001d798 c0387d34 c0387ce0 c00e3334
c013bf7c

7ce0: 0000086c c0387d04 c390f000 c01056cc c391f588 c285d000 00000000
00000001

7d00: c000d5a0 00000044 c0386000 00001000 000a6000 c001c938 c285d000
00000088

7d20: c391f588 000a7000 c0387d74 c0387d38 c00e36c8 c00e3194 00000000
00001000

7d40: 00000000 c3889600 000000a5 c026495c c034bba0 00000020 c0386000
00000088

7d60: 000000b7 c391f65c c0387d94 c0387d78 c00e0f8c c00e3638 00001000
c391f658

7d80: c034bba0 0000001e c0387dac c0387d98 c00e1034 c00e0f24 c391f588
0000001e

7da0: c0387dc4 c0387db0 c00e13e4 c00e1030 c0386000 c034bba0 c0387e54
c0387dc8

7dc0: c0067538 c00e13a8 00000000 c0387e20 00000020 c390a9e0 c391f658
0000001f

7de0: 00000002 00000000 c034bb60 c034bb80 c034b9e0 c034ba00 c034ba20
c034ba40

7e00: c034ba60 c034ba80 c034baa0 c034bac0 c034bae0 c034bb00 c034bb20
c034bb40

7e20: c0387e20 c0387e20 c0105d1c c391f658 00000020 00000088 c390a9e0
000b7e64

7e40: 00000000 00000098 c0387e74 c0387e58 c00679f8 c00672dc 00000000
c391f658

7e60: c0386000 c390a9e0 c0387ec4 c0387e78 c0062a40 c00679a8 c0043040
c000df64

7e80: c0387ef4 c000d5a0 c390aa24 c391f5b8 00000000 00000003 00000000
00000000

7f20: c0029d60 c006dcc4 c002ddc4 00000001 c02ddc10 00000000 00000000
000a0000

7f40: c0386000 ffffffff 4001ee00 000a090c 00000000 c0387fb0 00000000
4022c000

7f60: c0387f9c c0387f70 c0029f78 c0029be4 c0387f94 c0387f80 c003eec0
ffffffff

7f80: 4001ee00 000a090c 00000000 00000000 c0387fac c0387fa0 c0029f98
c0029edc

7fa0: 00000000 c0387fb0 c0022c48 c0029f90 00000000 00000000 000000fc
00000000

7fc0: 00000000 4001ee00 000a090c 00000000 00000000 00000000 4022c000
00000000

7fe0: 00000001 bea50de8 401277c0 000a090c 20000010 ffffffff e5853004
e5953000

Backtrace:

[<c01494d4>] (cfi_amdstd_read+0x0/0x30c) from [<c013bfdc>]
(part_read+0x70/0xdc)

[<c013bf6c>] (part_read+0x0/0xdc) from [<c00e3334>]
(jffs2_read_dnode+0x1b0/0x4a

4)

r6 = C001D798 r5 = C390F000 r4 = C390B528

[<c00e3184>] (jffs2_read_dnode+0x0/0x4a4) from [<c00e36c8>]
(jffs2_read_inode_ra

nge+0xa0/0x170)

[<c00e3628>] (jffs2_read_inode_range+0x0/0x170) from [<c00e0f8c>]
(jffs2_do_read

page_nolock+0x78/0x10c)

[<c00e0f14>] (jffs2_do_readpage_nolock+0x0/0x10c) from [<c00e1034>]
(jffs2_do_re

adpage_unlock+0x14/0x28)

r5 = 0000001E r4 = C034BBA0

[<c00e1020>] (jffs2_do_readpage_unlock+0x0/0x28) from [<c00e13e4>]
(jffs2_readpa

ge+0x4c/0x74)

r5 = 0000001E r4 = C391F588

[<c00e1398>] (jffs2_readpage+0x0/0x74) from [<c0067538>]
(__do_page_cache_readah

ead+0x26c/0x358)

r4 = C034BBA0

[<c00672cc>] (__do_page_cache_readahead+0x0/0x358) from [<c00679f8>]
(do_page_ca

che_readahead+0x60/0x6c)

[<c0067998>] (do_page_cache_readahead+0x0/0x6c) from [<c0062a40>]
(filemap_nopag

e+0x158/0x4a4)

r7 = C390A9E0 r6 = C0386000 r5 = C391F658 r4 = 00000000

[<c00628e8>] (filemap_nopage+0x0/0x4a4) from [<c006de00>]
(__handle_mm_fault+0x1

4c/0x844)

[<c006dcb4>] (__handle_mm_fault+0x0/0x844) from [<c0029d60>]
(do_page_fault+0x18

c/0x244)

[<c0029bd4>] (do_page_fault+0x0/0x244) from [<c0029f78>]
(do_translation_fault+0

xac/0xb4)

[<c0029ecc>] (do_translation_fault+0x0/0xb4) from [<c0029f98>]
(do_PrefetchAbort

+0x18/0x1c)

r8 = 00000000 r7 = 00000000 r6 = 000A090C r5 = 4001EE00

r4 = FFFFFFFF

[<c0029f80>] (do_PrefetchAbort+0x0/0x1c) from [<c0022c48>]
(ret_from_exception+0

x0/0x10)

Code: e24cb004 e24dd01c e59090a8 e1a04002 (e5991028)

<0>Kernel panic - not syncing: Attempted to kill init!

 
The size of NOR flash in our platform is 64MB and RAM is 32MB.
 
I don't like that "Unable to handle kernel paging request at virtual address
7261749b" because virtual addresses map is at 0xC0XXXXXXX.
 
I bet it is related to NOR being bigger than RAM, but not sure and I wonder
if it has an easy fix.
 
Thanks in advance.
Ricardo.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100210/3ffb54a0/attachment.htm>
