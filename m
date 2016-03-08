From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Tue, 8 Mar 2016 10:41:37 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Message-ID: <525564DD-D0D3-4DEB-9306-3A23288FD83F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Le 8 mars 2016 ? 09:54, Geert Uytterhoeven <geert@linux-m68k.org> a ?crit :
> 
> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices.
>> 
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>> Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>> 1 file changed, 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index 21641236c095..1552a11f6786 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -34,8 +34,6 @@ Example nodes:
>> 
>>        gpio_keys {
>>                        compatible = "gpio-keys";
>> -                       #address-cells = <1>;
>> -                       #size-cells = <0>;
>>                        autorepeat;
>>                        button at 21 {
> 
> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1cdd":
> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
> 
> Warning (unit_address_vs_reg): Node /keyboard/button at 21 has a unit
> name, but no reg property
> 

Hi Andreas,
This means you can also drop the unit-address (the @21 part) for the button.
What about using a more relevant name like "key_up" instead of "button"?

Julien
