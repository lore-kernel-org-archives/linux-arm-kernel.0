From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 8 Mar 2016 11:09:26 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CAMuHMdVMVYaygvKd3qgTz2fF9SuLA_zEYRoZZrJO+2zmP=jxag@mail.gmail.com>
Message-ID: <56DEA4D6.10008@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.03.2016 um 09:54 schrieb Geert Uytterhoeven:
> On Mon, Mar 7, 2016 at 7:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices.
>>
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> index 21641236c095..1552a11f6786 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>> @@ -34,8 +34,6 @@ Example nodes:
>>
>>         gpio_keys {

While at it, I was told the preferred node naming would be dashes, not
underscores. The deeper we dig, the more we find.

>>                         compatible = "gpio-keys";
>> -                       #address-cells = <1>;
>> -                       #size-cells = <0>;
>>                         autorepeat;

Also a white line here may be optically more pleasant.

>>                         button at 21 {
> 
> FYI, with "[PATCH] scripts/dtc: Update to upstream version 53bf130b1cdd":
> (http://www.spinics.net/lists/devicetree/msg117206.html) applied:
> 
> Warning (unit_address_vs_reg): Node /keyboard/button at 21 has a unit
> name, but no reg property

My v2 GeekBox patch did have *-cells and a reg property, but Julien
asked I drop that: https://patchwork.kernel.org/patch/8246481/

Are you suggesting we should add a reg property here and drop this patch
or go with this patch but follow up to not use @21?

> 
>>                                 label = "GPIO Key UP";

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
