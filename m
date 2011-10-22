From: andi@firstfloor.org (Andi Kleen)
Date: Sat, 22 Oct 2011 16:27:18 +0200
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <yw1x1uu5p3sc.fsf@unicorn.mansr.com>
References: <4E9E0B71.9020708@am.sony.com>
	<1318983248.7569.5.camel@Joe-Laptop> <4E9E1944.80601@am.sony.com>
	<1500345.YeXPhIIHc5@wuerfel>
	<CACVXFVMb9p8PiTYWGTNn-FtQts0sRgmK+BQ6kaJ6-D89CAT=xQ@mail.gmail.com>
	<yw1x1uu5p3sc.fsf@unicorn.mansr.com>
Message-ID: <8d6b949ee16a092a660a7b05fdaf6d6a.squirrel@www.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> If system run for some time, sometimes it may be difficult for
>> memory allocator to allocate 2 continuous page frames even  there are
>> many spare page frames in system because of
>> fragment issue, so the patch does make sense. Anyway,
>> it provides one option for user to apply 4k stack to avoid
>> such kind of process creation failure.
>
> Can't page migration be used in these situations?

The kernel already uses it of course, assuming the pages are movable.
So if you are really worried about this, just define a movable zone.

-Andi
