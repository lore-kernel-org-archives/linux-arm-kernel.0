From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 7 Aug 2015 19:55:43 +0530
Subject: [PATCH 0/4] omap: Fix broken pbias device creation
In-Reply-To: <CALeDE9OBjESdkXhkAEVj1L-XKJ1yoFg8rkHvcJ_Uj_RXOC-yUQ@mail.gmail.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>	<55B89590.6000109@ti.com>	<20150805100009.GY16878@atomide.com>
 <CALeDE9OBjESdkXhkAEVj1L-XKJ1yoFg8rkHvcJ_Uj_RXOC-yUQ@mail.gmail.com>
Message-ID: <55C4BFE7.2070302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Friday 07 August 2015 05:18 PM, Peter Robinson wrote:
> On Wed, Aug 5, 2015 at 11:00 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [150729 02:01]:
>>> On 07/27/2015 03:16 PM, Kishon Vijay Abraham I wrote:
>>>> pbias device creation got broken once SCM cleanup got merged.
>>>> This patch series re-enables device creation by adding
>>>> "simple-bus" in the compatible property of the syscon
>>>> dt node.
>>>>
>>>> validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
>>>> boards.
>>>>
>>>> Kishon Vijay Abraham I (4):
>>>>   ARM: dts: omap24xx: Fix broken pbias device creation
>>>>   ARM: dts: OMAP4: Fix broken pbias device creation
>>>>   ARM: dts: OMAP5: Fix broken pbias device creation
>>>>   ARM: dts: dra7: Fix broken pbias device creation
>>>>
>>>>  arch/arm/boot/dts/dra7.dtsi     |    2 +-
>>>>  arch/arm/boot/dts/omap2430.dtsi |    3 ++-
>>>>  arch/arm/boot/dts/omap4.dtsi    |    3 ++-
>>>>  arch/arm/boot/dts/omap5.dtsi    |    3 ++-
>>>>  4 files changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>
>>> For dra7-evm:
>>> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Applying all into omap-for-v4.2fixes-v2 thanks.
> 
> Do we need the same for am33xx.dtsi too given commit e3bc5358e097 ?

PBIAS is not present in am33xx.

Thanks
Kishon
