From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 22 Nov 2012 09:23:18 +0100
Subject: [PATCH 1/2] ARM: i.MX27: Add platform support for IRAM.
In-Reply-To: <20121116124823.GR10369@pengutronix.de>
References: <1352131185-12079-1-git-send-email-javier.martin@vista-silicon.com>
 <20121116124823.GR10369@pengutronix.de>
Message-ID: <CACKLOr3Gw-xz0YaVhYGM_FP6M+QOLGxdLjboxrx0Fj4wV2E6NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2012 13:48, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Nov 05, 2012 at 04:59:44PM +0100, Javier Martin wrote:
>> Add support for IRAM to i.MX27 non-DT platforms using
>> iram_init() function.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>>  arch/arm/mach-imx/mm-imx27.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
>> index e7e24af..fd2416d 100644
>> --- a/arch/arm/mach-imx/mm-imx27.c
>> +++ b/arch/arm/mach-imx/mm-imx27.c
>> @@ -27,6 +27,7 @@
>>  #include <asm/pgtable.h>
>>  #include <asm/mach/map.h>
>>  #include <mach/iomux-v1.h>
>> +#include <mach/iram.h>
>>
>>  /* MX27 memory map definition */
>>  static struct map_desc imx27_io_desc[] __initdata = {
>> @@ -94,4 +95,6 @@ void __init imx27_soc_init(void)
>>       /* imx27 has the imx21 type audmux */
>>       platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
>>                                       ARRAY_SIZE(imx27_audmux_res));
>> +     /* imx27 has an iram of 46080 bytes size */
>> +     iram_init(MX27_IRAM_BASE_ADDR, 46080);
>
> For this rather Philipps sram allocater patches should be used. This
> would also solve the problem that mach/iram.h cannot be accessed anymore
> in current -next. Fabio already sent a patch addressing this, but I
> think we should go for a proper fix rather than just moving iram.h
> to include/linux/

Fine, I'll take a look at Philipps' patches.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
