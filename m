From: robh@kernel.org (Rob Herring)
Date: Thu, 19 May 2016 07:50:20 -0500
Subject: [PATCH] ARM: at91: Add DT support for Olimex SAM9-L9260 board.
In-Reply-To: <573DB180.9030200@atmel.com>
References: <1463574766-15568-1-git-send-email-raashidmuhammed@zilogic.com>
 <20160518232925.GA6545@rob-hp-laptop> <573DB180.9030200@atmel.com>
Message-ID: <CAL_JsqLXaq7KKPKnSTcRBswnvdZiUS=1wb35oo+JrjY3_tPRJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 7:28 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 19/05/2016 01:29, Rob Herring a ?crit :
>> On Wed, May 18, 2016 at 06:02:46PM +0530, Raashid Muhammed wrote:
>>> From: Raashid Muhammed <raashidmuhammed@zilogic.com>
>>>
>>> sam9-l9260 is a low cost board designed by Olimex.
>>>
>>> More infomation is available at:
>>> https://www.olimex.com/Products/ARM/Atmel/SAM9-L9260/
>>>
>>> Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
>>> Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
>>> ---
>>>  .../devicetree/bindings/arm/olimex-at91.txt        |   6 ++
>>>  arch/arm/boot/dts/Makefile                         |   1 +
>>>  arch/arm/boot/dts/sam9-l9260.dts                   | 108 +++++++++++++++++++++
>
> For AT91-based boards, please use this prefix: "at91-" as stated in the
> Atmel README file:
> http://lxr.free-electrons.com/source/Documentation/arm/Atmel/README#L127
>
> So I would recommend this name instead:
> at91-sam9-l9260.dts
>
>
>>>  3 files changed, 115 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/olimex-at91.txt
>>>  create mode 100644 arch/arm/boot/dts/sam9-l9260.dts
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/olimex-at91.txt b/Documentation/devicetree/bindings/arm/olimex-at91.txt
>>> new file mode 100644
>>> index 0000000..0587d63
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/olimex-at91.txt
>>> @@ -0,0 +1,6 @@
>>> +Olimex AT91 Device Tree Bindings
>>> +--------------------------------
>>
>> There's not an existing at91 or olimex file this would fit into? We
>> don't need 1 file per board.
>>
>>> +
>>> +SAM9-L9260 Board
>>> +Required root node properties:
>>> +    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
>
> I don't think this file is needed at all actually. We have a lot of
> board files and none of them have a dedicated or particular entry for them.

Well, they should have one.

Rob
