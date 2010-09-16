From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 16 Sep 2010 23:57:43 +0200
Subject: [PATCH 3/3] [ARM] tegra: harmony: enable PCI Express
In-Reply-To: <AANLkTimeUqfG4HruXbbZ6Bsi5qm-7OS3L+x+cSRZTi9H@mail.gmail.com>
References: <cover.1284655723.git.mike@compulab.co.il>
	<9bf488075bb8a10b4a4139ac8c6ef76196758ad3.1284655723.git.mike@compulab.co.il>
	<AANLkTimeUqfG4HruXbbZ6Bsi5qm-7OS3L+x+cSRZTi9H@mail.gmail.com>
Message-ID: <AANLkTinzc4SmyPg-pk1YD3BwrUwPSi5pOZpmn+TsKZkt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 11:44 PM, Colin Cross <ccross@google.com> wrote:
> On Thu, Sep 16, 2010 at 9:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-tegra/board-harmony-pcie.c | ? 52 ++++++++++++++++++++++++++++++
>> ?2 files changed, 53 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
>>
>> diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
>> new file mode 100644
>> index 0000000..824c0a1
>> --- /dev/null
>> +++ b/arch/arm/mach-tegra/board-harmony-pcie.c
>
> <snip>
>
>> +static int __init harmony_pcie_init(void)
>> +{
>> + ? ? ? int err;
>> +
>> + ? ? ? tegra_pinmux_set_tristate(TEGRA_PINGROUP_GPV, TEGRA_TRI_NORMAL);
>> + ? ? ? tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXA, TEGRA_TRI_NORMAL);
>> + ? ? ? tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXK, TEGRA_TRI_NORMAL);
> Can these go in the main harmony pinmux table?

The idea is to keep the pins in tristate unless PCIe is enabled explicitly.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
? ? Sincerely Yours,
? ? ? ? Mike.
