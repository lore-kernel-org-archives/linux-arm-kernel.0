From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Dec 2013 10:28:44 +0100
Subject: [PATCH v4 17/17] usb: phy-mxs: do not set PWD.RXPWD1PT1 for low
 speed connection
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649804141031@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-18-git-send-email-peter.chen@freescale.com>
 <529D9BF7.1080707@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649804141031@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <529DA44C.9090702@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 10:19 AM, Peter Chen wrote:
>> On 12/03/2013 08:37 AM, Peter Chen wrote:
>>> At very rare cases, the SoF will not send out after resume with
>>> low speed connection. The workaround is do not power down
>>> PWD.RXPWD1PT1 bit during the suspend.
>>
>> Is this also a fix for newly added code? If so please also squash.

> No, it is a workaround for new problem.

If this would be a fix, it's better to put this as first patch into a
series, so that it can be applied to the stable trees easier.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/0a1ccb14/attachment.sig>
