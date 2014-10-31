From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 Oct 2014 08:55:12 -0700
Subject: [PATCH v2] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
In-Reply-To: <54534C17.7050703@samsung.com>
References: <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <1414727409-6765-1-git-send-email-addy.ke@rock-chips.com>
 <54534C17.7050703@samsung.com>
Message-ID: <CAD=FV=Wmb0ZhB1WmK9SPg28LWB3zv9oNj0peTx3Ybt_KMSv7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Fri, Oct 31, 2014 at 1:45 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Addy.
>
> On 10/31/2014 12:50 PM, Addy Ke wrote:
>> The bit of sdio interrupt is 16 in designware implementation,
>> but it is 24 in RK3288. This patch add sdio_id0 for the number
>> of slot0 in the SDIO interrupt registers, which can be set in
>> platform DT table, such as:
>> - rockchip,sdio-interrupt-slot0 = <8>;
>
> I have a question. (It's not important question)
> You mentioned the sdio-irq bit used from 24 to 31, right?
> Then what interrupts are used from 16 to 23 at RK3288? Just reserved?

In my TRM 16 shows as "data_nobusy".  A quick search doesn't show any
documentation for what this means.  17-23 and 25-31 are reserved.

Note that (of course) there's no actual support for more than one slot
on rk3288, so claiming that "24-31" is SDIO INT is a little silly, but
I agree that it's probably is the best way to fit into the existing
code until someone gets around to removing the whole multi-slot cruft.
