From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 11:00:39 +0100
Subject: [PATCH v5 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <20131209091951.GD5291@shlinux1.ap.freescale.net>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
 <52A587CD.7010203@pengutronix.de>
 <20131209091951.GD5291@shlinux1.ap.freescale.net>
Message-ID: <52A594C7.2000007@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 10:19 AM, Peter Chen wrote:
> On Mon, Dec 09, 2013 at 10:05:17AM +0100, Marc Kleine-Budde wrote:
>> On 12/09/2013 07:31 AM, Peter Chen wrote:
>>> After clear portsc.phcd, PHY needs 200us stable time for switch
>>> 32K clock to AHB clock.
>>
>> If this is a general bugbix, please move it to the start of this series
>> and add stable on Cc. I think I hit the bug on the second USB port of a
>> custom MX28 board, the stmp_reset_block() in the USB phy will fail.
> 
> Not a bug-fix, just the requirement for the PHY leaves low power mode.
> Does the bug exists with my this patchset, or just current mainline code?

I see, I found this strange thing on v3.8, but can try on v3.13-rc3.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/9b6bb951/attachment.sig>
