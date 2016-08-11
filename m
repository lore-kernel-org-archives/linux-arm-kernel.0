From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 11 Aug 2016 19:13:44 +0200
Subject: [PATCH 1/2] dt: bindings: Add vendor prefix for Espressif System
In-Reply-To: <CAL_JsqKLLotHErrfMs-oPvt7GgG1txQtAayjmp4zpCHEMktE_Q@mail.gmail.com>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <20160810184845.GA17829@rob-hp-laptop>
 <2b43330e-369d-7473-8b73-429f0f0b73ce@redhat.com>
 <CAL_Jsq+uy-P54enk5Zho=nRab4PMEbqyBTEWiE0yhWWVoFTmwQ@mail.gmail.com>
 <3516eadd-e987-1747-5813-de51b77fd73e@redhat.com>
 <CAL_JsqKLLotHErrfMs-oPvt7GgG1txQtAayjmp4zpCHEMktE_Q@mail.gmail.com>
Message-ID: <52ebfa9e-79cc-2fca-505d-6c42aec35041@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-08-16 18:35, Rob Herring wrote:
> On Thu, Aug 11, 2016 at 10:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11-08-16 15:31, Rob Herring wrote:
>>>
>>> On Thu, Aug 11, 2016 at 4:15 AM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>>
>>>> On 10-08-16 20:48, Rob Herring wrote:
>>>>>
>>>>>
>>>>> On Sun, Aug 07, 2016 at 08:57:48PM +0200, Hans de Goede wrote:
>>>>>>
>>>>>>
>>>>>> Espressif is a manufacturer of various wifi and bt chips, add a vendor
>>>>>> prefix for use with bindings for these chips.
>>>>>>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>>
>>>>>
>>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>
>>>>
>>>>
>>>> Thank you for all the reviews.
>>>>
>>>> What about: "[PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi
>>>> chips" ?
>>>> there were some remarks, but I believe that those have been addressed
>>>> (by answering the remarks, not with a new version), so a review of that
>>>> one would be appreciated too.
>>>
>>>
>>> What about Arnd's comment "better use '-' instead of '_' for property
>>> names."
>>
>>
>> Ah yes, I forgot about that comment. As explained in the commit msg
>> I named the dt property to be the same as the keyword used in the
>> ini-like config file android uses for this (the android driver loads a
>> file with board specific esp8089 config like the crystal-type from
>> /lib/firmware).
>>
>> And that file does use '_'. I want to keep the names the same as that
>> seems the sensible thing to do, but if there is a great preference for
>> '-' in dt I can do a v2 with that changed.
>
> I could see wanting to use the same string in the driver for a small
> size savings, but I'd assume a mainline driver would do away with the
> firmware text file and only use DT?

Yes.

> Also, do you expect lots more
> properties?

No, it seems that most settings from the text-file android use always
are at a fixed value.

> Maintaining the exact string would be more worthwhile if
> there are lots of properties.
>
> I plan to make '_' cause warnings with dtc which is why we don't want
> to add more.

Ah, ok that is a good reason to change to '-' I'll do a v2 with that
change.

Regards,

Hans
