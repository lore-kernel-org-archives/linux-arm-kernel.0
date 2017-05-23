From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 14:00:17 +0200
Subject: [PATCH 0/8] arm64: hi6220-hikey: Fix WiFi support
In-Reply-To: <CAPDyKFqi2jiqKESdz8izq6thr6GT0HQDKt6xRKzwaCQ-mkMNSw@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFqi2jiqKESdz8izq6thr6GT0HQDKt6xRKzwaCQ-mkMNSw@mail.gmail.com>
Message-ID: <CAK8P3a2sO9+LVRu+Mjj_K+-1MtQhfSs33J+0EMEq+Um35=2Aow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 10:40 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + Arnd, Rob
>
> On 8 May 2017 at 18:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The Hikey board has a Wifi chip attached to the SDIO bus, which is managed by a
>> dwmmc controller. This is currently broken in that way that not even the SDIO
>> card is being detected.
>>
>> To fix this we need to make sure the correct resources are described for the
>> dwmmc controller, so the mmc core can power on/off the SDIO/WiFi chip
>> correctly. This is the main issue today.
>>
>> I have picked up one change from Daniel Lezcano's earlier submission [1] and
>> folded that into this series, as the Wifi support depends on it. As a matter of
>> fact I have even split Daniel's change into two halves, one for DT
>> documentation and one for arm64 hikey dts.
>>
>> It's important that this series goes together as to conform with TI's HW spec
>> of the wl18xx Wifi chip, as to prevent it from being damaged. We can either go
>> via arm-soc, unless Wei Xu the Hikey SoC maintainer, prefers to ack the dts
>> changes, then I can pick the series via my mmc tree.
>>
>> Moreover, I would suggest we send this as fixes for the 4.12 rcs to get the
>> Wifi working for Hikey again.
>
> This series fixes my wifi issues on the Hikey board and currently all
> but the hikey dts changes seems to be okay/acked.
>
> Rob and me had some discussions regarding the new mmc DT binding,
> however in the last response from Rob he indicates that he is not
> objecting to adding the new binding.
>
> So, unless I hear some objection from any of you, I am going to queue
> this up for fixes via my mmc tree within a day or so.

Hi Ulf,

I looked at all the changes, and they seem reasonable to me. Please
add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

and put them into a separate branch that you merge into your mmc
git, so we can merge the changes with the other updates in case
there are conflicts.

I see that the only code change is in patch 2. Are you able to put
that patch last in the series without introducing bisection problems?
That would be preferred, as it allows us to keep a pure 'DT' branch
if we end up merging your other seven patches in.

       Arnd
