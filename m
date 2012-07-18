From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 18 Jul 2012 12:16:02 +0200
Subject: [PATCH v2] can: flexcan: add 2nd clock to support imx53 and newer
In-Reply-To: <50068A54.80705@gmail.com>
References: <1342601282-1208-1-git-send-email-mkl@pengutronix.de>
 <50068A54.80705@gmail.com>
Message-ID: <50068CE2.9090408@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 12:05 PM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>> This patch adds support for a second clock to the flexcan driver. On
>> modern freescale ARM cores like the imx53 and imx6q two clocks ("ipg"
>> and "per") must be enabled in order to access the CAN core.
>>
>> In the original driver, the clock was requested without specifying the
>> connection id, further all mainline ARM archs with flexcan support
>> (imx28, imx25, imx35) register their flexcan clock without a
>> connection id, too.
>>
>> This patch first renames the existing clk variable to clk_ipg and
>> converts it to devm for easier error handling. The connection id "ipg"
>> is added to the devm_clk_get() call. Then a second clock "per" is
>> requested. As all archs don't specify a connection id, both clk_get
>> return the same clock. This ensures compatibility to existing flexcan
>> support and adds support for imx53 at the same time.
>>
>> After this patch hits mainline, the archs may give their existing
>> flexcan clock the "ipg" connection id and implement a dummy "per"
>> clock.
>>
>> This patch has been tested on imx28 (unmodified clk tree) and on imx53
>> with a seperate "ipg" and "per" clock.
>>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Hui Wang <jason77.wang@gmail.com>
>>   
> Acked-by: Hui Wang <jason77.wang@gmail.com>

tnx, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/209e6a46/attachment.sig>
