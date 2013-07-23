From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 23 Jul 2013 14:37:29 +0200
Subject: [PATCH v3 27/31] net: can: mscan: add common clock support for
 mpc512x
In-Reply-To: <20130723120733.GH19071@book.gsilab.sittig.org>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-28-git-send-email-gsi@denx.de>
 <51ED2DF4.2090606@pengutronix.de>
 <20130723120733.GH19071@book.gsilab.sittig.org>
Message-ID: <51EE7909.6080804@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:07 PM, Gerhard Sittig wrote:
[...]

>>> +	return freq_calc;
>>> +
>>> +err_invalid:
>>> +	dev_err(&ofdev->dev, "invalid clock source specification\n");
>>> +	return 0;
>>
>> return 0 in case of error? Please add a comment what this 0 means here.
> 
> The .get_clock() callback is supposed to return the resulting
> rate after the clock source was determined and the clock subtree
> was setup.  It wasn't (explicitly) documented before (in the
> non-common-clock case), so I did not bother to comment it in the
> parallel common-clock case.

Yes, but returning 0 in case of error should be documented, as it's very
uncommon.

> But it's true that returning zero in the error case may be
> unexpected, and I will add a comment in v4 (in all the
> .get_clock() implementations).

I think a one liner stating that the return value is the clock rate and
"0" indicates is an invalid clock rate, this meaning an error here, is
enough.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/e4b5a260/attachment.sig>
