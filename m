From: hs@denx.de (Heiko Schocher)
Date: Tue, 24 Jan 2012 08:18:28 +0100
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <4F1DC480.4010603@gmail.com>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de> <4F1DC480.4010603@gmail.com>
Message-ID: <4F1E5B44.4090200@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

Sylwester Nawrocki wrote:
> Hello,
> 
> On 01/23/2012 09:56 AM, Heiko Schocher wrote:
>> add of support for the davinci i2c driver.
>>
>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-i2c at vger.kernel.org
>> Cc: Ben Dooks<ben-linux@fluff.org>
>> Cc: Wolfram Sang<w.sang@pengutronix.de>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
>> ---
>>   .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>>   drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>>   2 files changed, 82 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> new file mode 100644
>> index 0000000..94ec670
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> @@ -0,0 +1,39 @@
>> +* Texas Instruments Davinci I2C
>> +
>> +This file provides information, what the device node for the
>> +davinci i2c interface contain.
>> +
>> +Required properties:
>> +- compatible: "ti,davinci-i2c";
>> +- reg : Offset and length of the register set for the device
>> +- id: id of the controller
> 
> I was wondering whether we're supposed to use "cell-index" property name
> for such a device instance index? or doesn't it really matter and "id" is 
> fine? Such an IP instance index seems quite common so I thought it could
> be easier to follow to use standard name.

I just copied the "name" from "struct davinci_nand_pdata" ... it is
used in the davinci_nand driver as chipselect ... maybe it is better
I rename this to "chipselect" ?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
