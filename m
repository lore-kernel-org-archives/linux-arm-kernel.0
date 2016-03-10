From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Fri, 11 Mar 2016 00:08:49 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <56DEA67E.8090704@suse.de>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
 <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com> <56DEA67E.8090704@suse.de>
Message-ID: <7E647096-6B3B-4015-BB0F-7B4087206180@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Le 8 mars 2016 ? 11:16, Andreas F?rber <afaerber@suse.de> a ?crit :
> 
> Am 08.03.2016 um 10:41 schrieb Julien Chauveau:
>> Le 8 mars 2016 ? 09:54, Geert Uytterhoeven <geert@linux-m68k.org> a ?crit :
>>> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>>> Drop #address-cells and #size-cells, which are not required by the
>>>> gpio-keys binding documentation, as button sub-nodes are not devices.
>>>> 
>>>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>>> 1 file changed, 2 deletions(-)
>>>> 
>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> index 21641236c095..1552a11f6786 100644
>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>> @@ -34,8 +34,6 @@ Example nodes:
>>>> 
>>>>       gpio_keys {
>>>>                       compatible = "gpio-keys";
>>>> -                       #address-cells = <1>;
>>>> -                       #size-cells = <0>;
>>>>                       autorepeat;
>>>>                       button at 21 {
>>> 
>>> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1cdd":
>>> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
>>> 
>>> Warning (unit_address_vs_reg): Node /keyboard/button at 21 has a unit
>>> name, but no reg property
>>> 
>> 
>> Hi Andreas,
>> This means you can also drop the unit-address (the @21 part) for the button.
>> What about using a more relevant name like "key_up" instead of "button"?
> 
> Or in my case power-key or power-button. Or would just power suffice?

For the example nodes of the documentation, according to the labels you?ll probably want to use "up" and "down" (or "key-up" and "key-down", or "up-key" and "down-key").

For the Geekbox, I think "power" is meaningful enough.

> 
> The Landingship baseboard does have four more buttons not yet enabled,
> so I do need some way to distinguish nodes.

The labels on the board are key1, key2, key3 and key4. Maybe you can use that?
