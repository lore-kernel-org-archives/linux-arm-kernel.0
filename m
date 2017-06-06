From: code@mmayer.net (Markus Mayer)
Date: Tue, 6 Jun 2017 10:07:08 -0700
Subject: [PATCH 1/2] Documentation: devicetree: add binding for Broadcom
 STB AVS TMON
In-Reply-To: <e5da2edfae3bd593fd7819db1d7e2337@milecki.pl>
References: <20170605210930.65432-1-code@mmayer.net>
 <20170605210930.65432-2-code@mmayer.net>
 <e5da2edfae3bd593fd7819db1d7e2337@milecki.pl>
Message-ID: <CANEuBv6y+FD86oH7hHctjrt=5Oh_4_iitgNHLppMOPt=D5yXig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2017 at 05:21, Rafa? Mi?ecki <rafal@milecki.pl> wrote:
> On 2017-06-05 23:09, Markus Mayer wrote:
>>
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>> @@ -0,0 +1,20 @@
>> +* Broadcom STB thermal management
>> +
>> +Thermal management core, provided by the AVS TMON hardware block.
>> +
>> +Required properties:
>> +- compatible: must be one of "brcm,avs-tmon" or "brcm,avs-tmon-bcm7445"
>
>
> Is the "one of" correct here? I'm not native English but it sounds like
> setting both is a wrong thing.

You are right. It should not say "one of". I'll fix the wording.

>> +- reg: address range for the AVS TMON registers
>> +- interrupts: temperature monitor interrupt, for high/low threshold
>> triggers
>> +- interrupt-names: should be "tmon"
>> +- interrupt-parent: the parent interrupt controller
>> +
>> +Example:
>> +
>> +       thermal at f04d1500 {
>> +               compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";
>
>
> Yet here you use both bindings.
