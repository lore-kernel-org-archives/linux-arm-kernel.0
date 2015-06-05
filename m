From: atull@opensource.altera.com (atull)
Date: Fri, 5 Jun 2015 09:11:23 -0500
Subject: [PATCHv6 0/2] socfpga: support suspend to ram*
In-Reply-To: <CADhT+wc+w6QvUmtD_ie2_hfb_uowpfwM0YHDeasXE86MKOjA8A@mail.gmail.com>
References: <1433270139-7042-1-git-send-email-atull@opensource.altera.com>
 <556E028E.2080800@opensource.altera.com>
 <5570D29A.2030007@opensource.altera.com>
 <CADhT+wc+w6QvUmtD_ie2_hfb_uowpfwM0YHDeasXE86MKOjA8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1506050910460.20527@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jun 2015, Dinh Nguyen wrote:

> On Thu, Jun 4, 2015 at 5:35 PM, Dinh Nguyen
> <dinguyen@opensource.altera.com> wrote:
> > Hi Alan,
> >
> > On 06/02/2015 02:22 PM, Dinh Nguyen wrote:
> >> On 06/02/2015 01:35 PM, Alan Tull wrote:
> >>> Support suspend to ram on socfpga.
> >>>   * allocate space in ocram using sram driver.
> >>>   * Add a function in ocram to place DDR in self-refresh
> >>>     and suspend.
> >>>   * Prevent suspend if EDAC is enabled.
> >>>   * Add a device tree binding document for the Altera
> >>>     SOCFPGA SDRAM controller that is used to put DDR in
> >>>     self-refresh mode.
> >>>
> >>> Alan Tull (2):
> >>>   ARM: socfpga: support suspend to ram
> >>>   ARM: socfpga: dts: add sdram controller dt binding doc
> >>>
> >>>  .../arm/altera/socfpga-sdram-controller.txt        |   12 ++
> >>>  arch/arm/mach-socfpga/Kconfig                      |   10 +-
> >>>  arch/arm/mach-socfpga/Makefile                     |    1 +
> >>>  arch/arm/mach-socfpga/core.h                       |    6 +-
> >>>  arch/arm/mach-socfpga/pm.c                         |  149 ++++++++++++++++++++
> >>>  arch/arm/mach-socfpga/self-refresh.S               |  136 ++++++++++++++++++
> >>>  arch/arm/mach-socfpga/socfpga.c                    |    6 +-
> >>>  drivers/edac/altera_edac.c                         |   20 +++
> >>>  8 files changed, 337 insertions(+), 3 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> >>>  create mode 100644 arch/arm/mach-socfpga/pm.c
> >>>  create mode 100644 arch/arm/mach-socfpga/self-refresh.S
> >>>
> >>
> >>
> >> Applied.
> >>
> >
> > I had to un-apply this patch because I noticed that it's touching
> > drivers/edac/altera_edac.c. This part should be a separate patch and
> > need to go through linux-edac.
> >
> 
> Nevermind on this, I got an ack-by from Borislav Petkov for the edac
> part. No need to split the patch up.
> 
> Dinh
> 

Sorry for the trouble and Thanks!

Alan
