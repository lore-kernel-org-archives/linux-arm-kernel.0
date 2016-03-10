From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Fri, 11 Mar 2016 00:08:56 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <56DEA4D6.10008@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
 <56DEA4D6.10008@suse.de>
Message-ID: <A62AD22E-ECB3-4DC7-8156-22BC84795412@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Le 8 mars 2016 ? 11:09, Andreas F?rber <afaerber@suse.de> a ?crit :
> 
> Am 08.03.2016 um 09:54 schrieb Geert Uytterhoeven:
>> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> Drop #address-cells and #size-cells, which are not required by the
>>> gpio-keys binding documentation, as button sub-nodes are not devices.
>>> 
>>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>> 1 file changed, 2 deletions(-)
>>> 
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> index 21641236c095..1552a11f6786 100644
>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>> @@ -34,8 +34,6 @@ Example nodes:
>>> 
>>>        gpio_keys {
> 
> While at it, I was told the preferred node naming would be dashes, not
> underscores. The deeper we dig, the more we find.

I agree, here we should use dashes, not underscores. So "gpio-keys" instead of "gpio_keys".

> 
>>>                        compatible = "gpio-keys";
>>> -                       #address-cells = <1>;
>>> -                       #size-cells = <0>;
>>>                        autorepeat;
> 
> Also a white line here may be optically more pleasant.

I agree.

> 
>>>                        button at 21 {
>> 
>> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1cdd":
>> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>> 
>> Warning (unit_address_vs_reg): Node /keyboard/button at 21 has a unit
>> name, but no reg property
> 
> My v2 GeekBox patch did have *-cells and a reg property, but Julien
> asked I drop that: https://patchwork.kernel.org/patch/8246481/
> 
> Are you suggesting we should add a reg property here and drop this patch
> or go with this patch but follow up to not use @21?

I may be wrong but I think that if the unit-address has no meaning and is not used, then it should be removed.

By the way, I think the warning message is wrong. It should be _address_ instead of name: "Node has a unit address, but no reg property".

Julien
