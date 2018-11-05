From: bp@alien8.de (Borislav Petkov)
Date: Mon, 5 Nov 2018 20:47:21 +0100
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
In-Reply-To: <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
Message-ID: <20181105194721.GB26868@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Nov 05, 2018 at 06:51:26AM -0800, Olof Johansson wrote:
> In general, for new functionality where needing both the driver change
> and a DT change to enable it (or a driver change and a config change
> to enable it), we have been merging the changes separately between
> driver trees and arm-soc. I.e. things will be in place, but not
> enabled, until both sides land. Main reason for doing so is to cut
> down on arbitrary dependencies between the trees, since there can
> sometimes end up being a lot of them.

Well, makes sense too and it is the least problematic approach. :-)

> Since DT should strive for being backwards compatible (i.e, a driver
> change shouldn't require a DT change for the kernel to not regress
> functionally), this has been working pretty well.

Ok.

> However, if there's some other reason to share a base between the two
> trees, we can do that. For most cases we've found that it's not needed
> though. So let us know what you prefer here.

No, I just wanted to make sure drivers can still function when they go
to linux-next. But I certainly can get on board with keeping drivers and
DT changes separate as it requires no sync and the short period of time
when they don't load in linux-next, is perfectly ok.

So can I assume you guys are going to pick up:

https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani at xilinx.com
https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani at xilinx.com

?

I can then pick up the rest.

And I'll be ignoring DT stuff sent to me from now on and concentrate on
the EDAC drivers, assuming former will go through your tree.

Sounds good?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
