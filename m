From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 25 Mar 2015 22:44:02 +0100
Subject: [PATCH resend] ASoC: fsl-ssi: Fix bitclock calculation
 for master mode
In-Reply-To: <20150325165814.GJ3572@sirena.org.uk>
References: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
 <20150325165814.GJ3572@sirena.org.uk>
Message-ID: <55132C22.3050503@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2015 05:58 PM, Mark Brown wrote:
> On Mon, Mar 23, 2015 at 03:46:12PM +0100, Marc Kleine-Budde wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> in fsl_ssi_set_bclk we are looking for the best divider by iterating
>> over all possible dividers. The divider is in the range 1..256, so
> 
> This doesn't apply against current code, please check and resend.

The problem has been fixed by:

    6c8ca30eec7b ASoC: fsl_ssi: Don't try to round-up for PM divisor
                 calculation

in the meantime.

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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/32e62430/attachment.sig>
