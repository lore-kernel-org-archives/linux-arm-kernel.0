From: hjl.tools@gmail.com (H.J. Lu)
Date: Wed, 11 Feb 2015 11:57:59 -0800
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211194741.GI23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <CAMe9rOqX-VpjZ+E-JCusk+e4Kpw1V1tsFq1Kjtai5DR9saKLaA@mail.gmail.com>
 <20150211190252.GB23507@brightrain.aerifal.cx>
 <CAMe9rOoME1fct=Dk1YFeoJbayvhdsaCUBZCY2YD6jK58J7=MkA@mail.gmail.com>
 <20150211192558.GE23507@brightrain.aerifal.cx>
 <CAMe9rOpr6j1siK5gJ_HPLTOfjG_sLOL48TFzaLx+shCS9O8ahA@mail.gmail.com>
 <20150211194741.GI23507@brightrain.aerifal.cx>
Message-ID: <CAMe9rOrVGFcQN3J1-pkXWd9j4MaQv2QxPrA5cTtLPBPaQ2-zfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > trivially satisfied if you consider x32 and x86_64 separate
>> > compilation environments, but it's not related to the core issue: that
>> > the definition of timespec violates core (not obscure) requirements of
>> > both POSIX and C11. At the time you were probably unaware of the C11
>> > requirement. Note that it's a LOT harder to effect change in the C
>> > standard, so even if the Austin Group would be amenable to changing
>> > the requirement for timespec to allow something like nseconds_t,
>> > getting WG14 to make this change to work around a Linux/glibc mistake
>> > does not sound practical.
>>
>> That is very unfortunate.  I consider it is too late for x32 to change.
>
> Why? It's hardly an incompatible ABI change, as long as the
> kernel/libc fills the upper bits (for old programs that read them
> based on the old headers) when structs are read from the kernel to the
> application, and ignores the upper bits (potentially set or left
> uninitialized by the application) when strings are passed from
> userspace to the kernel. Newly built apps using the struct definition
> with 32-bit tv_nsec would need new libc to ensure that the high bits
> aren't interpreted, but this could be handled by symbol versioning.
>

We have considered this option.  But since kernel wouldn't change
tv_nsec/tv_usec handling just for x32, it wasn't selected.



-- 
H.J.
