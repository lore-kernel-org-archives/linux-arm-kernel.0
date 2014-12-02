From: balbi@ti.com (Felipe Balbi)
Date: Mon, 1 Dec 2014 19:51:18 -0600
Subject: [PATCH] tty: serial: serial-omap: depend on !8250_omap
In-Reply-To: <20141201231338.GA14524@fuloong-minipc.musicnaut.iki.fi>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
 <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
 <20141201231338.GA14524@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <20141202015118.GA1891@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 01:13:38AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Dec 01, 2014 at 02:09:14PM +0000, One Thousand Gnomes wrote:
> > > Well the nightmare userspace switch from ttyS to ttyO few years ago is
> > > something we want to avoid.. I think the best solution would be to make
> > > serial-omap.c transparently provide support for ttyO using the new 8250
> > > code so both ttyS and ttyO devices would just work. Otherwise it will
> > > be years of "my serial port stopped working" questions again.
> > 
> > Thata a udev problem not a kernel one surely.
> 
> People also use serial console to observe the early kernel boot before
> the userspace is started.

right, we need a way to tell the kernel that ttyO%d and ttyS%d are the
exact same device so that console=ttyO0 and console=ttyS0 mean the same
thing. That maintains backwards compatibility and lets people move on

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/4f5fda27/attachment.sig>
