From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 11 Oct 2012 00:35:54 +0900
Subject: [PATCH v2 0/6] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <1647638.5fBfDOzz0u@amdc1227>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
 <1647638.5fBfDOzz0u@amdc1227>
Message-ID: <CAH9JG2V56eLCCX+9id1EWhKfZ-6qW-3O0j0mVpzOjz5S8QGQ7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd or Olof,

Can you pick up for v3.7?

To Tomasz,
Can you rebase it on the latest arm-soc tree?

Thank you,
Kyungmin Park

On Tue, Oct 2, 2012 at 6:13 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi,
>
> On Monday 24 of September 2012 16:28:27 Tomasz Figa wrote:
>> Some Exynos-based boards are running with secure firmware running in
>> TrustZone secure world, which changes the way some things have to be
>> initialized.
>>
>> This series adds support for specifying firmware operations, implements
>> some firmware operations for Exynos secure firmware and adds a method of
>> enabling secure firmware operations on Exynos-based boards through board
>> file and device tree.
>>
>> Changes since v1
>> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/12583/focus=12820
>>   - Changed return types of all operations to int
>>   - Defined all operations to return 0 on success, -ENOSYS when not
>>     implemented or appropriate error code on error
>>
>> Tomasz Figa (6):
>>   ARM: Add interface for registering and calling firmware-specific
>>     operations
>>   ARM: EXYNOS: Add support for secure monitor calls
>>   ARM: EXYNOS: Add support for secondary CPU bring-up on Exynos4412
>>   ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
>>   ARM: EXYNOS: Add support for Exynos secure firmware
>>   ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up
>>
>>  .../devicetree/bindings/arm/samsung-boards.txt     |  8 ++++
>>  arch/arm/common/Makefile                           |  2 +
>>  arch/arm/common/firmware.c                         | 18 ++++++++
>>  arch/arm/include/asm/firmware.h                    | 31 +++++++++++++
>>  arch/arm/mach-exynos/Makefile                      |  6 +++
>>  arch/arm/mach-exynos/common.c                      | 34 ++++++++++++++
>>  arch/arm/mach-exynos/common.h                      |  2 +
>>  arch/arm/mach-exynos/exynos-smc.S                  | 22 +++++++++
>>  arch/arm/mach-exynos/firmware.c                    | 54
>> ++++++++++++++++++++++ arch/arm/mach-exynos/include/mach/map.h
>>  |  3 ++
>>  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
>>  arch/arm/mach-exynos/platsmp.c                     | 36 ++++++++++++---
>>  arch/arm/mach-exynos/smc.h                         | 31 +++++++++++++
>>  arch/arm/plat-samsung/include/plat/map-s5p.h       |  1 +
>>  14 files changed, 243 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/arm/common/firmware.c
>>  create mode 100644 arch/arm/include/asm/firmware.h
>>  create mode 100644 arch/arm/mach-exynos/exynos-smc.S
>>  create mode 100644 arch/arm/mach-exynos/firmware.c
>>  create mode 100644 arch/arm/mach-exynos/smc.h
>
> Any comments, nitpicks or acks on this patchset?
>
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
