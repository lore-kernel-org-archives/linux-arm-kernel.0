From: d.lavnikevich@sam-solutions.net (Dmitry Lavnikevich)
Date: Fri, 12 Sep 2014 18:55:46 +0300
Subject: [PATCH 1/5] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
In-Reply-To: <1410425238.4011.18.camel@paszta.hi.pengutronix.de>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>	
 <1410356809-26179-2-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410425238.4011.18.camel@paszta.hi.pengutronix.de>
Message-ID: <54131782.2000204@sam-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/14 11:47, Philipp Zabel wrote:
> Am Mittwoch, den 10.09.2014, 16:46 +0300 schrieb Dmitry Lavnikevich:
>> Since pins and frequency are specific to module (pfla02), not base board
>> (pbab02), it is better to be initialized in corresponding dts file.
>>
>> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> I have seen boards use the GPIO_3/6 pads instead of EIM_D17/D18 for
> I2C3, but the EIM_D17/D18 are indeed documented as "I2C1" pins at the
> pfla02 connector level.
>
> regards
> Philipp
>
Yes, that is why I thought about moving it into pfla02. But apart from
it, i2c2grp i2c3grp nodes was wrongly placed under iomuxc node while
it should be grouped inside of it, like in imx6q-phytec-pfla02 to
which it was moved with this patch.
Because of this specified i2c wasn't working correctly and caused
messages:

imx6q-pinctrl 20e0000.iomuxc: no groups defined in 
/soc/aips-bus at 02000000/iomuxc at 020e0000/i2c2grp
imx6q-pinctrl 20e0000.iomuxc: no groups defined in 
/soc/aips-bus at 02000000/iomuxc at 020e0000/i2c3grp
imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c2grp
imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c3grp

Added this into commit message with new patchset.

Best regards,
Lavnikevich Dmitry
