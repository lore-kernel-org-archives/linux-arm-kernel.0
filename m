From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Mar 2018 15:25:24 +0200
Subject: [PATCH v2 0/4] Introduce PMSAv8 memory protection unit
In-Reply-To: <1518790485-2321-1-git-send-email-vladimir.murzin@arm.com>
References: <1518790485-2321-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <4407b88a-ce0d-38c6-1f33-7aac56af94f4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vlad,

On 02/16/2018 03:14 PM, Vladimir Murzin wrote:
> Hi,
> 
> This series adds support for PMSAv8 MPU defined by ARMv8R/M
> architecture.
> 
> Changelog:
> 
>       v1 -> v2
>          - Included missed patch.
> 	- Folded "ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment
> 	  restrictions" into "ARM: NOMMU: Support PMSAv8 MPU" since it
> 	  allows us to refer PMSAv8_MINALIGN in linker scripts.
> 	- Improved and tested XIP support
> 
>      RFC -> v1
>          - Rebased on v4.16-rc1
> 	- Added Tested-by for v7M bits from Andras
> 
> Thanks!
> 
> Vladimir Murzin (4):
>    ARM: NOMMU: Move PMSAv7 MPU under it's own namespace
>    ARM: NOMMU: Reorganise __setup_mpu
>    ARM: NOMMU: Postpone MPU activation till __after_proc_init
>    ARM: NOMMU: Support PMSAv8 MPU
> 
>   arch/arm/include/asm/mpu.h        | 112 +++++++++-----
>   arch/arm/include/asm/v7m.h        |  14 +-
>   arch/arm/kernel/asm-offsets.c     |   8 +-
>   arch/arm/kernel/head-nommu.S      | 289 ++++++++++++++++++++++++++++-------
>   arch/arm/kernel/vmlinux-xip.lds.S |   4 +
>   arch/arm/kernel/vmlinux.lds.S     |   7 +
>   arch/arm/mm/Makefile              |   2 +-
>   arch/arm/mm/nommu.c               |  32 ++++
>   arch/arm/mm/pmsa-v7.c             |  59 +++-----
>   arch/arm/mm/pmsa-v8.c             | 307 ++++++++++++++++++++++++++++++++++++++
>   10 files changed, 701 insertions(+), 133 deletions(-)
>   create mode 100644 arch/arm/mm/pmsa-v8.c
> 

Just tested on stm32f769-disco board on stm32-next branch. I don't see 
regressions.

Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks

Alex
