From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 3 Feb 2012 16:16:28 -0700
Subject: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
In-Reply-To: <20111026073348.GB2915@opensource.wolfsonmicro.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com>
 <20111026073348.GB2915@opensource.wolfsonmicro.com>
Message-ID: <CACxGe6sbwy8z+U8=5rtvjyDrt3SZD2N33GiGHwPOMUAxt_BXTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2011 at 1:33 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 25, 2011 at 07:44:14PM -0400, Mike Frysinger wrote:
>
>> i don't think this is generally how asm-generic is handled. ?instead, how about:
>> ?- move the duplicate code to asm-generic/gpio.h
>> ?- have the arches which merely need asm-generic/gpio.h add "generic-y
>> += gpio.h" to their include/asm/Kbuild
>> ?- for arches which need to override these common funcs in some way,
>> add #ifdef protection to the asm-generic/gpio.h
>
>> and it seems like with slightly more work, this path allow you to
>> merge most of arch/sh/include/asm/gpio.h. ?and it has the advantage of
>> not needing new Kconfig symbols.
>
> That's really not how gpiolib is currently handled, unfortunately -
> trying to transition over to that model in one patch would be way too
> much.
>
> The goal here from that point of view is to make transitioning to
> something more sensible easier by getting rid of the boilerplate code,
> it makes doing the more invasive changes like you're suggesting much
> easier as we're only dealing with the architectures that are actually
> doing something. ?It also means that we're able to immediately work on
> turning on gpiolib on random architectures which is a definite win.

I had picked up this patch, but I've dropped again from gpio/next
since there are still a lot of drivers including asm/gpio.h.  It
caused build breakage on linux-next with allmodconfig.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
