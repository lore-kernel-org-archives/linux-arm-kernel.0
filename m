From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 11:23:56 +0200
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <5191F9EE.6070008@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q@mail.gmail.com>
 <5191F9EE.6070008@st.com>
Message-ID: <CACRpkdYh72hQHSK-a9r8R9qfnQv06412YqVNeYpc_rZhMeiXww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 10:46 AM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:
> On 13/05/13 20:05, Linus Walleij wrote:

>> Why are you enabling the timer in unused and shutdown mode?
>>
>> This doesn't make sense.
>
> It is because we are using the global-timer block for both clocksource
> and clockevents and we do not want the clocksource to disappear when
> clockevent is unused/shutdown.

As this is clearly a per-cpu timer (correct? atleast the driver is
written that way) and say you have 4 CPUs, why would you not shut down
the timer on cores 1,2,3 and only leave the timer on core 0 on?

The kernel will by necessity not shut down the clock event on core
0 anyway.

On a related note: don't you want to use the counter in this block as
sched_clock() as well? (I guess so, as you do not seem to have
anything else on this system.) It'd probably need to be a separate
Kconfig option and can surely be done later but keep it in mind.

Yours,
Linus Walleij
