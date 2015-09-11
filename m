From: agross@codeaurora.org (Andy Gross)
Date: Fri, 11 Sep 2015 14:20:03 -0500
Subject: [PATCH] firmware: qcom: scm: Add function stubs for ARM64
In-Reply-To: <20150911175649.GZ21084@n2100.arm.linux.org.uk>
References: <1441993856-30178-1-git-send-email-agross@codeaurora.org>
 <20150911175649.GZ21084@n2100.arm.linux.org.uk>
Message-ID: <20150911192003.GB32107@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 06:56:49PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 11, 2015 at 12:50:56PM -0500, Andy Gross wrote:
> > This patch adds stubs for the SCM functions exposed in the QCOM SCM API.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  drivers/firmware/Makefile      |    4 +++
> >  drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >  create mode 100644 drivers/firmware/qcom_scm-64.c
> > 
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 4a4b897..2f810c2 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -12,8 +12,12 @@ obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
> >  obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
> >  obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
> >  obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
> > +ifdef CONFIG_ARM64
> > +obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-64.o
> > +else
> >  obj-$(CONFIG_QCOM_SCM)		+= qcom_scm-32.o
> >  CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
> > +endif
> 
> Can we not start doing stuff like this.  Use the Kconfig to control what
> you build, not the Makefile system.
> 
> config QCOM_SCM_32
> 	def_bool y
> 	depends on QCOM_SCM && ARM
> 
> config QCOM_SCM_64
> 	def_bool y
> 	depends on QCOM_SCM && ARM64
> 
> and then use those in the makefile.

That's a fair implementation.  There is going to be a bit of work
going into getting the 64 bit SCM un-stubbed.  So I can respin to incorporate
your comments or we can wait for the unstubbing.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
