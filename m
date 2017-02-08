From: michael.heimpold@i2se.com (Michael Heimpold)
Date: Wed, 8 Feb 2017 07:43:56 +0100
Subject: [PATCH v3 5/9] Documentation: DT: add entries for I2SE boards
In-Reply-To: <20170201171838.vihswvpdro54aqiq@rob-hp-laptop>
References: <1485845475-3129-1-git-send-email-michael.heimpold@i2se.com>
 <1485845475-3129-6-git-send-email-michael.heimpold@i2se.com>
 <20170201171838.vihswvpdro54aqiq@rob-hp-laptop>
Message-ID: <769dba11-e290-50e0-d894-9f4ea08eb652@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

thanks for your review. Some questions below:


Am 01.02.2017 um 18:18 schrieb Rob Herring:
> On Tue, Jan 31, 2017 at 07:51:11AM +0100, Michael Heimpold wrote:
>> From: Michael Heimpold <mhei@heimpold.de>
> "dt-bindings: arm:" is preferred subject prefix.
Will change it in next round.
>> This patch adds the missing devicetree binding documentation for I2SE's
>> Duckbill and Duckbill 2 series boards.
>>
>> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   Documentation/devicetree/bindings/arm/i2se.txt | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/i2se.txt b/Documentation/devicetree/bindings/arm/i2se.txt
>> new file mode 100644
>> index 0000000..9954d86
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/i2se.txt
>> @@ -0,0 +1,22 @@
>> +I2SE Device Tree Bindings
>> +-------------------------
>> +
>> +Duckbill Board
>> +Required root node properties:
>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>> +
>> +Duckbill 2 Board
>> +Required root node properties:
>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>> +
>> +Duckbill 2 485 Board
>> +Required root node properties:
>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>> +
>> +Duckbill 2 EnOcean Board
>> +Required root node properties:
>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>> +
>> +Duckbill 2 SPI Board
>> +Required root node properties:
>> +    - compatible = "i2se,duckbill", "fsl,imx28";
> It's kind of pointless to have "i2se,duckbill" if you use the same one
> for all these boards.
At the moment, this is only used to fix-up the MAC address' OUI part
in mxs_machine_init. So my proposal would be to use
compatible = "i2se,duckbill-2", "fsl,imx28";
for the Duckbill 2 board and something like
compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
for the rest. This way we need to add only one additional check in mxs_machine_init check.

Would this be a way to go?

Best regards,
Michael

> Rob

Mit freundlichen Gr??en / Kind regards
Michael Heimpold
-- 
Software Engineer

I2SE GmbH                           Tel: +49 (0) 341 355667-00
Friedrich-Ebert-Str. 61             Fax: +49 (0) 341 355667-02
04109 Leipzig
Germany
Web: http://www.i2se.com/           Mail: info at i2se.com
VAT No.: DE 811528334
Amtsgericht Leipzig HRB 23784
Gesch?ftsf?hrer/CEO: Carsten Ziermann

*** Diese E-Mail ist allein f?r den bezeichneten Adressaten bestimmt. Sie kann rechtlich vertrauliche Informationen enthalten. Wenn Sie diese E-Mail irrt?mlich erhalten haben, informieren Sie bitte unverz?glich den Absender per E-Mail und l?schen Sie diese E-Mail von Ihrem Computer, ohne Kopien anzufertigen.
Vielen Dank. ***

*** This email is for the exclusive use of the addressee. It may contain legally privileged information. If you have received this message in error, please notify the sender by email immediately and delete the message from your computer without making any copies.
Thank you. ***
