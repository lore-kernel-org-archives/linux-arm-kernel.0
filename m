From: hjl.tools@gmail.com (H.J. Lu)
Date: Wed, 11 Feb 2015 11:34:23 -0800
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211192558.GE23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <CAMe9rOqX-VpjZ+E-JCusk+e4Kpw1V1tsFq1Kjtai5DR9saKLaA@mail.gmail.com>
 <20150211190252.GB23507@brightrain.aerifal.cx>
 <CAMe9rOoME1fct=Dk1YFeoJbayvhdsaCUBZCY2YD6jK58J7=MkA@mail.gmail.com>
 <20150211192558.GE23507@brightrain.aerifal.cx>
Message-ID: <CAMe9rOpr6j1siK5gJ_HPLTOfjG_sLOL48TFzaLx+shCS9O8ahA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 11:25 AM, Rich Felker <dalias@libc.org> wrote:
> On Wed, Feb 11, 2015 at 11:16:58AM -0800, H.J. Lu wrote:
>> >> > I don't know if this has been discussed on libc-alpha yet or not, but
>> >> > I think we need to open a discussion of how it relates to open glibc
>> >> > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
>> >> >
>> >> > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
>> >>
>> >> Please leave x32 out of this discussion.  I have resolved this bug
>> >> as WONTFIX.
>> >
>> > From the glibc side, I thought things went by a consensus process
>> > these days, not the old WONTFIX regime of he who shall not be named.
>> > If this is not fixed for x32, then x32 cannot provide a conforming C
>> > environment and thus it's rather a toy target. But I think we should
>> > discuss this on libc-alpha. In the mean time please leave it REOPENED.
>>
>> As I said in PR,  the issue has been raised in Mar, 2012 when the
>> x32 port was submitted.  It has been decided that x32 won't conform
>> to tv_nsec, blksize_t, and suseconds_t as long.  I don't believe we
>> will change them to conform to POSIX.
>
> I briefly reviewed that discussion and I think the decision made was
> about an obscure POSIX requirement about supporting at least one
> compilation environment where certain types have rank <= long. This is

The example you gave in PR is similar to

https://sourceware.org/ml/libc-alpha/2012-03/msg00456.html

> trivially satisfied if you consider x32 and x86_64 separate
> compilation environments, but it's not related to the core issue: that
> the definition of timespec violates core (not obscure) requirements of
> both POSIX and C11. At the time you were probably unaware of the C11
> requirement. Note that it's a LOT harder to effect change in the C
> standard, so even if the Austin Group would be amenable to changing
> the requirement for timespec to allow something like nseconds_t,
> getting WG14 to make this change to work around a Linux/glibc mistake
> does not sound practical.

That is very unfortunate.  I consider it is too late for x32 to change.


-- 
H.J.
