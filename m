From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 31 Aug 2012 11:59:39 +0100
Subject: [PATCH] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <20120831103351.GE18957@n2100.arm.linux.org.uk>
References: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
 <20120831110444.25d9b9fe@pyramind.ukuu.org.uk>
 <504091F0.1090703@parrot.com>
 <20120831103351.GE18957@n2100.arm.linux.org.uk>
Message-ID: <20120831115939.23fd4a08@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Aug 2012 11:33:51 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Aug 31, 2012 at 12:29:04PM +0200, Matthieu CASTET wrote:
> > Alan Cox a ?crit :
> > > On Fri, 31 Aug 2012 11:21:56 +0200
> > > Matthieu CASTET <castet.matthieu@free.fr> wrote:
> > > 
> > >> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
> > >> ---
> > >>  drivers/tty/hvc/hvc_dcc.c |   34 ++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 34 insertions(+)
> > > 
> > > This is a step in the wrong direction. This should all be runtime handled
> > > 
> > > NAK.
> > > 
> > 
> > AFAIK you can't build a arm kernel that support arm6/armv7 and armv5.
> > And I am not sure it will be possible one day.
> 
> There are no plans to ever make it possible; there are too many significant
> differences between ARMv4, v5 architectures and ARMv6,v7 architectures
> to warrant making this runtime selectable.

Then bury this crap in platform files please not in the drivers/tty layer
code. Make it a platform driver provided callback or something.

Alan
