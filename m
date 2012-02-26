From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 18:35:10 +0300
Subject: [PATCH 3/3] ARM: PXA27x: Zipit Z2: disable wake on GPIO0
In-Reply-To: <20120226152918.GP22562@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <1330264062-5750-3-git-send-email-anarsoul@gmail.com>
 <20120226142616.GM22562@n2100.arm.linux.org.uk>
 <CA+E=qVdU-kDQYRD51TPRyj-SY4x7njdQ54Wy_wwOWdAue6Wjzg@mail.gmail.com>
 <20120226152918.GP22562@n2100.arm.linux.org.uk>
Message-ID: <CA+E=qVc+kQe1_ThkMiED8Eh8Fv=kAnGT0Djeb09g58rXmhH+AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Feb 26, 2012 at 06:11:17PM +0300, Vasily Khoruzhick wrote:
>> 2012/2/26 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > On Sun, Feb 26, 2012 at 04:47:42PM +0300, Vasily Khoruzhick wrote:
>> >> We don't want machine to wake up on AC state change
>> >
>> > NAK. ?Stop polluting the machine callback methods. ?Use the right one.
>>
>> Ok, what's right one?
>
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*fixup)(struct tag *, char **,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct meminfo *);
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*reserve)(void);/* reserve mem blocks ?*/
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*map_io)(void);/* IO mapping function ?*/
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_early)(void);
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_irq)(void);
> ? ? ? ?struct sys_timer ? ? ? ?*timer; ? ? ? ? /* system tick timer ? ?*/
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_machine)(void);
>
> and chose a more appropriate one from that? ?Maybe init_early() if it
> has to be done early, or preferably the init_machine() if it can wait
> until arch_initcall() time.
>
> But stuffing it into fixup, reserve, map_io, init_irq or the timer
> initialization is pure abuse of those callbacks.

Ok, thanks.

Regards
Vasily
