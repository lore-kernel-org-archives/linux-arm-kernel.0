From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2018 12:38:05 -0800
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
In-Reply-To: <20181105194721.GB26868@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
 <20181105194721.GB26868@zn.tnic>
Message-ID: <CAOesGMjsPWeRZEeBH37uLQFBKwAWNMh5yCvuKNYrOUDfRSSYog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 11:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi Olof,
>
> On Mon, Nov 05, 2018 at 06:51:26AM -0800, Olof Johansson wrote:
> > In general, for new functionality where needing both the driver change
> > and a DT change to enable it (or a driver change and a config change
> > to enable it), we have been merging the changes separately between
> > driver trees and arm-soc. I.e. things will be in place, but not
> > enabled, until both sides land. Main reason for doing so is to cut
> > down on arbitrary dependencies between the trees, since there can
> > sometimes end up being a lot of them.
>
> Well, makes sense too and it is the least problematic approach. :-)
>
> > Since DT should strive for being backwards compatible (i.e, a driver
> > change shouldn't require a DT change for the kernel to not regress
> > functionally), this has been working pretty well.
>
> Ok.
>
> > However, if there's some other reason to share a base between the two
> > trees, we can do that. For most cases we've found that it's not needed
> > though. So let us know what you prefer here.
>
> No, I just wanted to make sure drivers can still function when they go
> to linux-next. But I certainly can get on board with keeping drivers and
> DT changes separate as it requires no sync and the short period of time
> when they don't load in linux-next, is perfectly ok.

Ok, sounds good.

> So can I assume you guys are going to pick up:
>
> https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani at xilinx.com
> https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani at xilinx.com

Yeah, Michal should pick those up for his platform and send them in to
us (or let us know if he wants us to take them directly, but usually
they come in through platform maintainers sending us pull requests).

>
> ?
>
> I can then pick up the rest.
>
> And I'll be ignoring DT stuff sent to me from now on and concentrate on
> the EDAC drivers, assuming former will go through your tree.
>
> Sounds good?

Yeah, that's the way we've been trying to do for various subsystems
and it's been working pretty well. Of course, if there's need to
coordinate more closely for something in the future we'll be happy to
do so.


-Olof
