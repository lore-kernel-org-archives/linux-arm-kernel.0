From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Nov 2012 11:12:53 +0100
Subject: [PATCH v3] can: c_can: Add d_can raminit support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA77E29@DBDE01.ent.ti.com>
References: <1353490282-10853-1-git-send-email-mkl@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA77E29@DBDE01.ent.ti.com>
Message-ID: <50ACA925.60900@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 11:07 AM, AnilKumar, Chimata wrote:
> On Wed, Nov 21, 2012 at 15:01:22, Marc Kleine-Budde wrote:
>> From: AnilKumar Ch <anilkumar@ti.com>
>>
>> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
>> which holds all the message objects during transmission or
>> receiving of data. This initialization/de-initialization should
>> be done in synchronous with D_CAN clock.
>>
>> In case of AM335X-EVM (current user of D_CAN driver) message RAM is
>> controlled through control module register for both instances. So
>> control module register details is required to initialization or
>> de-initialization of message RAM according to instance number.
>>
>> Control module memory resource is obtained from D_CAN dt node and
>> instance number obtained from device tree aliases node.
>>
>> This patch was tested on AM335x-EVM along with pinctrl data addition
>> patch, d_can dt aliases addition and control module data addition.
>> pinctrl data addition is not added to am335x-evm.dts (only supports
>> CPLD profile#0) because d_can1 is supported under CPLD profile#1.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> [mkl: fix instance for non DT in probe, cleaned up raminit]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> compile time tested only - please test on real HW.
> 
> Hi Marc,
> 
> I tested this patch, its working.

Tnx, pushed to linux-can-next/master

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
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/f29a9e0a/attachment-0001.sig>
