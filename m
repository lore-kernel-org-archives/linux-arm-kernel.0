From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 12 Sep 2016 23:43:55 +0200
Subject: [PATCH 2/3] ARM64: dts: amlogic: Add basic support for Amlogic
 S905X
In-Reply-To: <7ha8fcq26c.fsf@baylibre.com>
References: <20160903082227.30559-1-narmstrong@baylibre.com>
 <20160903082227.30559-3-narmstrong@baylibre.com>
 <7e27e8c0-bb18-40d8-10d6-3928e66815c7@suse.de>
 <CAOQ7t2bWLq2XP2rKx3msf=1tUfXkQuBWagun46TaKk73qXr=FQ@mail.gmail.com>
 <7ha8fcq26c.fsf@baylibre.com>
Message-ID: <28d9160a-ce40-cbbb-b4e9-3ec34be52368@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.09.2016 um 22:43 schrieb Kevin Hilman:
> Carlo Caione <carlo@caione.org> writes:
>> On Mon, Sep 12, 2016 at 6:28 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>
>>>> +Boards with the Amlogic Meson GXL SoC shall have the following properties:
>>>> +  Required root node property:
>>>> +    compatible: "amlogic,meson-gxl-s905x", "amlogic,meson-gxl";
>>>
>>> Can we please use "amlogic,s905x", "amlogic,meson-gxl"? No need to
>>> complicate the name. Also affects .dtsi and .dts below.
>>
>> gxl != s905x.

Huh? You're seemingly completely missing my point...

But you are right that _Neil's_ heading needs to be fixed, too:
Clearly not all GXL SoCs need to have an S905X compatible string!
So it should be "Boards with the Amlogic S905X SoC shall ..." or so.

>> AFAWK to the GXL family belong several different SoCs, like S905X,
>> S905D, etc... (see patch 3/3)

Thanks, I already know that, that's why you have two compatible strings
instead of just one like for GXBB. We can certainly prepend one for
symmetry there, too, if it makes you happier.

>> This is why we use meson-gxl-s905x, meson-gxl-s905d, etc...
> 
> Correct.
> 
>> We could s/meson-gxl-s905x/meson-s905x/ and
>> s/meson-gxl-s905d/meson-s905d/ but I honestly prefer this way because
>> we can clearly see which family the SoC belongs to (the Amlogic naming
>> convention is already messy enough).
>> I mean, yes it's longer, but it's for the sake of documentation IMO.
> 
> +1

I still don't follow that conclusion. The board is called "amlogic,p231"
because P231 is a unique identifier within the Amlogic namespace, so why
not call the SoC "amlogic,s905x" for the same reason? The documentation
is already there in having both "amlogic,s905x" _and_
"amlogic,meson-gxl" - please re-read my post. There is no S905X in GXL
family and another S905X in some other Amlogic SoC family, so it's
unique and there is no reason to encode any hierarchies into its name
other than vendor,name.

I'm not arguing over the file name, where it perfectly makes sense to
have a meson-gxl- prefix (already discussed), just about the compatible
string where we don't have "amlogic,meson-gxl-s905x-p231" either because
it is completely unnecessary and does _not_ add any value.

Not that we're checking this string anywhere anyway... If you want to
check for the GXL family you have to use "amlogic,meson-gxl"; if you
want to check for the specific SoC you use "amlogic,s905x". Simple. We
never match partial strings, so there is no sense in a hardcoded prefix
that is duplicating information already available.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
