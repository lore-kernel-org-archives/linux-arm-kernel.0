From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 10:33:58 +0100
Subject: [PATCH v2] i2c: at91: fix SMBus quick command
In-Reply-To: <1352821401-1944-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352821401-1944-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121114093358.GC5954@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 04:43:21PM +0100, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> The driver claims to support SMBus quick command but it was not the case.
> This patch fixes this issue.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> Hi Wolfram,
> 
> Thanks to Jean explanation about i2cdetect and eeprom behavior, I realized
> that the first version of the patch was incorrect. This time all the i2c
> devices are detected with i2cdetect -q.
> 
> I hope this fix could go into 3.7 since the driver claims SMBus quick
> capability but it doesn't support it. Moreover without it i2cdetect find
> imaginary devices, and with some IP versions, trying to send 0 byte can cause
> issue when writing data to an EEPROM.

Updated the commit message with the latter paragraph and added to
for-current, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/45ccbe2b/attachment-0001.sig>
