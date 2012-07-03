From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Jul 2012 12:00:52 +0200
Subject: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
In-Reply-To: <20120702015206.GA21003@S2101-09.ap.freescale.net>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
 <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
 <4FF0D401.4050101@pengutronix.de>
 <20120702015206.GA21003@S2101-09.ap.freescale.net>
Message-ID: <4FF2C2D4.7070408@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2012 03:52 AM, Shawn Guo wrote:
> On Mon, Jul 02, 2012 at 12:49:37AM +0200, Marc Kleine-Budde wrote:
>>> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>> +	if (IS_ERR(pinctrl))
>>> +		return PTR_ERR(pinctrl);
>>> +
>>>  	if (pdev->dev.of_node) {
>>>  		const u32 *clock_freq_p;
>>
>> I'm on mx28 and trying to load the flexcan driver via DT, but
>> devm_pinctrl_get_select_default fails with -19.
>>
> You need to have pinctrl state setup in dts, some like:
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/174148

Works like charm.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/003854e2/attachment.sig>
