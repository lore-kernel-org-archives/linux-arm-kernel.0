From: johnstul@us.ibm.com (john stultz)
Date: Mon, 16 Aug 2010 12:38:06 -0700
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>
	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>
Message-ID: <AANLkTikb3HxRSjfnDbDr3DbOJcAONahkdTiNAngoGGnk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 12:24 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Mon, Aug 16, 2010 at 4:17 AM, Richard Cochran
> A few comments below....
>
>> +** PTP user space API
>> +
>> + ? The class driver creates a character device for each registered PTP
>> + ? clock. User space programs may control the clock using standardized
>> + ? ioctls. A program may query, enable, configure, and disable the
>> + ? ancillary clock features. User space can receive time stamped
>> + ? events via blocking read() and poll(). One shot and periodic
>> + ? signals may be configured via an ioctl API with semantics similar
>> + ? to the POSIX timer_settime() system call.
>
> As I mentioned earlier, I'm not a huge fan of the char device
> interface for abstracted PTP clocks.
> If it was just the direct hardware access, similar to RTC, which user
> apps then use as a timesource, I'd not have much of a problem. But as
> I mentioned in an earlier private mail, the abstraction level concerns
> me.

[snip]

> 2) As Arnd already mentioned, the chardev interface seems to duplicate
> the clock_gettime/settime() and adjtimex() interfaces.

And maybe just to clarify, as I saw your response to Arnd, I'm not
suggesting using PTP clocks as clocksources for the internal
timekeeping core. Instead I'm trying to understand why PTP clocks need
the equivalent of the existing posix clocks/timer interface. Why would
only having a read-time interface not suffice?

thanks
-john
