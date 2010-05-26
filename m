From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 May 2010 22:18:19 +0800
Subject: [PATCH 7/8] pxa/income: Add Income SBC support
In-Reply-To: <20100524110155.GH30801@buzzloop.caiaq.de>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
	<1274480980-10109-8-git-send-email-marek.vasut@gmail.com>
	<20100524110155.GH30801@buzzloop.caiaq.de>
Message-ID: <AANLkTilAieHQmA5ltgsnKw0NrzG-Lvcj5_W4VsL-iejC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 7:01 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Sat, May 22, 2010 at 12:29:39AM +0200, Marek Vasut wrote:
>> This is support for custom design based on Toradex Colibri PXA270 CPU card.
>> Initial patch was by Pavel Revak.
>>
>> [daniel - rebased the code to follow the module/board split]
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> ---
>> ?MAINTAINERS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?7 +
>> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? | ? ?7 +
>> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/colibri-pxa270-income.c | ?272 +++++++++++++++++++++++++++++
>> ?arch/arm/mach-pxa/colibri-pxa270.c ? ? ? ?| ? 29 +++-
>> ?arch/arm/mach-pxa/include/mach/colibri.h ?| ? ?7 +
>> ?6 files changed, 320 insertions(+), 3 deletions(-)
>> ?create mode 100644 arch/arm/mach-pxa/colibri-pxa270-income.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa02bf2..38e760c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -696,6 +696,13 @@ T: ? ? ? git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
>> ?F: ? arch/arm/mach-sa1100/jornada720.c
>> ?F: ? arch/arm/mach-sa1100/include/mach/jornada720.h
>>
>> +ARM/INCOME PXA270 SUPPORT
>> +M: ? Marek Vasut <marek.vasut@gmail.com>
>> +L: ? linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> +S: ? Maintained
>> +F: ? arch/arm/mach-pxa/income.c
>> +F: ? arch/arm/mach-pxa/include/mach-pxa/income.h
>> +
>> ?ARM/INTEL IOP32X ARM ARCHITECTURE
>> ?M: ? Lennert Buytenhek <kernel@wantstofly.org>
>> ?M: ? Dan Williams <dan.j.williams@intel.com>
>> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
>> index 819b44f..2ff0b32 100644
>> --- a/arch/arm/mach-pxa/Kconfig
>> +++ b/arch/arm/mach-pxa/Kconfig
>> @@ -242,6 +242,13 @@ config MACH_COLIBRI_PXA270_EVALBOARD
>> ? ? ? bool "Toradex Colibri Evaluation Carrier Board support (PXA270)"
>> ? ? ? depends on MACH_COLIBRI
>>
>> +config MACH_COLIBRI_PXA270_INCOME
>> + ? ? bool "Income s.r.o. PXA270 SBC"
>> + ? ? depends on MACH_COLIBRI
>> + ? ? select PXA27x
>> + ? ? select HAVE_PWM
>> + ? ? select PXA_HAVE_BOARD_IRQS
>
> Hmm, now that we depend on MACH_COLIBRI, I think these auto-selects can
> go away as MACH_COLIBRI already cares for them, right?
>

Indeed. And if this income could be only used on colibri 270, I'd like to see
the naming be consistent with colibri-pxa270-evalboard.c. (though honestly,
I don't quite like a name to be that long)
> Daniel
>
