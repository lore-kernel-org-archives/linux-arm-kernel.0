From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Dec 2013 11:52:26 +0000
Subject: [PATCH 05/11] serial: support for 16550 serial ports on LP-8x4x
In-Reply-To: <1385984366.12531.24.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-6-git-send-email-ynvich@gmail.com>
 <20131202113052.GG16735@n2100.arm.linux.org.uk>
 <1385984366.12531.24.camel@host5.omatika.ru>
Message-ID: <20131202115226.GI16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 03:39:26PM +0400, Sergei Ianovich wrote:
> On Mon, 2013-12-02 at 11:30 +0000, Russell King - ARM Linux wrote:
> > On Sun, Dec 01, 2013 at 10:26:18AM +0400, Sergei Ianovich wrote:
> > > +static struct platform_device lp8x4x_device = {
> > > +	.name			= "serial8250",
> > > +	.id			= PLAT8250_DEV_ACCENT,
> > 
> > You should not re-use the enum value here.  The enum is designed as a
> > method to provide the platform devices with a unique id, not as a means
> > to identify the manufacturer or anything else like that.
> 
> Should I add a new enum?

Add a new enum.
