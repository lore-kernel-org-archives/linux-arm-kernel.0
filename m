From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Oct 2012 10:07:58 -0700
Subject: [PATCH] ARM: dts: imx6q-arm2: move NANDF_CS pins out of 'hog'
In-Reply-To: <20121015133516.GC24393@S2101-09.ap.freescale.net>
References: <1350290884-26594-1-git-send-email-shawn.guo@linaro.org>
 <CAMiH66EdFW7JrCD+NVtJnn-dYan0U_QyhOoRKvsQHV5g0u7pqQ@mail.gmail.com>
 <20121015133516.GC24393@S2101-09.ap.freescale.net>
Message-ID: <20121016170758.GA32415@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 09:35:20PM +0800, Shawn Guo wrote:
> On Mon, Oct 15, 2012 at 08:45:48AM -0400, Huang Shijie wrote:
> > On Mon, Oct 15, 2012 at 4:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > Commit 9e3c0066 (ARM: dts: imx6q-arm2: add pinctrl for uart and enet)
> > > defines NANDF_CS pins as gpio in 'hog', assuming these two pins are
> > > always used by usdhc3 in gpio mode as card-detection and
> > > write-protection on ARM2 board.  But it's not true.  These pins are
> > > shared by usdhc3 and gpmi-nand.  We should have the pins functional
> > > for gpmi-nand when usdhc3 is disabled.
> > >
> > > Move the pins out of 'hog', so that pins only work in gpio mode as CD
> > > and WP when usdhc3 is enabled, and otherwise they are available for
> > > gpmi-nand.
> > >
> > > Reported-by: Huang Shijie <b32955@freescale.com>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > Huang,
> > >
> > > Please help test the patch to see if it fixes your problem, thanks.
> > 
> > yes, this patch fixes the problem.
> > thanks a lot.
> > 
> > Tested-by: Huang Shijie <shijie8@gmail.com>
> > 
> Arnd, Olof,
> 
> Can you please send it for later -rc, since it fixes a regression
> in -rc1?

Done, applied to fixes and will be sent up with the next batch for
3.7-rc2.


-Olof
