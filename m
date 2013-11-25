From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 11:51:31 +0100
Subject: [PATCH] ARM i.MX5: fix "shift" value for lp_apm_sel
In-Reply-To: <1385375847.678349974@f369.i.mail.ru>
References: <1385375474-15901-1-git-send-email-mkl@pengutronix.de>
 <1385375847.678349974@f369.i.mail.ru>
Message-ID: <52932BB3.8020009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 11:37 AM, Alexander Shiyan wrote:
>> According to the i.MX53 Rev. 2.1 datasheet the lp_apm_sel is bit 10 in the
>> CCM_CCSR register not bit 9.
>>
>> This patch fixes this issue.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
>> index 3f01df2..867d623 100644
>> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
>> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
>> @@ -98,7 +98,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>>  	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", rate_ckih1);
>>  	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", rate_ckih2);
>>  
>> -	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
>> +	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
>>  						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
> 
> This is not valid for i.MX51.

Thanks yes, I'll take this into account.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/48761c4d/attachment.sig>
