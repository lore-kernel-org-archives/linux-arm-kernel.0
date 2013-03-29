From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 29 Mar 2013 16:37:17 -0300
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
Message-ID: <20130329193716.GA7127@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 11:09:23AM -0700, Ryan Press wrote:
> Hi Jason,
> 
> On Fri, Mar 29, 2013 at 11:04 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Fri, Mar 29, 2013 at 10:51:17AM -0700, Ryan Press wrote:
> >> The memory size in the device tree is only 512 MB, but the
> >> Mirabox actually has 1 GB.
> >>
> >> Tested the change with memtester and no problems found.
> >>
> >> Signed-off-by: Ryan Press <ryan@presslab.us>
> >> ---
> >>  arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Thanks for the patch.  It looks good, but please don't forget to Cc: the
> > maintainers (Andrew Lunn, Gregory Clemente, and myself).  I almost
> > missed this one. :)
> >

As far as I can remember, Gregory has a Mirabox with only 512 MiB,
which means some boards were shipped with 512 MiB and some with 1 GiB.
Moreover, apparently nothing can distinguish one from the other.

@Gregory: can you confirm this?

If Gregory confirms this, then we shouldn't apply this patch.
Don't forget in-kernel DTS are only meant for developers and
for reference. The vendor (Globalscale in this case) has to ship
a proper DTS for each board.

> > thx,
> >
> > Jason.
> 
> Okay I didn't know I needed to do that.  Thanks!
> 

Although it's not mandatory, you can do a 'git blame' on the file you're
patching and find out who should you put on Cc.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
