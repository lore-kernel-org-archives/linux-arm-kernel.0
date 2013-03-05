From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 5 Mar 2013 08:48:19 +0100
Subject: [PATCH v3 1/2] i.MX27: Add clock support for SAHARA2.
In-Reply-To: <20130304075306.GA1906@pengutronix.de>
References: <1362137873-8827-1-git-send-email-javier.martin@vista-silicon.com>
 <1362137873-8827-2-git-send-email-javier.martin@vista-silicon.com>
 <20130304075306.GA1906@pengutronix.de>
Message-ID: <CACKLOr2kuWXMreEFA4wqyYVRNnPwmEoHPM2+V+tN5P_1bQ+iJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 4 March 2013 08:53, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Mar 01, 2013 at 12:37:52PM +0100, Javier Martin wrote:
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>>  arch/arm/mach-imx/clk-imx27.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
>> index 4c1d1e4..0b9664a 100644
>> --- a/arch/arm/mach-imx/clk-imx27.c
>> +++ b/arch/arm/mach-imx/clk-imx27.c
>> @@ -253,6 +253,8 @@ int __init mx27_clocks_init(unsigned long fref)
>>       clk_register_clkdev(clk[nfc_baud_gate], NULL, "imx27-nand.0");
>>       clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
>>       clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "coda-imx27.0");
>> +     clk_register_clkdev(clk[sahara_ahb_gate], "ahb", "sahara-imx27.0");
>> +     clk_register_clkdev(clk[sahara_ipg_gate], "ipg", "sahara-imx27.0");
>
> One of the first patches I want to push upstream for the next merge
> window is this one:
>
> https://patchwork.kernel.org/patch/1817741/
>
> So the change above becomes unnecessary

Very good. Then this patch can be safely dropped.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
