From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Jun 2018 10:51:46 +0200
Subject: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
In-Reply-To: <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <CAMuHMdVXrppnFEBmR3xhwNu3i0N3mVE1+FJRjEcWBYpHHbsAsw@mail.gmail.com>
 <CAOtvUMc8D9DQFC6vZ+GnaVBg5uFVrQmOrnSQKz7ZPHGh4BCsZg@mail.gmail.com>
Message-ID: <20180620085145.7bxfbu7bi45sftnk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 04:57:15PM +0300, Gilad Ben-Yossef wrote:
> On Tue, Jun 19, 2018 at 3:58 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Gilad,
> >
> > On Thu, May 24, 2018 at 4:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> >> The patch set enables the use of CryptoCell found in some Renesas R-Car
> >> Salvator-X boards and fixes some driver issues uncovered that prevented
> >> to work properly.
> >
> > With DEBUG enabled on R-Car H3, I see lots of
> >
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x00000098)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000C0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000D8)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000E0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F0)
> >     ccree e6601000.crypto: IRR includes unknown cause bits (0x000000F8)
> >
> > during boot. Is that expected?
> 
> Yes. The condition itself it is reporting is not necessarily bad. It
> means that driver
> did not act on certain HW notification during interrupts and that's
> OK, we don't act on all of them
> depending on configuration - e.g. if you have CONFIG_FIPS enabled and
> an active TEE module or not.
> 
> I can rate_limit the message if it bothers you but other than that it
> is a harmless debug print.

Rate limiting sounds like an excellent idea to me.
