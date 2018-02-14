From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Feb 2018 13:17:45 +0200
Subject: [PATCH v2 1/2] arm64: dts: marvell: add CP110 uart peripherals
In-Reply-To: <20180214110750.GP9418@n2100.armlinux.org.uk>
References: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
 <87vaezonrn.fsf@bootlin.com>
 <20180214105653.r4hcdxgbdmth3d7a@tarshish>
 <20180214110750.GP9418@n2100.armlinux.org.uk>
Message-ID: <20180214111745.6lelfxrj5wutqzne@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ressell,

On Wed, Feb 14, 2018 at 11:07:51AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 14, 2018 at 12:56:53PM +0200, Baruch Siach wrote:
> > On Wed, Feb 14, 2018 at 11:42:52AM +0100, Gregory CLEMENT wrote:
> > >  On mer., janv. 31 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > > 
> > > > The CP110 component has 4 uart peripherals. All of them use the same clock
> > > > gate for slow peripherals that is shared with the i2c and spi peripherals.
> > > >
> > > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > 
> > > Applied on mvebu/dt64
> > 
> > Thanks.
> > 
> > What about patch 2/2 in this series?
> 
> I'm not entirely convinced that it's something that should be done.
> I know that some people are already using the UART headers for other
> purposes (other than UART) and the later revision boards have the
> placement of the microUSB fixed so it is accessible.
> 
> While you can tell Linux to use the other UART headers with this
> patch, uboot won't use them, which means you can't configure the
> boot loader without (in your case) taking the board out of the case.
> 
> I've a similar problem (with the mcbin in a rackmount case), and my
> solution to that has been to put a single washer under the mounting
> post near the microUSB to lift the board sufficiently to allow a
> connector to be plugged in.  Sometimes simple hardware fixes are
> better than software fixes.
> 
> Others have used a dremel to modify the case to access the microUSB.

Just for the record, I'm fine with dropping 'status = "okay"' from the mcbin 
CP{0,1} UART nodes. This would still allow anyone who needs this functionality 
to enable it with a simple .dts modification, or a run-time dtb modification 
from the bootloader.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
