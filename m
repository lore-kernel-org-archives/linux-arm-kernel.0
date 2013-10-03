From: olof@lixom.net (Olof Johansson)
Date: Thu, 3 Oct 2013 11:01:30 -0700
Subject: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
In-Reply-To: <CAAQKjZPwyKCpju4Ndd+MB_aN24-zA5xTHFsFsun2617h7YT6dw@mail.gmail.com>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
 <CAAQKjZN_r-=-sj=Vb-o-KUS4ab5=cjCq1ni3VZeMeVc3NL=MMg@mail.gmail.com>
 <CAOw6vbLiJLLKn=gb1=j5TBeM0ijEK13+goG-=mw7MZTyNT1kpQ@mail.gmail.com>
 <CAAQKjZPwyKCpju4Ndd+MB_aN24-zA5xTHFsFsun2617h7YT6dw@mail.gmail.com>
Message-ID: <CAOesGMgKastzdFHYQzyL8gxkBN=86wFZ4jbgP8BHxfkOuZvJxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 10:39 AM, Inki Dae <inki.dae@samsung.com> wrote:
> 2013/10/3 Sean Paul <seanpaul@chromium.org>:
>> On Thu, Oct 3, 2013 at 9:55 AM, Inki Dae <inki.dae@samsung.com> wrote:
>>> Can a regulator be used instead of gpio in other board case?
>>>
>>
>> No, not to my knowledge.
>>
>
> Hm.. plz check it out again. the gpio pin is specific to board, and
> the the gpio be used as power source trigger could be replaced with a
> regulator according to board design. So you should consider all
> possibilities even though there are no other cases yet: other board
> could  use a regulator instead.

Take a look at the data sheet, it is publicly available.

PD_N is not a power supply input, so modelling it as a regulator makes no sense:

"If PD_N is LOW, then the device is in Deep power-down completely,
even if supply rail is ON; for the device to be able to operate, the
PD_N pin must be HIGH."



-Olof
