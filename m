From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 3 Dec 2013 22:53:47 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14
In-Reply-To: <CAOesGMgexET170EJ5jOoXiV1xQ+K-tngFWydxiKW4zT_WGuuqA@mail.gmail.com>
References: <20131201211341.GX2879@titan.lakedaemon.net>
 <CAOesGMgexET170EJ5jOoXiV1xQ+K-tngFWydxiKW4zT_WGuuqA@mail.gmail.com>
Message-ID: <20131204035347.GI29282@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 07:17:02PM -0800, Olof Johansson wrote:
> On Sun, Dec 1, 2013 at 1:13 PM, Jason Cooper <jason@lakedaemon.net> wrote:
...
> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> >
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14
> >
> > for you to fetch changes up to bd22bb23919e6727967e90eb89bb41ab790bcd2d:
> >
> >   ARM: Dove: Add RTC interrupt via PMU interrupt controller. (2013-11-26 16:10:49 +0000)
> >
> > ----------------------------------------------------------------
> > mvebu DT changes for v3.14
> >
> >  - mvebu:
> >     - remove unneeded OS-specific properties from led nodes
> >     - add NAND controller to Armada boards
> >     - add sata leds to readynas 104
> >     - add gpio-poweroff to readynas duo v2
> >
> >  - kirkwood:
> >     - comment cleanup in sheevaplug files
> >     - default pinctrl for sdio
> >     - sdio in guruplug is non-removable
> >
> >  - orion5x:
> >     - typo fix
> >
> >  - dove:
> >     - typo fix
> >     - add PMU interrupt controller and RTC interrupt via same
> >
> > ----------------------------------------------------------------
> > Andrew Lunn (2):
> >       ARM: Dove: Add DT node for PMU interrupt controller.
> 
> This one produces a boot time warning on dove now:
> 
> [    0.049752] irq: no irq domain found for /mbus/internal-regs/pmu-interrupt-ctrl at d0050 !

Well, that wasn't supposed to happen.  :)  Shouldn't the of_ code handle
nodes with missing drivers better?

The driver for this node is currently sitting in mvebu/irqchip.  A pull
request has been sent to Thomas*.  If you'd like to give it a spin:

   git://git.infradead.org/linux-mvebu.git tags/mvebu-irqchip-3.14

If merging that in works, then it looks like we have things set up for
an out-of-tree dependency.

thx,

Jason.

* This was arranged recently to help him out with patch wrangling.
