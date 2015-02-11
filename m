From: hjl.tools@gmail.com (H.J. Lu)
Date: Wed, 11 Feb 2015 11:16:58 -0800
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211190252.GB23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <CAMe9rOqX-VpjZ+E-JCusk+e4Kpw1V1tsFq1Kjtai5DR9saKLaA@mail.gmail.com>
 <20150211190252.GB23507@brightrain.aerifal.cx>
Message-ID: <CAMe9rOoME1fct=Dk1YFeoJbayvhdsaCUBZCY2YD6jK58J7=MkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 11:02 AM, Rich Felker <dalias@libc.org> wrote:
> On Wed, Feb 11, 2015 at 10:33:32AM -0800, H.J. Lu wrote:
>> On Tue, Feb 10, 2015 at 10:13 AM, Rich Felker <dalias@libc.org> wrote:
>> > On Thu, 2 Oct 2014 at 16:52:18 +0100, Catalin Marinas wrote:
>> >> On Wed, Sep 03, 2014 at 10:18:54PM +0100, Andrew Pinski wrote:
>> >> > New version with all of the requested changes.  Updated to the
>> >> > latest sources.
>> >> >
>> >> > Notable changes from the previous versions:
>> >> > VDSO code has been factored out to be easier to understand and
>> >> > easier to maintain.
>> >> > Move the config option to the last thing that gets added.
>> >> > Added some extra COMPAT_* macros for core dumping for easier usage.
>> >>
>> >> Apart from a few comments I've made, I would also like to see non-empty
>> >> commit logs and long line wrapping (both in commit logs and
>> >> Documentation/). Otherwise, the patches look fine.
>> >>
>> >> So what are the next steps? Are the glibc folk ok with the ILP32 Linux
>> >> ABI? On the kernel side, what I would like to see:
>> >
>> > I don't know if this has been discussed on libc-alpha yet or not, but
>> > I think we need to open a discussion of how it relates to open glibc
>> > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
>> >
>> > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
>>
>> Please leave x32 out of this discussion.  I have resolved this bug
>> as WONTFIX.
>
> From the glibc side, I thought things went by a consensus process
> these days, not the old WONTFIX regime of he who shall not be named.
> If this is not fixed for x32, then x32 cannot provide a conforming C
> environment and thus it's rather a toy target. But I think we should
> discuss this on libc-alpha. In the mean time please leave it REOPENED.

As I said in PR,  the issue has been raised in Mar, 2012 when the
x32 port was submitted.  It has been decided that x32 won't conform
to tv_nsec, blksize_t, and suseconds_t as long.  I don't believe we
will change them to conform to POSIX.

As for if x32 is a toy target or not, it will be decided by whether it
delivers what users are looking for, not by if tv_nsec, blksize_t, and
suseconds_t conform to POSIX.

-- 
H.J.
