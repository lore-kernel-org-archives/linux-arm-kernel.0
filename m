From: vipulkumar.samar@st.com (vipul kumar samar)
Date: Mon, 28 Jan 2013 16:52:36 +0530
Subject: [PATCH 00/13] ARM: spear multiplatform support
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <51065F7C.3030407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 1/26/2013 5:05 AM, Arnd Bergmann wrote:
> This is a series I did some time ago but forgot to
> send out earlier. I'd like to get this into v3.9,
> so please give this a test if you can.

Me and bhavna tried to test this patch set on spear1340 and 
spear320-hmi. We applied your patch set on the latest kernel v3.8-rc5 
and in both case (1340 and 320-hmi) we observe that the kernel load 
address is changed form 0x8000 to 0xfffffff2.

---------------------------------------------------------------
Legacy Image at E6080000:
    Image Name:   Linux-3.8.0-rc5-00013-g35c416f
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2144560 Bytes = 2 MiB
    Load Address: fffffff2
    Entry Point:  fffffff2
    Verifying Checksum ... OK
---------------------------------------------------------------

Previously it was like:

---------------------------------------------------------------
Legacy Image at E6080000:
    Image Name:   Linux-3.5.0-lsp-3.3.1-spear13xx
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    3060704 Bytes = 2.9 MiB
    Load Address: 00008000
    Entry Point:  00008000
    Verifying Checksum ... O
---------------------------------------------------------------

And thats why it is giving following crash:

---------------------------------------------------------------
u-boot> bootm 0xe6080000 - 0xe6070000
## Booting kernel from Legacy Image at e6080000 ...
    Image Name:   Linux-3.8.0-rc5-00013-g35c416f
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2144560 Bytes = 2 MiB
    Load Address: fffffff2
    Entry Point:  fffffff2
    Verifying Checksum ... OK
## Flattened Device Tree blob at e6070000
    Booting using the fdt blob at 0xe6070000
    Loading Kernel Image ... data abort
pc : [<3ff94608>]          lr : [<3ff69ef4>]
sp : 3fe65aa8  ip : 00000000     fp : 00000000
r10: e6080040  r9 : e628b970     r8 : 3fe65f58
r7 : e6080000  r6 : 00000000     r5 : 3fe65b10  r4 : 00000000
r3 : fffffff2  r2 : 0000000d     r1 : e6080040  r0 : fffffff2
Flags: nzCv  IRQs off  FIQs off  Mode SVC_32
Resetting CPU ..
---------------------------------------------------------------

Regards
Vipul Samar
