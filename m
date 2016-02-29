From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 29 Feb 2016 11:00:09 +0100
Subject: [PATCH 1/2] can: rcar_can: Add r8a7795 support
In-Reply-To: <SG2PR06MB10380FC567E038EA92D5401EC3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D411A5.9070706@pengutronix.de>
 <SG2PR06MB10380FC567E038EA92D5401EC3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Message-ID: <56D416A9.6080608@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 10:56 AM, Ramesh Shanmugasundaram wrote:
>> On 02/29/2016 10:21 AM, Ramesh Shanmugasundaram wrote:
>>> Added r8a7795 SoC support.
>>>
>>> For smoother bit timing calculation, the rounded clock frequency is
>> used.
>>
>> Why this? From my point of view this introduces a clock error.
> 
> Thanks for the comments. 
> 
> Without the rounded clock, can_calc_bittiming returns different BRP
> values and reports high sampling error percentage. However, the
> rounded clock shows no such issues and it works fine for all
> bitrates.
> 
> Below is an e.g. from my board for an input clock differs by 2Hz.

I think it's better to fix the algorithm. I'll look into it.

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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/e6ca9453/attachment.sig>
