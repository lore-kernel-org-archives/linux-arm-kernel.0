From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Jul 2013 15:16:00 -0300
Subject: [PATCH 3/3] ARM: imx: mm-imx3: Free l2x0_base
In-Reply-To: <20130709062414.GG16656@S2101-09.ap.freescale.net>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
 <1373306318-15604-3-git-send-email-festevam@gmail.com>
 <20130709062414.GG16656@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5D4ivbqYovVA2CpXEemrAq8Nyn5By8-iL3SAnw=mpJ+og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 9, 2013 at 3:24 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jul 08, 2013 at 02:58:38PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> After l2x0_base has been used, we should free it.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  arch/arm/mach-imx/mm-imx3.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
>> index 0884ca9..3143f5e 100644
>> --- a/arch/arm/mach-imx/mm-imx3.c
>> +++ b/arch/arm/mach-imx/mm-imx3.c
>> @@ -113,6 +113,7 @@ static void __init imx3_init_l2x0(void)
>>       }
>>
>>       l2x0_init(l2x0_base, 0x00030024, 0x00000000);
>> +     iounmap(l2x0_base);
>
> Are you sure?  I think cache-l2x0 driver still needs the mapping after
> that.

l2x0_base is a local variable of the static imx3_init_l2x0() function,
so we should iounmap it.
