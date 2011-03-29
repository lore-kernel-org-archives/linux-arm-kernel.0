From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 29 Mar 2011 12:05:45 +0200
Subject: mx28 sdio problems
In-Reply-To: <20110326141312.GA17797@S2100-06.ap.freescale.net>
References: <1298284979-14853-7-git-send-email-shawn.guo@freescale.com>	<1298364624-19907-1-git-send-email-shawn.guo@freescale.com>	<4D8C809D.9010202@pengutronix.de>
	<20110326141312.GA17797@S2100-06.ap.freescale.net>
Message-ID: <4D91AEF9.4080401@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2011 03:13 PM, Shawn Guo wrote:
> On Fri, Mar 25, 2011 at 12:46:37PM +0100, Marc Kleine-Budde wrote:
>> On 02/22/2011 09:50 AM, Shawn Guo wrote:
>>> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>>
>> I ported these patches to current mainline (the to be released
>> 2.6.39-rc1). mmc works with sd and sdhc cards without problems on my
>> mx28evk.
>>
>> However sdio doesn't work. When I plug a sdio wlan card the kernel gives
>> me the following error messages in a loop:
>>
>> [ 1002.760000] mmc1: new SDIO card at address 0001
>> [ 1003.760000] mmc1: card 0001 removed
>> [ 1003.810000] mmc1: new SDIO card at address 0001
>> [ 1004.810000] mmc1: card 0001 removed
>>
>> Any hints how to debug?
>>
> The only problem I had when testing an Atheros sdio wifi cards was
> the shortage of power supply on slot1 (internal regulator powered).
> The slot2 on mx28evk just works out of box with this sdio card.  You
> also rework the board to get the slot1 be powered by external
> regulator just like slot2.

I just received an atheros sd25, the card gets recognized. No driver to
test more.

However with the old card the problem remains. On my sheeva plug I see
the same problems with the old card.

cheers, Marc

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110329/a2ea84e9/attachment.sig>
