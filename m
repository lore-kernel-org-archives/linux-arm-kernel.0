From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 26 Aug 2013 19:17:15 +0200
Subject: [RFC PATCH 2/3] pinctrl: at91: add support for generic pinconf
In-Reply-To: <521B8822.50304@wwwdotorg.org>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380259-11290-1-git-send-email-b.brezillon@overkiz.com>
 <521B8822.50304@wwwdotorg.org>
Message-ID: <521B8D9B.5020809@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/2013 18:53, Stephen Warren wrote:
> On 08/24/2013 03:37 PM, Boris BREZILLON wrote:
>> Add support for generic pin configuration to pinctrl-at91 driver.
>> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
>>   Required properties for iomux controller:
>> -- compatible: "atmel,at91rm9200-pinctrl"
>> +- compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl".
> You seem to also be adding a second chip name to the list here, which is
> more than the patch subject/description imply you're doing...

This is an update of the documentation:
"atmel,at91sam9x5-pinctrl" compatible is already used in the pinctrl 
driver but the documention
was not updated.

But I agree, this should not be part of this series.

>> +  Add "generic-pinconf" to the compatible string list to use the generic pin
>> +  configuration syntax.
> "generic-pinconf" is too generic of a compatible value for this binding
> to define.
>
> Instead, I think you want to either:
>
> a)
>
> Use compatible="atmel,at91rm9200-pinctrl" for the old binding,
> use compatible="atmel,at91rm9200-pinctrl-generic" for the new binding
>
> or:
>
> b)
>
> Define Boolean property atmel,generic-pinconf (perhaps a better name
> could be chosen?). If it's not present, parse the node assuming the old
> binding. If it is present, parse the node assuming the new binding.
>
Okay.

I thought this property string could be generic as it may concern other 
drivers too
(in order to keep compatibility with old dt ABI and add support the 
generic pinconf binding).

Anyway, I prefer the first proposition.

pinctrl single driver is already using these names:

|compatible = "pinctrl-single" for non generic pinconf binding
||compatible = "pinconf-single" ||for generic pinconf binding|

So I think we should use something similar:

|compatible = "atmel,at91xx-pinctrl" for non generic pinconf binding
||compatible = "|||atmel,at91xx-|pinconf" ||for generic pinconf binding|

What do you think ?

Best Regards,

Boris
