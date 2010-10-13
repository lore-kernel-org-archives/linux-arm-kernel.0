From: claude.youn@gmail.com (Seungwhan Youn)
Date: Wed, 13 Oct 2010 17:48:31 +0900
Subject: [PATCH v2 1/6] ARM: S5P: Reduce duplicated EPLL control codes
In-Reply-To: <002401cb6aad$77ccfb80$6766f280$%kim@samsung.com>
References: <1286882399-27595-1-git-send-email-sw.youn@samsung.com>
	<1286883281-27656-1-git-send-email-sw.youn@samsung.com>
	<002401cb6aad$77ccfb80$6766f280$%kim@samsung.com>
Message-ID: <AANLkTikKF5jcu2ffB=Xf6LCSiXgTp4AL9T3niHAOXMvc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 5:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Seungwhan Youn wrote:
>>
>> S5P Samsung SoCs has a EPLL to support various PLL clock sources for other
>> H/W blocks. Until now, to control EPLL, each of SoCs make their own
> functions
>> in 'mach-s5pxxx/clock.c'. But some of functions, 'xxx_epll_get_rate()' and
>> 'xxx_epll_enable()', are exactly same in all S5P SoCs, so this patch move
>> these duplicated codes to common EPLL functions that use platform wide.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>> ---
>> ?arch/arm/mach-s5p64x0/clock-s5p6440.c ? ? ? ? ? | ? 16 ++++++++--------
>> ?arch/arm/mach-s5p64x0/clock-s5p6450.c ? ? ? ? ? | ? 16 ++++++++--------
>> ?arch/arm/mach-s5p64x0/clock.c ? ? ? ? ? ? ? ? ? | ? 18 ------------------
>> ?arch/arm/mach-s5p64x0/include/mach/regs-clock.h | ? ?4 ++--
>> ?arch/arm/mach-s5pc100/clock.c ? ? ? ? ? ? ? ? ? | ? 22
> ++--------------------
>> ?arch/arm/plat-s5p/clock.c ? ? ? ? ? ? ? ? ? ? ? | ? 20
>> ++++++++++++++++++++
>> ?arch/arm/plat-s5p/include/plat/s5p-clock.h ? ? ?| ? ?4 ++++
>> ?7 files changed, 44 insertions(+), 56 deletions(-)
>>
> Hi,
>
> Thanks for your updating EPLL control.
>
> I think, if we use just S5P64X0_EPLL_CON in the
> mach-s5p64x0/include/mach/regs-clock.h, no need to change many codes such as
> this patch.
> But need to re-define for compatibility like following in the mach-s5p64x0.
> ...
> +/* compatibility defines */
> +#define S5P_EPLL_CON ? ? ? ? ? S5P64X0_EPLL_CON
> ...
>
> Maybe as you know, S5PV310 EPLL configuration definition is different from
> the others.
> So need to add S5P_EPLL_CON definition for building.
>
> And actually, we need to sort out clock definitions for Samsung SoCs. Will
> do it soon.
>
> Anyway, could you please re-work this?
>

Okay, I'll re-work and re-send this right now.

Thank you,
Claude
