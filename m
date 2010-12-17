From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Sat, 18 Dec 2010 00:07:27 +0100
Subject: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
In-Reply-To: <87bp4k6m1d.fsf@deeprootsystems.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<87bp4k6m1d.fsf@deeprootsystems.com>
Message-ID: <AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Sat, Dec 18, 2010 at 12:02 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch only contains clean-ups and cosmetic changes,
>> no functional change.
>>
>> Clean-up of the ASM sleep code, for better readability and
>> easier maintenance.
>>
>> Applies on top of Nishant's latest idle path errata fixes step 2,
>> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>
> Can you do one more spin of this series in order to collect the
> reviewed-by/tested-by tags posted, and address some of Nishanth's
> comments. ?Since we are reaching a merge window deadline, I'll leave it
> to your discretion to decide which of Nishanth's suggestions to address
> now and which to address later.
Sure I will post a new version tomorrow.
This will include some fixes after Nishant's comments. The rest can be
done later after we agree on the future changes.

Thanks,
Jean

>
> Kevin
>
>> Jean Pihet (7):
>> ? OMAP2+: use global values for the SRAM PA addresses
>> ? OMAP3: remove hardcoded values from the ASM sleep code
>> ? OMAP3: re-organize the ASM sleep code
>> ? OMAP3: rework of the ASM sleep code execution paths
>> ? OMAP3: add comments for low power code errata
>> ? OMAP3: ASM sleep code format rework
>> ? OMAP3: remove unused code from the ASM sleep code
>>
>> ?arch/arm/mach-omap2/control.c ? ? ? ? ?| ? ?9 +-
>> ?arch/arm/mach-omap2/control.h ? ? ? ? ?| ? ?2 +
>> ?arch/arm/mach-omap2/pm.h ? ? ? ? ? ? ? | ? ?1 -
>> ?arch/arm/mach-omap2/pm34xx.c ? ? ? ? ? | ? ?4 +-
>> ?arch/arm/mach-omap2/sdrc.h ? ? ? ? ? ? | ? ?1 -
>> ?arch/arm/mach-omap2/sleep34xx.S ? ? ? ?| ?724 +++++++++++++++++---------------
>> ?arch/arm/plat-omap/include/plat/sram.h | ? 11 +
>> ?arch/arm/plat-omap/sram.c ? ? ? ? ? ? ?| ? ?7 +-
>> ?8 files changed, 413 insertions(+), 346 deletions(-)
>
