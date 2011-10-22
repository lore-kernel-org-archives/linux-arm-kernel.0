From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 22 Oct 2011 14:13:55 +0100
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <CACVXFVMb9p8PiTYWGTNn-FtQts0sRgmK+BQ6kaJ6-D89CAT=xQ@mail.gmail.com>
	(Ming Lei's message of "Sat, 22 Oct 2011 16:50:15 +0800")
References: <4E9E0B71.9020708@am.sony.com>
	<1318983248.7569.5.camel@Joe-Laptop> <4E9E1944.80601@am.sony.com>
	<1500345.YeXPhIIHc5@wuerfel>
	<CACVXFVMb9p8PiTYWGTNn-FtQts0sRgmK+BQ6kaJ6-D89CAT=xQ@mail.gmail.com>
Message-ID: <yw1x1uu5p3sc.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:

> On Wed, Oct 19, 2011 at 6:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 18 October 2011 17:26:44 Tim Bird wrote:
>>> Even inside Sony, usage of 4K stacks is limited
>>> to some very special cases, where memory is exceedingly
>>> tight (we have one system with 4M of RAM). ?And we
>>> don't mind lopping off features or coding around
>>> problem areas to support our special case.
>>
>> I would imagine that in those cases, you can gain more by reducing the
>> number of threads in the system. What is the highest number of
>> concurrent threads that you expect in a limited use case with no
>> networking or block devices?
>
> If system run for some time, sometimes it may be difficult for
> memory allocator to allocate 2 continuous page frames even  there are
> many spare page frames in system because of
> fragment issue, so the patch does make sense. Anyway,
> it provides one option for user to apply 4k stack to avoid
> such kind of process creation failure.

Can't page migration be used in these situations?

-- 
M?ns Rullg?rd
mans at mansr.com
