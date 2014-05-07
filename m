From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 07 May 2014 16:49:04 -0700
Subject: [PATCH v2 2/2] arm64: enable context tracking
In-Reply-To: <20140507101709.GE18456@arm.com> (Will Deacon's message of "Wed,
 7 May 2014 11:17:09 +0100")
References: <1399419149-26685-1-git-send-email-larry.bassel@linaro.org>
 <1399419149-26685-3-git-send-email-larry.bassel@linaro.org>
 <20140507101709.GE18456@arm.com>
Message-ID: <7hr445w3nz.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Will Deacon <will.deacon@arm.com> writes:

> On Wed, May 07, 2014 at 12:32:29AM +0100, Larry Bassel wrote:
>> Make calls to ct_user_enter when the kernel is exited
>> and ct_user_exit when the kernel is entered (in el0_da,
>> el0_ia, el0_svc, el0_irq).
>
> Why only these entry points? I can reschedule after any exception from EL0,
> so I'd expect all exceptions from userspace to need annotating, no?

In my initial approach to this, you might recall (though it was over a
year ago now) was to just instrument kernel_enter rather than sprinkle
the instrumentaion in cl0_*.  However, your concern at the time was that
since it was before debugging was enabled it would complicate debugging
these paths.

Any chance you have any other suggestion on how we might do this in
kernel_entry rather than sprinkling them all over cl0_*?  or is the
sprinkling the only good way to handle this.

Kevin
