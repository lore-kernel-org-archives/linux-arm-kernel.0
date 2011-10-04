From: padma.kvr@gmail.com (padma venkat)
Date: Tue, 4 Oct 2011 10:50:30 +0530
Subject: [PATCH 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <20111001152938.GD11710@n2100.arm.linux.org.uk>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-2-git-send-email-padma.v@samsung.com>
	<20111001152938.GD11710@n2100.arm.linux.org.uk>
Message-ID: <CAAgF-Bckzj_6U4WjLH6=x1d1Psdc4BHB9hVWy9bQ_o53dDz4vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you all for your comments.
Will resend the patches after removing "&" from the clk parameter and
trailing "," at the end of Macro.

Thanks and Regards,
Padmavathi Venna

On Sat, Oct 1, 2011 at 8:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 30, 2011 at 04:41:36PM +0530, Padmavathi Venna wrote:
>> +#define CLKDEV_INIT(d, n, c) \
>> + ? ? { \
>> + ? ? ? ? ? ? .dev_id = d, \
>> + ? ? ? ? ? ? .con_id = n, \
>> + ? ? ? ? ? ? .clk = &c, \
>> + ? ? },
>> +
>
> As Heartley says, the trailing , and the end should not be there - it
> should be with each use of CLKDEV_INIT(). ?The reasoning is that it
> makes the use of macros much more conventional and consistent throughout
> the kernel:
>
> struct cl_lookup foo_lookups[] = {
> ? ? ? ?CLKDEV_INIT(...),
> ? ? ? ?CLKDEV_INIT(...),
> };
>
> struct cl_lookup bar_lookup = CLKDEV_INIT(...);
>
> Could you re-spin with that change please?
>
> Thanks.
>
