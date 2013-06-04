From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Jun 2013 08:15:00 -0700
Subject: [PATCH V4 3/4] ARM: dts: add Exynos audio subsystem clock
 controller node
In-Reply-To: <CAAgF-Bds5yy3J4fMQXhR4LEw5-6gtd2sHZOA+1dR-poASxrj4A@mail.gmail.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-4-git-send-email-padma.v@samsung.com>
 <CAD=FV=WXEDA+R3BSn7TgSB5BpS2yuWGGmFDpxcQoYmQHGTAQMw@mail.gmail.com>
 <CAAgF-Bds5yy3J4fMQXhR4LEw5-6gtd2sHZOA+1dR-poASxrj4A@mail.gmail.com>
Message-ID: <CAD=FV=Wpm0bch13c6KmZmuH0OkRr-ts_DcbTa315KZ9tnxujkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padma,

On Mon, Jun 3, 2013 at 9:25 PM, Padma Venkat <padma.kvr@gmail.com> wrote:
> Hi Doug,
>
> On Tue, Jun 4, 2013 at 1:43 AM, Doug Anderson <dianders@chromium.org> wrote:
>> Padmavathi,
>>
>> On Sun, Jun 2, 2013 at 10:19 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
>>> Audio subsystem introduced in s5pv210 and exynos platforms
>>> which has a internal clock controller. This patch adds a node
>>> for the same on exynos5250.
>>>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>>> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>>> index bccda67..388983e 100644
>>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>>> @@ -72,6 +72,12 @@
>>>                 #clock-cells = <1>;
>>>         };
>>>
>>> +       clock_audss: audss-clock-controller at 3810000 {
>
> I removed this leading 0 as Tomasz Figa suggested.

Let's just leave this as-is if Tomasz wants no leading 0.  I don't
much care either way but it's really nice if we're consistent within
the file.


>> Nit: other places in the same file have the leading 0, like
>>   i2s0: i2s at 03830000 {
>
> This was the patch which got merged earlier. So I didn't modify this.
> Is it okey if I remove  leading 0 for both of the nodes now?

No, don't touch the i2s0 one in this patch.  I guess we'll have to
merge a "cleanup" patch sometime later to try to normalize all this
stuff, since nobody seems to be keeping a close eye on keeping it
consistent.  I also see a whole bunch that have the 0x in the name
which is yet another inconsistency.


Reviewed-by: Doug Anderson <dianders@chromium.org>
