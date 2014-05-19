From: robh@kernel.org (Rob Herring)
Date: Mon, 19 May 2014 18:06:02 -0500
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <4931877.zNfKfvcgox@wuerfel>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140516184205.GL27822@titan.lakedaemon.net>
 <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
 <4931877.zNfKfvcgox@wuerfel>
Message-ID: <CAL_Jsq+kOu82okhJn0_ftwemE_m4nsTRawrF-fWAU2XTJ9xRcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 7:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 16 May 2014 23:20:42 Ben Hutchings wrote:
>> On Fri, 2014-05-16 at 14:42 -0400, Jason Cooper wrote:
>> > On Fri, May 16, 2014 at 07:31:51PM +0100, Ben Hutchings wrote:
>> > > Our 'legacy' (which I take to mean pre-v7) configurations are now
>> > > kirkwood, mv78xx0, orion5x (all about to converge to mvebu) and
>> > > versatile.
>> >
>> > I'm not familiar with versatile, the others I've seen a few times.
>>
>> Versatile is one of ARM's own development boards, but more importantly
>> it's something QEMU can emulate.
>
> We should really have this in multiplatform soon, I think the last issue
> for versatile is common clock support, but Linus Walleij may have more
> details about what remains here.

While not necessarily the same thing, but does move versatile in the
right direction, I've got patches in progress which fully move
versatile over to DT. The main issues there are:

common clock
irq cntlr init from DT
Move PCI to DT and platform driver

I'd like to do this all in one step to avoid doing things like non-DT
common clock init. It's blocked on the common DT PCI code and my free
time.

There are then a few bits related to mach/plat headers needed move
versatile to multiplatform. I think these issues are mostly the same
changes that have been done or are needed on integrator which is what
Linus has been working on.

Rob
