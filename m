From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 22 Oct 2012 16:37:40 -0700
Subject: [PATCH 09/12] tty/console: fix warnings in
 drivers/tty/serial/kgdboc.c
In-Reply-To: <50661A81.7000501@windriver.com>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-10-git-send-email-arnd@arndb.de>
 <50661A81.7000501@windriver.com>
Message-ID: <20121022233740.GA12464@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 04:45:37PM -0500, Jason Wessel wrote:
> On 09/28/2012 04:36 PM, Arnd Bergmann wrote:
> > The con_debug_leave/con_debug_enter functions are stubbed out
> > by defining them to (0), which causes harmless build warnings.
> > Using proper inline functions is the normal way to deal with
> > this.
> >
> > Without this patch, building the ARM bcm2835_defconfig results in:
> >
> > drivers/tty/serial/kgdboc.c: In function 'kgdboc_pre_exp_handler':
> > drivers/tty/serial/kgdboc.c:279:3: warning: statement with no effect [-Wunused-value]
> > drivers/tty/serial/kgdboc.c: In function 'kgdboc_post_exp_handler':
> > drivers/tty/serial/kgdboc.c:293:3: warning: statement with no effect [-Wunused-value]
> 
> 
> Thanks Arnd!
> 
> I'll put this in kgdb-next for the upcoming merge window, unless Greg pulls it into his queue first.
> 
> Acked-by: Jason Wessel <jason.wessel@windriver.com>

Feel free to take it in through your kgdb tree.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
