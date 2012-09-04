From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 04 Sep 2012 09:42:17 +0200
Subject: [PATCH 1/4] can: c_can: Adopt pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
 <1346673139-14540-2-git-send-email-anilkumar@ti.com>
 <5045161C.4000100@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
Message-ID: <5045B0D9.6060003@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2012 08:14 AM, AnilKumar, Chimata wrote:
> Hi Marc,
> 
> On Tue, Sep 04, 2012 at 02:12:04, Marc Kleine-Budde wrote:
>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>> Adopt pinctrl support to c_can driver based on c_can device
>>> pointer, pinctrl driver configure SoC pins to d_can mode
>>> according to definitions provided in .dts file.
>>>
>>> In device specific device tree file 'pinctrl-names = "default";'
>>> and 'pinctrl-0 = <&d_can1_pins>;' needs to add to configure pins
>>> from c_can driver. d_can1_pins node contains the pinmux/config
>>> details of d_can L/H pins.
>>
>> Looks good, is the pinctrl property documented in the dt bindings already?
>>
> 
> Yes, its here Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

Sorry, I meant not the generic pinctrl, but the c_can/d_can bindings
documentation (Documentation/devicetree/bindings/net/can/).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120904/07c12490/attachment.sig>
