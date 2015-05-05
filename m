From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 5 May 2015 10:31:23 +0200
Subject: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core
 extensions
In-Reply-To: <55487B1D.1060108@pengutronix.de>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
 <55487B1D.1060108@pengutronix.de>
Message-ID: <55487FDB.6060708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2015 10:11 AM, Marc Kleine-Budde wrote:
> On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
>> Fill in the HW capabilities in watchdog_device structure and call
>> watchdgog_init_params() to let watchdog core to init itself
>> properly. The watchdog core can then ping stopped watchdog and the
>> timer code in the driver can be removed.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> 
> This patch changes the default behaviour of the imx watchdog. Without
> the patch: If the system boot with watchdog enabled (by the bootloader),
> the driver sets up a threads to pet the watchdog. With the patch,
> imx2_wdt_ping() is called once during probe but the thread is not
> started. There are no timeout or early_timeout paremters in the DT or in
> the kernel command line.
> 
> I don't like the old behaviour, but I think there are some setups that
> rely on this feature.

BTW: the start-thread-if-wd-is-active feature was added in:

    faad5de0b104 watchdog: imx2_wdt: convert to watchdog core api

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
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/394b4816/attachment.sig>
