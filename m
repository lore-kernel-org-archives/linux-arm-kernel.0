From: sposelenov@emcraft.com (Sergei Poselenov)
Date: Fri, 2 Oct 2015 20:07:26 +0300
Subject: nommu Linux: not enough memory to start an application?
Message-ID: <20151002200726.18428ee4@skywanderer.emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to start a big BFLT application on ARM/noMMU Linux 4.2.0 and
getting the following output:
...
nommu: Allocation of length 5226496 from process 21 (qt) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:13 isolated_file:0
 unevictable:1900 dirty:0 writeback:0 unstable:0
 slab_reclaimable:27 slab_unreclaimable:112
 mapped:0 shmem:0 pagetables:0 bounce:0
 free:5535 free_pcp:0 free_cma:0
Normal free:22140kB min:620kB low:772kB high:928kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:52kB unevictable:7600kB isolated(anon):0kB isolated(file):0kB present:32768kB managed:31568kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:108kB slab_unreclaimable:448kB kernel_stack:112kB pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:1836 all_unreclaimable? yes
lowmem_reserve[]: 0 0
Normal: 3*4kB (UM) 2*8kB (M) 0*16kB 1*32kB (M) 3*64kB (UM) 3*128kB (UM) 4*256kB (UM) 2*512kB (M) 5*1024kB (UM) 5*2048kB (UM) 1*4096kB (M) 0*8192kB = 22140kB
1913 total pagecache pages
Unable to allocate RAM for process text/data, errno 12
SEGV

Kernel configuration includes a pretty big INITRD image, about 7MB. Total number of memory
on the board is 32MB.

I already increased CONFIG_FORCE_MAX_ZONEORDER from the default 11 to 12
and turned off everything (networking, usb etc) but this doesn't help,
as you see the number of 8192kB chunks is zero.
I can't believe that the system has >20 MB of free memory and still
unable to run 5MB application. That's completely unlike of the old 2.6.33
kernel with the same INITRD which works fine even in "normal" configuration,
with networking and drivers enabled.

Any ideas?

Thanks is advance.

Regards,
Sergei
