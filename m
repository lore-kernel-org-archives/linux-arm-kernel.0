From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:16:25 +0800
Subject: [PATCH v3 0/2] arm64: mm: Enhance Virtual kernel memory layout
In-Reply-To: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a micro enhance for Virtual kernel memory layout. Show bss info,
and make each line with single pr_cont().

With this patchset,

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008755000   (  6996 KB)
[    0.000000]     .rodata : 0xffffff8008755000 - 0xffffff8008a3d000   (  2976 KB)
[    0.000000]       .init : 0xffffff8008a3d000 - 0xffffff8008b09000   (   816 KB)
[    0.000000]       .data : 0xffffff8008b09000 - 0xffffff8008ba6800   (   630 KB)
[    0.000000]        .bss : 0xffffff8008ba6800 - 0xffffff8008be3738   (   244 KB)
[    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
[    0.000000]               0xffffffbdc0000000 - 0xffffffbdc8000000   (   128 MB actual)
[    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192 MB)

Before,

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008753000   (  6988 KB)
    .rodata : 0xffffff8008753000 - 0xffffff8008a3a000   (  2972 KB)
      .init : 0xffffff8008a3a000 - 0xffffff8008b06000   (   816 KB)
      .data : 0xffffff8008b06000 - 0xffffff8008ba2400   (   625 KB)
[    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
              0xffffffbdc0000000 - 0xffffffbdc8000000   (   128 MB actual)
[    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192 MB)

Changes since v2:
- Add tested/ack by James Morse.
- Remove restrictive printing, keep the same as mm/dump.c.

Changes since v1:
- Drop vector info and spilt the patch, suggested by James Morse.

Kefeng Wang (2):
  arm64: mm: make pr_cont() per line in Virtual kernel memory layout
  arm64: mm: Show bss segment in kernel memory layout

 arch/arm64/mm/init.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.6.0.GIT
