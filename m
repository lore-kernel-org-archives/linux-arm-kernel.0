From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 16 Nov 2012 11:17:49 +0100
Subject: [PATCH 1/9] usb: chipidea: pci: mark platformdata as static and
 __devinitdata
In-Reply-To: <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-2-git-send-email-m.grzeschik@pengutronix.de>
 <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <50A612CD.8040004@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 11:06 AM, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> static yes, __devinitdata -- probably not. These structs are used
> everywhere throughout the driver currently, not only at initialization
> time.

Yes, but a copy of the platform_data is used:

The PCI driver calls ci13xxx_add_device():
http://lxr.free-electrons.com/source/drivers/usb/chipidea/ci13xxx_pci.c#L85

which calls  platform_device_add_data():
http://lxr.free-electrons.com/source/drivers/usb/chipidea/core.c#L364

which makes a copy of the platform_data:
http://lxr.free-electrons.com/source/drivers/base/platform.c#L246

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/005f48e5/attachment.sig>
