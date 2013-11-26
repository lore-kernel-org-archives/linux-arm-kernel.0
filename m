From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 26 Nov 2013 09:35:01 +0100
Subject: [PATCH v2 1/2] can: flexcan: use correct clock as base for bit
 rate calculation
In-Reply-To: <52945B5A.9070601@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
 <1385414121-21493-2-git-send-email-mkl@pengutronix.de>
 <52945B5A.9070601@pengutronix.de>
Message-ID: <52945D35.70103@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 09:27 AM, Marc Kleine-Budde wrote:
> On 11/25/2013 10:15 PM, Marc Kleine-Budde wrote:
>> The flexcan IP core uses the peripheral clock ("per") as basic clock for the
>> bit timing calculation. However the driver uses the the wrong clock ("ipg").
>> This leads to wrong bit rates if the rates on both clock are different.
>>
>> This patch fixes the problem by using the correct clock for the bit rate
>> calculation.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
If you take the patch, please add:

Cc: linux-stable <stable@vger.kernel.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/5b10d1fc/attachment.sig>
