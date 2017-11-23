From: jgg@mellanox.com (Jason Gunthorpe)
Date: Thu, 23 Nov 2017 09:33:14 -0700
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123153637.kbqcd2jsek4ybeic@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171123153637.kbqcd2jsek4ybeic@piout.net>
Message-ID: <20171123163314.GF18754@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 04:36:37PM +0100, Alexandre Belloni wrote:

> It wasn't sent to the RTC ML but that's fine.

Okay, my mistake.

> > Like Russell has said already, the kernel is the only place that could
> > actually have all the information needed. User space would have to use
> > some kind of trail and error approach to figure out what the offset
> > should be.
>
> And I don't see how this is different from doing it in the kernel.

Well, the kernel is closer to the RTC and can issue a single I2C
operation to directly measure bus latency, so it is in a far better
place to do this than user space...

> You currently don't give any feedback loop so the RTC driver doesn't
> know whether it's own offset is correct or not.

Feedback would be very complicated, that seems reasonable to push it
to userspace if people care enough to trim the RTC set very finely.
Allowing userspace to trim set offset from the driver would be
trivial.

Remember, the main goal here is to get bulk accuracy, by supporting
the RTC HW specific offset, which is currently wrong by 0.5s or more
on a lot of RTC hardware.

Jason
