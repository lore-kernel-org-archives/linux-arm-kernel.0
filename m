From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 12 Sep 2015 11:04:18 -0700
Subject: [PATCH 2/4] devicetree: bindings: Add header file with evdev type
 and abs/rel code defines
In-Reply-To: <55F208BA.5030507@kernel.org>
References: <1441789886-5868-1-git-send-email-hdegoede@redhat.com>
 <1441789886-5868-2-git-send-email-hdegoede@redhat.com>
 <55F1BCFA.5010404@kernel.org>
 <CAKdAkRRFcn5+SXNfU4J+v4tcFyA1mZR1hMhT2y3QJeQJ1tTDYQ@mail.gmail.com>
 <55F1CE8B.5050302@redhat.com>
 <CAKdAkRSpsze_EjaQ3Rre_wjN7dWJ3XNvkt9S=CMktEsNXGYg_w@mail.gmail.com>
 <55F1D0E2.6010805@redhat.com> <55F208BA.5030507@kernel.org>
Message-ID: <CAKdAkRQRz++chXbifx1eA44M=ih8Ja7iMoWxAEtXRLo-Kmj+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 3:48 PM, Rob Herring <robh@kernel.org> wrote:
> +Ian
>
> On 09/10/2015 01:50 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 10-09-15 20:42, Dmitry Torokhov wrote:
>>> On Thu, Sep 10, 2015 at 11:40 AM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>> Hi,
>>>>
>>>>
>>>> On 10-09-15 20:34, Dmitry Torokhov wrote:
>>>>>
>>>>> On Thu, Sep 10, 2015 at 10:25 AM, Rob Herring <robh@kernel.org> wrote:
>>>>>>
>>>>>> On 09/09/2015 04:11 AM, Hans de Goede wrote:
>>>>>>>
>>>>>>> This header provides evdev constants for linux,code, and
>>>>>>> linux,input-*
>>>>>>> properties.
>>>>>>>
>>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>>> ---
>>>>>>>    include/dt-bindings/input/evdev.h | 76
>>>>>>> +++++++++++++++++++++++++++++++++++++++
>>>>>>
>>>>>>
>>>>>> This looks fine, but please just add to input/input.h.
>
> [...]
>
>>>>> Actually I'd rather we removed include/dt-bindings/input/input.h and
>>>>> instead used the header file from uapi. As it is now we already
>>>>> duplicating definitions and the copy in dt-bindings is missing several
>>>>> key codes. Until we split DT bindings form the kernel code I'd rather
>>>>> have definitions in one place.
>
> We do already have split binding tree. It is generated from the kernel
> tree ATM.

But the data in the kernel is the "source of truth" for now since the
other tree is simply generated.

> Adding Ian for any comments.
>
>>>> AFAIK we cannot do that as the uapi header also contains things like:
>>>>
>>>> struct input_event {
>>>>          struct timeval time;
>>>>          __u16 type;
>>>>          __u16 code;
>>>>          __s32 value;
>>>> };
>>>>
>>>> Which is not valid device tree syntax.
>>>>
>>>> If you want this we need to split the uapi headers in one with only
>>>> defines and one with all the rest.
>>>
>>> That would be fine by me. event-codes.h?
>>
>> Since this will live in the generic include/linux namespace (for userspace)
>> maybe input-event-codes ?
>>
>> Rob are you ok with including uapi headers from dts files if those uapi
>> headers are guaranteed to have only #define-s in them?
>
> No. If you can do it as a symlink or some limited way, I'd be fine with
> that. I don't want to see wholesale addition of uapi headers though.

Umm, not sure if I like symlink, it makes hard to see what includes
what. The individual DTSes will continue including
dt-bindings/input/input.h and only input.h will include uapi header
(so use of uapi is internal detail). Would that still be a problem?

Thanks.

-- 
Dmitry
