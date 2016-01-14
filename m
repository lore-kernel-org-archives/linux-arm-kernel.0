From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 14 Jan 2016 09:57:14 +0100
Subject: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <8579242.omBpg1aLr2@wuerfel>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
 <20160113170324.GO2588@ulmo> <8579242.omBpg1aLr2@wuerfel>
Message-ID: <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2016 at 21:43, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
>> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
>> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
>> > dependent upon a particular power-domain are only probed when that power
>> > domain has been powered up, requires that PM is made mandatory for tegra
>> > 64-bit devices and so select this option for tegra as well.
>> >
>> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> > ---
>> >  arch/arm64/Kconfig.platforms | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> > index 9806324fa215..e0b5bd0aff0f 100644
>> > --- a/arch/arm64/Kconfig.platforms
>> > +++ b/arch/arm64/Kconfig.platforms
>> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
>> >       select GENERIC_CLOCKEVENTS
>> >       select HAVE_CLK
>> >       select PINCTRL
>> > +     select PM
>> > +     select PM_GENERIC_DOMAINS
>> >       select RESET_CONTROLLER
>> >       help
>> >         This enables support for the NVIDIA Tegra SoC family.
>>
>> This has potential consequences for multi-platform builds, doesn't it?
>> All of a sudden any combination of builds that includes Tegra won't be
>> possible to build without PM support.
>>
>> Adding linux-arm-kernel at lists.infradead.org for visibility.
>>
>>
>
> Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
> dependencies in the drivers that require it.
>

The problem with that approach is that if those drivers are cross SoC
drivers. In some cases PM isn't needed and it is.

Of course I don't have the in depth knowledge about the drivers being
used in Tegra which may need PM, perhaps it's not that many?

Anyway, to me it seems like ARCH_TEGRA should depend on PM instead.
Would that work?

Kind regards
Uffe
