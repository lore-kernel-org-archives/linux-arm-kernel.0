From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 02 May 2013 11:03:01 -0300
Subject: [PATCH] ARM: sun4i: cubieboard: Enable the i2c controllers
In-Reply-To: <2206623.mnYPZ5KTnx@wuerfel>
References: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
 <2206623.mnYPZ5KTnx@wuerfel>
Message-ID: <51827215.100@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

El 02/05/13 10:43, Arnd Bergmann escribi?:
> On Thursday 02 May 2013 09:37:46 Emilio L?pez wrote:
>> The Cubieboard makes use of the first two i2c controllers found on the
>> Allwinner A10; i2c-0 is used internally for the PMIC, while i2c-1
>> is exposed on the board headers. This patch enables them in the device
>> tree.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> Shouldn't you list the attached devices in the same patch?
> 
> What is the point of enabling the I2C bus if there are no devices
> to be found?

This is complementary to the series titled "Add I2C support for
Allwinner SoCs" sent by Maxime today. We have no driver for the AXP20
PMIC yet, and the external header is left for the user to connect, so I
haven't added any device. This is still useful though, as it lets you
use I2C from userspace (i2cdetect, i2cdump, etc).

Regards,

Emilio
