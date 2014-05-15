From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 May 2014 15:42:15 -0400
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140511083729.211e9b5f@lwn.net>
 <20140515121546.3A06AC40B0E@trevor.secretlab.ca>
 <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
Message-ID: <20140515194215.GR27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 01:50:02PM -0500, Rob Herring wrote:
> On Thu, May 15, 2014 at 7:15 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Sun, 11 May 2014 08:37:29 -0400, Jonathan Corbet <corbet@lwn.net> wrote:
> >> On Sat, 10 May 2014 23:00:09 -0400
> >> Jason Cooper <jason@lakedaemon.net> wrote:
> >>
> >> > So, I'm proposing a session where each sub-arch gives a brief run-down
> >> > of the status of the legacy board conversion, and wraps up with a todo
> >> > list.  After all of the sub-arches have given their status (5 - 10
> >> > minutes each?), we hash out helping each other with the final pieces.
> >>
> >> This *really* looks like an ARM minisummit topic to me; hopefully one
> >> of those is in the works?
> >
> > It does, doesn't it? I wouldn't want this as a main ksummit topic.
> >
> > The problem with ARM minisummits these days is it is very easy to
> > devolve into a nothing-but-dt meeting with a bunch of people sitting
> > around looking either annoyed or bored. We weren't able to pull enough
> > topics together when we tried to do an ARM minisummit at the ELC.
> >
> > Instead of a traditional ARM minisummit, perhaps we should do an ARM
> > platforms minisprint instead. Light on any kind of presentations, but
> > have the right people in the room to try and knock out some of the
> > legacy backlog (which is kind of what Jason described)
> 
> Isn't a large part of the backlog cases of we need DT bindings for X?
> There are cases like moving platforms to common clk, but is there
> anything to discuss for those? Most of those cases need bodies to work
> on them. It seems like the rest of the todo lists could become an all
> DT discussion. I'm not saying it shouldn't happen, just pointing out
> where I think sprint discussions will go.

As gregkh mentioned for the staging tree:

$ ls arch/arm/*/TODO

would be helpful for folks who aren't familiar with an SoC, but can
easily generate patches.  imho, this is work for *after* the proposed
discussion.  We don't currently have a good idea which directories to
deprecate, convert, or leave to bit rot.  Once we do, I think the TODO
list would be helpful.

My main reason for raising this topic was the proximity to LinuxCon.
There's a better chance of getting some distro representation to give us
valuable feedback: "This SoC is quiet, no patches, but is actively used"
and "We thought the kernel guys had a reason for keeping that one."

eg: I know ixp4xx had an active community around it at one time for the
NSLU2, and the Gateworks boards used that SoC.  Are there people still
running it?  Well, my Dad is, but I can fix that if needed. ;-)

thx,

Jason.
