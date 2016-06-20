From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Jun 2016 12:38:37 -0700
Subject: [PATCH v3 01/15] phy: rockchip-emmc: give DLL some extra time to
 be ready
In-Reply-To: <CABXOdTccLMbspfprfLP9CTkD9YbfJsPKOXV7RsVKfU94zPLhNg@mail.gmail.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-2-git-send-email-dianders@chromium.org>
 <CABXOdTeQhOSUeX+-as_6S5H1mnVnyBsEDU9ZsiC97Yb+qWiFew@mail.gmail.com>
 <CAD=FV=UMFEDzKT0VkVYxmzxKkFVKREhhXhm+McmdQDriHKhPKg@mail.gmail.com>
 <CABXOdTccLMbspfprfLP9CTkD9YbfJsPKOXV7RsVKfU94zPLhNg@mail.gmail.com>
Message-ID: <CAD=FV=XLExFZEoDbj+CMvkWkf_Tp2MLCo20X8RWQQPFzPxAXWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2016 at 12:36 PM, Guenter Roeck <groeck@google.com> wrote:
> On Mon, Jun 20, 2016 at 12:30 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Mon, Jun 20, 2016 at 12:23 PM, Guenter Roeck <groeck@google.com> wrote:
>>> On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
>>> <dianders@chromium.org> wrote:
>>>> From: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>> According to the databook, 10.2us is the max time for dll to be ready to
>>>> work. However in testing, some chips need 20us for dll to be ready. This
>>>
>>> Nitpick, but description (20uS) and code (more than 25 uS) don't match.
>>
>> Good catch.  If I spin the series I'll fix this, otherwise I'll assume
>> that the person applying this (Ulf?) can fix the description at their
>> discretion.
>>
>
> Not that it matters much, as the code is replaced in a later patch
> anyway. It might make more sense to merge the two patches into one.

Yes.  At the time I wrote it it was unclear what the status of the
original patch was (whether it would be applied sooner vs. later).  At
this point it seemed expedient to continue to keep the patches
separate since they had been reviewed and tested separately.  Earlier
I made the offer to combine and re-spin and I'm happy to do that if
requested.

-Doug
