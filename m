From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 05 Apr 2013 14:14:06 +0200
Subject: mmc: mxs-mmc: add non-removeable property
In-Reply-To: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
References: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
Message-ID: <515EC00E.5060009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 02:01 PM, Alexandre Pereira da Silva wrote:
> I just sent a patch to fix the same thing to the list, without seeing
> yours first.
> 
> But in the discussion, I learned that I should be checking for
> broken-cd instead of non-removable.

I'm not subscribed to linux-mmc and on
http://news.gmane.org/gmane.linux.kernel.mmc I just see Marek's
Reviewed-by. Can you point me to the discussion?

In fact my board has an eMMC, which is soldered to the board and the
card detect is not connected...the documentation says:

>   - broken-cd: There is no card detection available; polling must be used.
>   - non-removable: non-removable slot (like eMMC); assume always present.

I see no point in using polling if the card is in deed always present.

> Would you like for me to send a separate patch for broken-cd or do you
> prefer to check on yours when you resubmit?

If your card detect is not connected and the card is removable, you
should use broken-cd and base you patch on mine.

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/c8e8ab65/attachment.sig>
