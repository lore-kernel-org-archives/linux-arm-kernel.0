From: zdevai@gmail.com (Zoltan Devai)
Date: Mon, 1 Aug 2011 13:41:32 +0200
Subject: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
In-Reply-To: <20110801083614.GC15578@n2100.arm.linux.org.uk>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
	<20110801083614.GC15578@n2100.arm.linux.org.uk>
Message-ID: <CAGVye5Nh2E4L3Ox=OKvG09v4hO6BjGmLUGZ5=Ha2QzbXar+deA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jul 30, 2011 at 06:14:38PM +0200, Zoltan Devai wrote:
>> Commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b has killed off any
>> use of this config option long ago.
>
> I don't see the point of this - we were free of GENERIC_TIME on ARM
> shortly after it was originally killed off. ?The problem is you can't
> stop people introducing new uses of this - because it existed once and
> there's nothing which errors out on its presence, people are going to
> continue submitting patches with it in. ?And it's going to continue
> being missed at the review stage.
>
> I've a similar problem with folk on ARM including mach/gpio.h as their
> sole gpio header file rather than linux/gpio.h - I've been trying for
> the last 1-2 years to educate people to use linux/ in preference. ?You
> can't do it, and I'm still just about the only one who picks up on that.
> (SoC maintainers don't care.) ?They will end up caring when I push a
> change during the next merge window though, so I'll eventually stop
> mach/gpio.h being included. ?(Instead, it'll be asm/gpio.h).
>
> GENERIC_TIME though... I don't think you'll ever stop new uses of it
> creeping in unless you can arrange for something to error out.

Sure, but the patch at least reduces the chances of copy-pasting it,
and makes it obvious by a simple grep that there's no use of it at all,
so I still think it's wort merging.

Don't know though who should pick this up...

Z
