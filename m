From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 4 Feb 2015 21:03:50 +0530
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <3593142.nVgVfPmW1o@wuerfel>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <4418090.U8XOXMKsEU@wuerfel>
 <CAJe_Zhe_d-H10J8cH-fxcbusoJV8jMUW-pruXVkEKY7PnLMGFA@mail.gmail.com>
 <3593142.nVgVfPmW1o@wuerfel>
Message-ID: <CAJe_ZhceTfWnSWmR+_T+G-BM00hAhTbn5OGwNiOZQFxy6f5QSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2015 at 20:18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 04 February 2015 20:04:21 Jassi Brar wrote:
>>
>> > Using the bits of the pointer as the message instead of pointing
>> > to the message feels like an abuse of the API.
>> >
>> I can see your POV.
>> Now consider a client, like mine, that sends a u32 value as the data.
>> But unlike me, the client uses the mailbox api in 'async' mode i.e,
>> register a callback function, submit a 32bit message and move on. It
>> is perfectly doable, but doesn't kalloc'ing a u32 for each submission,
>> seem overkill?
>
> That could easily be done by dereferencing the message data in the
> function that queues the asynchronous message: instead of queuing
> the pointer, you queue the data in the driver.
>
The 'void *data' is not queued in the driver, but in the API code. Or
do I not get your point?

Thanks.
