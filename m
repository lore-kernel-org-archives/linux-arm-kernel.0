From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 19 Dec 2012 12:02:59 -0600
Subject: Question about VEXPRESS being "selected" for multiplatform kernels,
 panicking vexpress_sysreg_init_leds
Message-ID: <CAKGA1bkyMb2b5uCYvQBnm015BWcuMiOSCusgje5i7=BE833ZVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey guys,

I can't find a good explanation for it, so I'm asking here; why is vexpress
selected by the multiplatform kernel option?

I can't see any particular reason except that it pulls in a ton of select
items which would be fairly common for multiplatform kernel, although in
our use case (i.MX) all the relevant common options (CPU_V7, COMMON_CLK
etc.) are selected through the proper arch support.

We're getting some weird panics from a function we can't find and the
simplest way we can think of to get rid of them are don't compile in
vexpress - I would like to upstream this (I can't think of any reason
multiplatform would *depend* on the vexpress-specific parts) but I would
like to know the impact of what I am thinking of doing before I think about
it further.

BTW the panics are in vexpress_sysreg_init_leds - which is a function I
can't find at all in the kernel. I don't know how on earth this function
could ever be being called, but it started coming up simply because we put
"loglevel=N" on the kernel line (where N is whatever we wanted it to be for
the correct loglevel of course). Since I can't find the function, I am at a
loss why this even comes up. It seems it got removed about a month ago....

Assuming the Mayans are causing kernel errors for us or something's not
being cleaned up properly, I think we can get around the panic eventually,
but I still would really like to remove the dependency on a specific
platform which would be the true fix to "vexpress init does odd things on
boot if you're not running vexpress" problem for people who have custom
multiplatform kernels.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121219/aab30cfb/attachment-0001.html>
