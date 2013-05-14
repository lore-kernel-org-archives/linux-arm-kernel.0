From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 14 May 2013 11:26:26 +0100
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <CACRpkdYh72hQHSK-a9r8R9qfnQv06412YqVNeYpc_rZhMeiXww@mail.gmail.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022260-2197-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZCP=w=4Q3bnuMQxm=Oe-uZke+Cc5NgddM5vsQbgr9E-Q@mail.gmail.com>
 <5191F9EE.6070008@st.com>
 <CACRpkdYh72hQHSK-a9r8R9qfnQv06412YqVNeYpc_rZhMeiXww@mail.gmail.com>
Message-ID: <51921152.1000600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/13 10:23, Linus Walleij wrote:
> On Tue, May 14, 2013 at 10:46 AM, Srinivas KANDAGATLA
> <srinivas.kandagatla@st.com> wrote:
>> On 13/05/13 20:05, Linus Walleij wrote:
> 
>>> Why are you enabling the timer in unused and shutdown mode?
>>>
>>> This doesn't make sense.
>>
>> It is because we are using the global-timer block for both clocksource
>> and clockevents and we do not want the clocksource to disappear when
>> clockevent is unused/shutdown.
> 
> As this is clearly a per-cpu timer (correct? atleast the driver is
> written that way) and say you have 4 CPUs, why would you not shut down
> the timer on cores 1,2,3 and only leave the timer on core 0 on?
> 
I think it makes sense to shutdown the timer on other cores on request.
I will fix this.

> The kernel will by necessity not shut down the clock event on core
> 0 anyway.
> 
> On a related note: don't you want to use the counter in this block as
> sched_clock() as well? (I guess so, as you do not seem to have
> anything else on this system.) It'd probably need to be a separate
> Kconfig option and can surely be done later but keep it in mind.
Thankyou for the advice,
I will definitely try to implement this.

Thanks,
srini
> 
> Yours,
> Linus Walleij
> 
