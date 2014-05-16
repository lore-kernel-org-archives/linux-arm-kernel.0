From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 00:10:22 -0400
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <CAOesGMi0JrTp9kUVDod4duBOCZ+wNRJ0dMmgvBX7jEQRjE5cCA@mail.gmail.com>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140511083729.211e9b5f@lwn.net>
 <20140515121546.3A06AC40B0E@trevor.secretlab.ca>
 <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
 <20140515194215.GR27822@titan.lakedaemon.net>
 <CAOesGMi0JrTp9kUVDod4duBOCZ+wNRJ0dMmgvBX7jEQRjE5cCA@mail.gmail.com>
Message-ID: <20140516041022.GY27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 08:30:10PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, May 15, 2014 at 12:42 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Thu, May 15, 2014 at 01:50:02PM -0500, Rob Herring wrote:
> >> On Thu, May 15, 2014 at 7:15 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >> > On Sun, 11 May 2014 08:37:29 -0400, Jonathan Corbet <corbet@lwn.net> wrote:
> >> >> On Sat, 10 May 2014 23:00:09 -0400
> >> >> Jason Cooper <jason@lakedaemon.net> wrote:
> >> >>
> >> >> > So, I'm proposing a session where each sub-arch gives a brief run-down
> >> >> > of the status of the legacy board conversion, and wraps up with a todo
> >> >> > list.  After all of the sub-arches have given their status (5 - 10
> >> >> > minutes each?), we hash out helping each other with the final pieces.
> >> >>
> >> >> This *really* looks like an ARM minisummit topic to me; hopefully one
> >> >> of those is in the works?
> >> >
> >> > It does, doesn't it? I wouldn't want this as a main ksummit topic.
> >> >
> >> > The problem with ARM minisummits these days is it is very easy to
> >> > devolve into a nothing-but-dt meeting with a bunch of people sitting
> >> > around looking either annoyed or bored. We weren't able to pull enough
> >> > topics together when we tried to do an ARM minisummit at the ELC.
> >> >
> >> > Instead of a traditional ARM minisummit, perhaps we should do an ARM
> >> > platforms minisprint instead. Light on any kind of presentations, but
> >> > have the right people in the room to try and knock out some of the
> >> > legacy backlog (which is kind of what Jason described)
> >>
> >> Isn't a large part of the backlog cases of we need DT bindings for X?
> >> There are cases like moving platforms to common clk, but is there
> >> anything to discuss for those? Most of those cases need bodies to work
> >> on them. It seems like the rest of the todo lists could become an all
> >> DT discussion. I'm not saying it shouldn't happen, just pointing out
> >> where I think sprint discussions will go.
> >
> > As gregkh mentioned for the staging tree:
> >
> > $ ls arch/arm/*/TODO
> >
> > would be helpful for folks who aren't familiar with an SoC, but can
> > easily generate patches.  imho, this is work for *after* the proposed
> > discussion.  We don't currently have a good idea which directories to
> > deprecate, convert, or leave to bit rot.  Once we do, I think the TODO
> > list would be helpful.
> 
> Anyone should feel free to add a TODO file and list in their machine
> directory at any given time. I don't think there's need for discussion
> before that happens. 

If there's a maintainer adding a todo file, then by default, that keeps
it out of bitrot and deprecation categories :)

> There's also the elinux.org wikis if you want to
> keep it out of the kernel -- keeping the TODO around for old kernel
> versions might not be very useful so having it out of tree might be
> just as fine.
> 
> > My main reason for raising this topic was the proximity to LinuxCon.
> > There's a better chance of getting some distro representation to give us
> > valuable feedback: "This SoC is quiet, no patches, but is actively used"
> > and "We thought the kernel guys had a reason for keeping that one."
> 
> Funny, I would have thought ELC to have been a much more suitable
> venue for that, especially since the older ARM platforms tend to be
> embedded, and not generic compute ones. :)

I agree, but I couldn't make it there this year :(

Also, when I initially submitted this proposal I didn't know if there
was going to be a ARM mini-summit or not.  If not, I thought this might
be worth discussing amongst the ARM folks for an hour or so.

> > eg: I know ixp4xx had an active community around it at one time for the
> > NSLU2, and the Gateworks boards used that SoC.  Are there people still
> > running it?  Well, my Dad is, but I can fix that if needed. ;-)
> 
> I suspect it'll be hard to get that answered at LinuxCon, nor at an
> ARM maintainer summit since the fringe platforms tend to not be
> represented there either.

Ok, I assumed *everybody* in the Linux ecosystem went to LinuxCon.  I've
never actually been to one, but that museum was really crowded in
Edinburgh.  I figured that _must_ be everybody. :)

Joking aside, I concede your point.  It looks like the last two mvebu
legacy platforms (dove, mv78xx0) might get merged into mach-mvebu during
the next cycle.  After that, we can reach out to the Debian and OpenWRT
guys and see what legacy platforms are in use or rotting.  We can go
from there.

thx,

Jason.
