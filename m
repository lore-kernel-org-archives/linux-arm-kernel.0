From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Jul 2014 00:17:20 +0800
Subject: [PATCH 2/2] pinctrl: sunxi: number gpio ranges starting from 0
In-Reply-To: <20140724160141.GZ20328@lukather>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-3-git-send-email-wens@csie.org>
 <CAGb2v64mZjmB+ftQ7yM5LzhUyPVGtCXq6DOUQ-pumLb73_DYLQ@mail.gmail.com>
 <20140724160141.GZ20328@lukather>
Message-ID: <CAGb2v66jhspz7ornqQ0UXy6cRXptbOvUhQPX6jYttyCqmkZaxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 12:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jul 24, 2014 at 09:19:18PM +0800, Chen-Yu Tsai wrote:
>> > This patch also changes the GPIO bindings for R_PIO:
>> >
>> >     gpios = <&r_pio B N flag>;
>> >
>> > Where B originally was the pinbank label (L or M) counted from A,
>> > with this patch it becomes (L or M) counted from its pinbank base (L).
>> >
>> > Thus
>> >
>> >     gpios = <&r_pio 10 11 0>; /* PL11 */
>> >
>> > becomes
>> >
>> >     gpios = <&r_pio 0 11 0>; /* PL11 */
>> >
>> > IMO this is correct, as the binding shows the bank offset and pin offset
>> > within the bank for the GPIO controller. But I'm worried it might be a
>> > bit confusing.
>>
>> I see you Acked this patch, but also in your reply to my cover letter,
>> you mentioned that you want absolute pin numbers matching the datasheets.
>> What about the GPIO DT bindings, as I explained above?
>>
>> Just double checking. Thanks.
>
> I'd like it to have the absolute numbers in sysfs, but the relative
> one in the DT. But I guess it's already what's happening, right?

That's right. Just checking. :)


ChenYu
