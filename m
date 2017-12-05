From: labbott@redhat.com (Laura Abbott)
Date: Tue, 5 Dec 2017 15:54:06 -0800
Subject: [kernel-hardening][PATCH v3 0/3] arm: Makes ptdump resuable and
 add WX page checking
In-Reply-To: <20171204142458.GA3325@pjb1027-Latitude-E5410>
References: <20171204142458.GA3325@pjb1027-Latitude-E5410>
Message-ID: <b5932cc6-df7c-2f99-faff-c378812e9988@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2017 06:24 AM, Jinbum Park wrote:
> Hi,
> 
> Page table dumping code for arm64-x86 is reusable,
> and they have function for WX page checking.
> But arm doesn't have that.
> 
> This path series are to makes ptdump reusable,
> and add WX page checking for arm.
> This is heavily based on arm64 version.
> 
> v2 :
> Fix a sender name of mail header, there was an mistake.
> (from "jinb.park" to Jinbum Park)
> Contents of patch-set are perfectly same.
> 
> v3 :
> Take advantage of the existing pg_level and bits arrays
> to check ro, nx prot.
> 
> jinb.park (3):
>    arm: mm: dump: make page table dumping reusable
>    arm: mm: dump: make the page table dumping seq_file optional
>    arm: mm: dump: add checking for writable and executable pages
> 
>   arch/arm/Kconfig.debug        |  33 +++++++++-
>   arch/arm/include/asm/ptdump.h |  56 ++++++++++++++++
>   arch/arm/mm/Makefile          |   3 +-
>   arch/arm/mm/dump.c            | 144 +++++++++++++++++++++++++++++-------------
>   arch/arm/mm/init.c            |   2 +
>   arch/arm/mm/ptdump_debugfs.c  |  34 ++++++++++
>   6 files changed, 226 insertions(+), 46 deletions(-)
>   create mode 100644 arch/arm/include/asm/ptdump.h
>   create mode 100644 arch/arm/mm/ptdump_debugfs.c
> 

This detects the issue fixed by 400eeffaffc7 ("ARM: 8722/1: mm:
make STRICT_KERNEL_RWX effective for LPAE"). I'll give it another
test after the next version.

Thanks,
Laura
