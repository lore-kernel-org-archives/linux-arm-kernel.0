From: pinskia@gmail.com (Andrew Pinski)
Date: Mon, 30 Nov 2015 16:20:58 -0800
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3463212.HtU7UeIULQ@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <2133692.Tueq9xZUPQ@wuerfel> <20151130202141.GA23254@yury-N73SV>
 <3463212.HtU7UeIULQ@wuerfel>
Message-ID: <CA+=Sn1kmUqq0ZqsC9M41zCouQqzu6664d4hG3hWNAV-ga40iwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 1:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 30 November 2015 23:21:41 Yury Norov wrote:
>> On Mon, Nov 30, 2015 at 04:34:22PM +0100, Arnd Bergmann wrote:
>> > On Tuesday 17 November 2015 22:57:52 Arnd Bergmann wrote:
>> > > On Wednesday 18 November 2015 00:16:54 Yury Norov wrote:
>> > > > From: Andrew Pinski <apinski@cavium.com>
>> > > >
>> > > > Add a separate syscall-table for ILP32, which dispatches either to native
>> > > > LP64 system call implementation or to compat-syscalls, as appropriate.
>> > >
>> > > I like it much better than the previous version, thanks for the rework!
>> >
>> > Hi Yuri,
>> >
>> > you must have missed my reply below. Are you still working on ilp32
>> > or did you drop this thread because you got distracted with something
>> > else?
>> >
>>
>> I didn't miss it, and I continue with ILP32. I really appreciate your
>> attention and time you spend on ILP32.
>>
>> There's a tricky bug with signal stack, that Andreas also discovered.
>> It makes almost all tests that use posix threads crash. I want to fix
>> it and other bugs before next submission.
>>
>> I also update glibc to follow all recommendations, and I want to
>> upload it together with kernel patches.
>
> Ok. As a reviewer, I find long waits between submissions a bit annoying
> because that means I have already forgotten everything I commented on
> the previous time.
>
> Could we try to get consensus on how the syscall ABI should look
> before you start adapting glibc to another intermediate version?

Sounds good. I have asked Yury to do that just that and change the
patches according to the current reviews without testing them with a
newer version of glibc.   Note getting consensus would be nice soon as
possible so I can start working again on glibc patches and make sure
the changes that are made to support a slightly different ABI on the
userland side is ok with them.

Thanks,
Andrew

> I think that would also save you duplicate work, as it's always
> possible that we misunderstand each other in the review. Also,
> when someone asks you questions during a review, please reply to
> those questions so we can get a common understanding of the facts
> and document that in the mail archives.
>
>         Arnd
