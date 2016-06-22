From: richard.andrysek@gomtec.de (Richard Andrysek)
Date: Wed, 22 Jun 2016 18:43:01 +0000
Subject: AW: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.
In-Reply-To: <612130a4-30ea-ed73-ac8e-dabe7919ec35@pengutronix.de>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
 <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
 <612130a4-30ea-ed73-ac8e-dabe7919ec35@pengutronix.de>
Message-ID: <0120733A154AE74CA608A286CE7FFD2621E13EB5@rg-contact.RG.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for a delay. I've run my test with 16 messages per channel (can0, can1 concurrently) with a cycle time 2.8ms, 1Mbps. And it works now properly.

Thank you all participated on this issue

Richard

-----Urspr?ngliche Nachricht-----
Von: Marc Kleine-Budde [mailto:mkl at pengutronix.de] 
Gesendet: Freitag, 17. Juni 2016 11:04
An: tthayer at opensource.altera.com; socketcan at hartkopp.net; wg at grandegger.com; Richard Andrysek <richard.andrysek@gomtec.de>
Cc: anilkumar at ti.com; linux-can at vger.kernel.org; linux-arm-kernel at lists.infradead.org; tthayer.linux at gmail.com
Betreff: Re: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.

On 06/16/2016 06:10 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> When testing CAN write floods on Altera's CycloneV, the first 2 bytes 
> are sometimes 0x00, 0x00 or corrupted instead of the values sent. Also 
> observed bytes 4 & 5 were corrupted in some cases.
> 
> The D_CAN Data registers are 32 bits and changing from
> 16 bit writes to 32 bit writes fixes the problem.
> 
> Testing performed on Altera CycloneV (D_CAN).
> Requesting tests on other C_CAN & D_CAN platforms.
> 
> Reported-by: Richard Andrysek <richard.andrysek@gomtec.de>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>

Applied to can with stable on Cc.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
