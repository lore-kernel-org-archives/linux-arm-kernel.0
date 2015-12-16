From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 16 Dec 2015 09:47:22 +0530
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <20151215181407.GB8568@leverpostej>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
 <20151215181407.GB8568@leverpostej>
Message-ID: <CABb+yY1dD3+A9DqLz4uCB2HcX8eRgBcQq95MVrOOeYUt4xR+0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 11:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 25, 2015 at 10:54:04AM +0530, Jassi Brar wrote:
>> The GT counter is common to every core in a cluster. There is a usecase
>> when Linux is spawned by a 'master' firmware/OS running on some core of
>> the same cluster and the GT is used by the both.
>>  Linux, upon boot, resetting the GT counter is obviously fatal to the
>> other OS. So provide a way for DT to tell Linux if it's running in that
>> 'slave' mode and must not reset the counter.
>
> Is the other OS only using the counter?
>
I understand only the Global Counter and the (unused) PreScalar are
common to cores in a cluster.

> Or are there other porions of the global timer that it assumes its in
> sole control of?
>
More important than 'control' is the fact that the other OS boots
first. So it can not survive a reset to the global counter.

>> +
>> +** Optional properties:
>> +
>> +- arm,gt_no_reset : Firmware/bootloader already initialized the
>> +     global timer-counter and expects it to be not reset again.
>
> s/_/-/ in property names.
>
> No need for the "gt" prefix, this is on tthe glboal timer node.
>
OK

> It "no-counter-reset" seems like a better description, though that
> really depends on how the other OS is using this.
>
OK will change it to "no-counter-reset".

Thanks.
