From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 30 Jul 2015 10:33:43 +0200
Subject: [RESEND PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <20150728131253.GA4055@odux.rfo.atmel.com>
References: <20150715133048.GD14886@odux.rfo.atmel.com>
 <1438069696-25303-1-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdaiwcTzxG=KqPZxk6ijLOE0PAh9ybkNqUYhkmAcQV40eg@mail.gmail.com>
 <20150728131253.GA4055@odux.rfo.atmel.com>
Message-ID: <20150730083343.GA23018@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ludovic,

On Tue, Jul 28, 2015 at 03:12:53PM +0200, Ludovic Desroches wrote:
> On Tue, Jul 28, 2015 at 02:48:09PM +0200, Linus Walleij wrote:
> > On Tue, Jul 28, 2015 at 9:48 AM, Ludovic Desroches
> > <ludovic.desroches@atmel.com> wrote:
> > 
> > > From: David Dueck <davidcdueck@googlemail.com>
> > >
> > > Not all gpio banks are necessarily enabled, in the current code this can
> > > lead to null pointer dereferences.
> > >
> > > [   51.130000] Unable to handle kernel NULL pointer dereference at virtual address 00000058
> > (...)
> > >
> > > Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> > > Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > CC: linux-arm-kernel at lists.infradead.org
> > > CC: linux-kernel at vger.kernel.org
> > > ---
> > >
> > > This patch fixes a oops in the kernel because of a NULL pointer in a table.
> > > Having a NULL pointer in this table is the normal behavior if a PIO controller
> > > is not enabled. So this fix is not a quick and dirty hack, it's usual to skip
> > > an entry from a table if it is not filled.
> > 
> > Fair enough, better too many checks than too few.
> > 
> > Is this a regression to v4.2 that should go to stable or v4.3 material?
> 
> Yes it is a regression from v4.0, it applies well on v4.0.9
> 
> Fixes: a0b957f306fa ("pinctrl: at91: allow to have disabled gpio bank")
> Cc: stable at vger.kernel.org # 4.0

a0b957f306fa have a stable tag up to 3.18, should this patch inherit a 
stable tag up to 3.18 instead of only up to 4.0 ?

Sylvain
