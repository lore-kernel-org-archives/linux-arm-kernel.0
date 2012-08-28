From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 28 Aug 2012 12:52:19 +0200
Subject: [PATCH] usb: chipidea: cleanup dma_pool if udc_start() fails
In-Reply-To: <20120828104617.GZ4011@b20223-02.ap.freescale.net>
References: <1346149885-3084-1-git-send-email-mkl@pengutronix.de>
 <20120828104617.GZ4011@b20223-02.ap.freescale.net>
Message-ID: <503CA2E3.6010707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2012 12:46 PM, Richard Zhao wrote:
> On Tue, Aug 28, 2012 at 12:31:25PM +0200, Marc Kleine-Budde wrote:
>> If udc_start() fails the qh_pool dma-pool cannot be closed because
>> it's still in use. This patch factors out the dma_pool_free() loop
>> into destroy_eps() and calls it in the error path of udc_start(),
>> too.
>>
>> Cc: Richard Zhao <richard.zhao@freescale.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> Richard, can you please include this patch in your stack. IIRC I think it once
>> was, but now it's not anymore.
> Sorry for that. I just push it to my topics/usb-driver branch.
> Of course, it's better, if Alex can give a ACK and Greg could pick up.

I'm not sure, if this [1] is the latest thread on this patch, but Greg
asked to queue this patch into your tree.

Marc

[1] http://comments.gmane.org/gmane.linux.usb.general/66440
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120828/6e88e645/attachment.sig>
