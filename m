From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 15:01:49 +0800
Subject: [PATCH] ARM: i.MX: mx21ads: Replace direct handling of
 peripheral bits with GPIOs
In-Reply-To: <1394002407.236079875@f309.i.mail.ru>
References: <1393871864-25223-1-git-send-email-shc_work@mail.ru>
 <20140305055634.GG8784@S2101-09.ap.freescale.net>
 <1394002407.236079875@f309.i.mail.ru>
Message-ID: <20140305070147.GL8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:53:27AM +0400, Alexander Shiyan wrote:
> ?????,  5 ????? 2014, 13:56 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> > On Mon, Mar 03, 2014 at 10:37:44PM +0400, Alexander Shiyan wrote:
> > > This patch replaces direct handling of peripheral bits with GPIOs by
> > > using basic-mmio-gpio driver. As a result this change eliminate some
> > > low-level code and removes custom io_map() from the board.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-imx/mach-mx21ads.c | 136 +++++++++++++++++++--------------------
> > >  1 file changed, 66 insertions(+), 70 deletions(-)
> > 
> > I'm generally not fond of taking patches that touch the legacy board
> > file unless they're fixing or cleaning up something.  Since it looks
> > like a cleanup, I will probably take it.  But did you test the change on
> > hardware?
> 
> No. Unfortunately I do not have this board. Similar change I did for the
> other subarch, and it has been tested
> (https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/mach-clps711x/board-p720t.c?id=6d640edeb598dd76c64aa99357d9b59996dcb3bc).
> 
> Yes, it is mostly cleanup. The next change to this board will introduce GPIO
> regulator (based on this change) for the framebuffer, it will help to remove
> ".init" and ".exit" hooks for the imxfb driver.

Ok, fare enough.  Sascha?

Shawn
