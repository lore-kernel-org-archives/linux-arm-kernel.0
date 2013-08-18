From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun, 18 Aug 2013 10:00:34 +0200
Subject: [PATCH RESEND] can: mcp251x: Replace power callbacks with
 regulator API
In-Reply-To: <1376773805.878998573@f169.i.mail.ru>
References: <1375963227-6468-1-git-send-email-shc_work@mail.ru>
 <20130817083014.a01144051b158c34ec7dd9d9@mail.ru>
 <520FD60E.4040709@pengutronix.de> <1376773805.878998573@f169.i.mail.ru>
Message-ID: <52107F22.80002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 11:10 PM, Alexander Shiyan wrote:
[...]

>>> - xceiver-supply: Regulator that powers the CAN transceiver
>>
>> which translates into:
>>
>>> priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
>>
>> Can you please use "xceiver" instead of "transceiver", so that future DT
>> binding will fit the scheme.
> 
> OK. I am not ready to add DT support yet, but it can be added later,

DT support can be added later, I just want to make sure that you use
"xceiver" for the regulator, so that you don't need to change any code
if DT is added.

> so v2 will contain 3 parts:

If you mean series v3 consists of three patches....

> 1 - Replace power callbacks with regulator API
> 2 - Eliminate mcp251x_platform_data->irq_flags
> 3 - Replace oscillator_frequency with CLK API (and remove mcp251x.h header)
> 
> Are you OK with such changes?

...them I'm okay :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130818/53d32f03/attachment-0001.sig>
