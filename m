From: contact.aneesh@gmail.com (Aneesh Bhasin)
Date: Tue, 11 May 2010 10:19:53 +0530
Subject: ARM A9 MPCore support in OProfile ?
In-Reply-To: <1273518638.25180.3.camel@e200755-lin.cambridge.arm.com>
References: <AANLkTimc70m7gVpPxf01qTD3O6Y63gGwrF76RBlABfsR@mail.gmail.com>
	<1273502472.10282.60.camel@e102109-lin.cambridge.arm.com>
	<1273518638.25180.3.camel@e200755-lin.cambridge.arm.com>
Message-ID: <AANLkTikpeJ8x1PbtcVojfiSltYiH7L-t-Lqz8QR7eogS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 12:40 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Aneesh,
>
> On Mon, 2010-05-10 at 15:41 +0100, Catalin Marinas wrote:
>> On Mon, 2010-05-10 at 12:29 +0100, Aneesh Bhasin wrote:
>> > Had sent this to the oprofile-list too, but did not get any reply.
>> > Hopefully, someone here who has experience with this could help..
>> >
>> > Can someone please tell what is the status of support for ARM A9
>> > MPCore PMU in OProfile ?
>> >
>> > I was browsing the linux-arm repository at
>> >
>> > http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=summary
>> >
>> > and could see that it has support for A9 MPCore but could not find
>> > anything related to it in the OProfile source-code (e.g .in
>> > events/arm). Is there any patch that needs to be applied to use A9
>> > MPCore PMU with OProfile ?
>>
>> The Oprofile patches (by Will Deacon) are in Russell's devel tree and
>> intended for upstream merge:
>>
>> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/devel
>>
>> My stable repository has some old Oprofile implementation (it requires
>> additional patches for user space - I can dig them out if you really
>> need them but I would recommend Will's version).
>>
> As Catalin has pointed out, the Kernel patches are in Russell's tree now
> so should make their way upstream via the usual route. For OProfile,
> there is a trivial userspace patch to add A9 support which I plan to
> post to the OProfile mailing list next week. In the meantime, you could
> use perf events, which doesn't need any patches to the userspace tools.
>
> Will
>
>

Thanks for replying Will & Catalin. It would be helpful if you could
send me the userspace patch for OProfile as well as I would like to
try in on our board for profiling. Also, correct me if I am wrong, but
I understand that perf events are only available in the recent kernel
versions while we are using 2.6.28 which does not support them.
However, in case it is not so then it will be very helpful if you
could point me to the right resources/docs regarding using it with A9
MPcore.

Thanks..

Aneesh
