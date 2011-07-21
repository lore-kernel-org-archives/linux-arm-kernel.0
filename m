From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 21 Jul 2011 12:17:18 +0300
Subject: [PATCH v2] ARM: Tegra: Trimslice: Tri-state DAP3 pinmux
In-Reply-To: <CABpLfohE+PmssbicDjS3p13i=T4X5dZ=P-KhXmytvPX2An62=w@mail.gmail.com>
References: <1310596967-19996-1-git-send-email-swarren@nvidia.com>
	<CABpLfohE+PmssbicDjS3p13i=T4X5dZ=P-KhXmytvPX2An62=w@mail.gmail.com>
Message-ID: <CABpLfohhtux1S6eJg+U7kgckw4j2vhMuWo8mBRaMpoZr5PuBiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 10:10 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
>> DAP3 is used for a bunch of GPIOs. Not tri-stating the pins means audio
>> signals get sent out there, and this ends up resetting USB and breaking
>> SDHCI too.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> v2: s/DAP2/DAP3/ in patch subject/description.
>
> Setting DAP3 pins to tristate is necessary but not sufficient :) I
> don't know why, but if we don't tristate DAP2 and DAP4 as well USB and
> SDIO are broken.
> If you can amend your patch with tristating also DAP2 and DAP4 feel
> free to add my

Oops, I should have read the diff context as well... DAP{2,4} are
anyway tristate, so you can discard my previous comment. So the
Acked-by applies to the original patch. Sorry for the noise.

> Acked-by: Mike Rapoport <mike@compulab.co.il>
>
>> ?arch/arm/mach-tegra/board-trimslice-pinmux.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
>> index 82646a4..47c596c 100644
>> --- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
>> +++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
>> @@ -35,7 +35,7 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
>> ? ? ? ?{TEGRA_PINGROUP_CSUS, ?TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN, ? TEGRA_TRI_TRISTATE},
>> ? ? ? ?{TEGRA_PINGROUP_DAP1, ?TEGRA_MUX_DAP1, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_NORMAL},
>> ? ? ? ?{TEGRA_PINGROUP_DAP2, ?TEGRA_MUX_DAP2, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_TRISTATE},
>> - ? ? ? {TEGRA_PINGROUP_DAP3, ?TEGRA_MUX_DAP3, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_NORMAL},
>> + ? ? ? {TEGRA_PINGROUP_DAP3, ?TEGRA_MUX_DAP3, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_TRISTATE},
>> ? ? ? ?{TEGRA_PINGROUP_DAP4, ?TEGRA_MUX_DAP4, ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_TRISTATE},
>> ? ? ? ?{TEGRA_PINGROUP_DDC, ? TEGRA_MUX_I2C2, ? ? ? ? ?TEGRA_PUPD_PULL_UP, ? ? TEGRA_TRI_NORMAL},
>> ? ? ? ?{TEGRA_PINGROUP_DTA, ? TEGRA_MUX_VI, ? ? ? ? ? ?TEGRA_PUPD_NORMAL, ? ? ?TEGRA_TRI_TRISTATE},
>> --
>> 1.7.0.4
>>
>>
>
>
>
> --
> Sincerely Yours,
> Mike.
>



-- 
Sincerely Yours,
Mike.
