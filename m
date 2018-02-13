From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Feb 2018 20:53:05 +0100
Subject: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <CAFd5g44iHgSoPfko6hgMjz=QMm6ZUScUWbnho1w0bL_brTCjrA@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com>
 <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
 <CAKKbWA6Otc1ZO_yHpfhxPjbgvvn-QXcXG9sy5=3FZDY8d_20rw@mail.gmail.com>
 <CAFd5g44iHgSoPfko6hgMjz=QMm6ZUScUWbnho1w0bL_brTCjrA@mail.gmail.com>
Message-ID: <CAK8P3a0CESqe9gEPhBXO0-J9SB=wyM6p3Fg-abr3BDtExYgfYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 8:12 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> On Tue, Feb 13, 2018 at 1:29 AM, Avi Fishman <avifishman70@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 10:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Tue, Feb 6, 2018 at 12:57 AM, Brendan Higgins
>>> <brendanhiggins@google.com> wrote:
>>>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>>>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>>>
>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>>>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>>>> Tested-by: Avi Fishman <avifishman70@gmail.com>
>>> ...
>>>> +               enable-method = "nuvoton,npcm7xx-smp";
>>>
>>> I see this has already been reviewed quite a bit, but I'm curious
>>> about the 'npcm7xx'
>>> part here. Shouldn't that be a real chip name rather than a wildcard?
>>
>> There is a family of npcm7xx, some with SMP and some without.
>> For those who has it, it is common for all to use the same
>> "nuvoton,npcm7xx-smp".
>
> I think Arnd is right. In this case it should be "nuvoton,npcm750-smp". We can
> use CPU_METHOD_OF_DECLARE to alias to as many compatible properties as needed.
>
> Although everything in the 7xx family currently is either single core or has the
> same SMP behavior, you could paint yourself into a corner if you were to make
> one SMP device in the 7xx family which behaves differently from all other
> devices and then need to come up with new compatible string names just for that.

Right, this is the reason for the very simple 'no wildcards in DT
identifiers' rule.
There simply isn't a reason to make an exception here.

       Arnd
