From: Russ.Dill@ti.com (Russ Dill)
Date: Tue, 27 Mar 2012 11:32:13 -0700
Subject: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
In-Reply-To: <4F71E290.2050403@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
 <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
 <4F71E290.2050403@compulab.co.il>
Message-ID: <CA+Bv8XYiv+gr4yB+k7sWSSjdYSsYdnRJuTO3A5zZhh4bkoziXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No objection.

On Tue, Mar 27, 2012 at 8:53 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hi Russ,
>
> This patch works, but can we, please use the attached patch instead?
>
> Thanks
>
> On 03/23/12 11:21, Russ Dill wrote:
>> Signed-off-by: Russ Dill <russ.dill@ti.com>
>> ---
>> ?arch/arm/mach-omap2/board-cm-t35.c | ? ?9 +++++++++
>> ?1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
>> index 41b0a2f..289ded3 100644
>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> @@ -26,6 +26,7 @@
>>
>> ?#include <linux/i2c/at24.h>
>> ?#include <linux/i2c/twl.h>
>> +#include <linux/regulator/fixed.h>
>> ?#include <linux/regulator/machine.h>
>> ?#include <linux/mmc/host.h>
>>
>> @@ -630,10 +631,18 @@ static inline void cm_t3730_init_mux(void) {}
>> ?static struct omap_board_config_kernel cm_t35_config[] __initdata = {
>> ?};
>>
>> +static struct regulator_consumer_supply dummy_supplies[] = {
>> + ? ? REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>> + ? ? REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>> + ? ? REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
>> + ? ? REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
>> +};
>> +
>> ?static void __init cm_t3x_common_init(void)
>> ?{
>> ? ? ? omap_board_config = cm_t35_config;
>> ? ? ? omap_board_config_size = ARRAY_SIZE(cm_t35_config);
>> + ? ? regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>> ? ? ? omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
>> ? ? ? omap_serial_init();
>> ? ? ? omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>
> --
> Regards,
> Igor.
