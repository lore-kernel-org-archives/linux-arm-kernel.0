From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 19 Dec 2013 21:05:09 +0530
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <3552349.yKrGzNhczA@amdc1227>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <2996623.YXg5JqReYS@flatron>
 <CAK9yfHzs+T0g0qy-EALFkrKFybdJDAQ3ZGAoYovZO8PDaWM4QA@mail.gmail.com>
 <3552349.yKrGzNhczA@amdc1227>
Message-ID: <CAK9yfHxuNxqJR7MV0vb+ThD3pQi6OPUfGv=Tg2KGZfzJwKm3eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 19 December 2013 19:40, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Sachin, Andrew,
>
> On Wednesday 18 of December 2013 23:39:58 Sachin Kamat wrote:
>> Hi Tomasz,
>>
>> On 10 November 2013 22:38, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> > Hi Sachin, Andrew,
>> >
>> > On Friday 08 of November 2013 15:44:07 Sachin Kamat wrote:
>> >> From: Andrew Bresticker <abrestic@chromium.org>
>> >>
>> >> The gate clocks for the MFC sysmmus appear to be flipped, i.e.
>> >> GATE_IP_MFC[2] gates sysmmu_mfcl and GATE_IP_MFC[1] gates sysmmu_mfcr.
>> >> Fix this so that the MFC will start up.
>> >
>> > Wow, this means that there is a mistake in the documentation. Not that
>> > I'm surprised, though.
>> >
>> > I guess you are sure about this, so:
>> >
>> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>
>> I believe you are going to take this through your tree along with a
>> few others which you have already reviewed?
>
> This patch seems to depend on my Exynos 5250 clock clean-up series, which
> will be merged for 3.14. Are you okay with this patch being merged for
> 3.14 as well or this fix is needed for earlier kernel versions too?
> (It is not a regression introduced in 3.13, though.)

Yes, I did rebase it on top of your series along with other patches.
Though not a regression introduced in 3.13, I think it makes sense to have this
sent as a fix during this release (3.13) itself. Let me know if you
want me to base it
on top of 3.13-rc4 and re-send.


-- 
With warm regards,
Sachin
