From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 May 2012 13:22:29 +0100
Subject: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
In-Reply-To: <20120502121222.GZ2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
 <20120501134446.GK2194@S2101-09.ap.freescale.net>
 <20120502105024.GC2982@b20223-02.ap.freescale.net>
 <20120502114121.GB5722@opensource.wolfsonmicro.com>
 <20120502121222.GZ2194@S2101-09.ap.freescale.net>
Message-ID: <20120502122228.GC5722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 08:12:24PM +0800, Shawn Guo wrote:
> On Wed, May 02, 2012 at 12:41:22PM +0100, Mark Brown wrote:

> > The major problem here is that we can't rely on having the clock API
> > present at all on most platforms so as soon as we start adding clock
> > support into things we have to do a performance with HAVE_CLK which is
> > at best annoying.

> Is this something that the series below tries to solve?

> http://thread.gmane.org/gmane.linux.ports.arm.kernel/163652

Well, it helps building but that's only part of the issue - we've still
got registration problems and if we were using the API in anger we would
need things like clk_set_rate() to actually work.  It's not just a case
of simply enabling and disabling clocks (which can be stubbed out pretty
effectively), audio generally needs to manage the clock rates too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120502/2be059fb/attachment.sig>
