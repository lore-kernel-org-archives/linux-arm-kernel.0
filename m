From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Feb 2017 08:37:09 -0600
Subject: [PATCH v3 5/9] Documentation: DT: add entries for I2SE boards
In-Reply-To: <769dba11-e290-50e0-d894-9f4ea08eb652@i2se.com>
References: <1485845475-3129-1-git-send-email-michael.heimpold@i2se.com>
 <1485845475-3129-6-git-send-email-michael.heimpold@i2se.com>
 <20170201171838.vihswvpdro54aqiq@rob-hp-laptop>
 <769dba11-e290-50e0-d894-9f4ea08eb652@i2se.com>
Message-ID: <CAL_JsqJYymQLuuujWyMYqZR0hYWAMAc7uV-eqMhrCXK_6b=k=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 12:43 AM, Michael Heimpold
<michael.heimpold@i2se.com> wrote:
> Hi Rob,
>
> thanks for your review. Some questions below:
>
>
> Am 01.02.2017 um 18:18 schrieb Rob Herring:
>>
>> On Tue, Jan 31, 2017 at 07:51:11AM +0100, Michael Heimpold wrote:
>>>
>>> From: Michael Heimpold <mhei@heimpold.de>
>>
>> "dt-bindings: arm:" is preferred subject prefix.
>
> Will change it in next round.
>
>>> This patch adds the missing devicetree binding documentation for I2SE's
>>> Duckbill and Duckbill 2 series boards.
>>>
>>> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/i2se.txt | 22
>>> ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/i2se.txt
>>> b/Documentation/devicetree/bindings/arm/i2se.txt
>>> new file mode 100644
>>> index 0000000..9954d86
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/i2se.txt
>>> @@ -0,0 +1,22 @@
>>> +I2SE Device Tree Bindings
>>> +-------------------------
>>> +
>>> +Duckbill Board
>>> +Required root node properties:
>>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>>> +
>>> +Duckbill 2 Board
>>> +Required root node properties:
>>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>>> +
>>> +Duckbill 2 485 Board
>>> +Required root node properties:
>>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>>> +
>>> +Duckbill 2 EnOcean Board
>>> +Required root node properties:
>>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>>> +
>>> +Duckbill 2 SPI Board
>>> +Required root node properties:
>>> +    - compatible = "i2se,duckbill", "fsl,imx28";
>>
>> It's kind of pointless to have "i2se,duckbill" if you use the same one
>> for all these boards.
>
> At the moment, this is only used to fix-up the MAC address' OUI part
> in mxs_machine_init. So my proposal would be to use
> compatible = "i2se,duckbill-2", "fsl,imx28";
> for the Duckbill 2 board and something like
> compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
> for the rest. This way we need to add only one additional check in
> mxs_machine_init check.
>
> Would this be a way to go?

Yes, that is fine.

Rob
