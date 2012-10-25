From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 25 Oct 2012 11:29:38 +0200
Subject: [PATCH 2/6] pinctrl: Update clock handling for the
 pinctrl-nomadik GPIO driver
In-Reply-To: <20121025082341.GC3348@gmail.com>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaeBW2ecQZ2fA-hL8o47pYpjZ=5Mn131F87u58rX+dekw@mail.gmail.com>
 <20121025073127.GB971@gmail.com> <5088F0EE.8030900@stericsson.com>
 <20121025082341.GC3348@gmail.com>
Message-ID: <CAPDyKFromkv_VYgiQsERR=PbrwYqgux=teF_HSZxCtk2BCsk1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 October 2012 10:23, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Oct 2012, Linus Walleij wrote:
>
>> On 10/25/2012 09:31 AM, Lee Jones wrote:
>> >
>> >This certainly doesn't fix the bug we spoke about. I believe Ulf
>> >is still working on that one.
>> >
>> >So do you want me to remove this patch?
>> >
>>
>> Yeah drop it for now.
>
> Actually, a quick question before I do:
>
> If it's better/faster to prepare the clock and keep it prepared
> while you do clk_enable/clk_disable, why don't we do that in all
> drivers? Why do we bother to prepare/unprepare each time if all
> it does is take up cycles?
>

Depending on clock type, a clk_disable is actually not going to "gate"
the clock, that might happen only in unprepare. This depends on if the
clock is a fast or slow clock.
To save as much power as possible, in general, we should do both
disable and unprepare. Although it will be device driver dependent
were it is most convenient to do this things.
Sometimes it is possible to group them sometimes not.

Kind regards
Ulf Hansson
