From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 18 Apr 2011 10:56:06 +0300
Subject: [PATCH V2 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <4DABE8FE.5040300@parrot.com>
References: <1302938249-4601-1-git-send-email-mnalajal@codeaurora.org>
	<4DABE8FE.5040300@parrot.com>
Message-ID: <1303113366.2815.31.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-18 at 09:32 +0200, Matthieu CASTET wrote:
> Hi,
> 
> Murali Nalajala a ?crit :
> > Add initial msm nand driver support for Qualcomm MSM platforms.
> > This driver is capable of handling both 2k and 4k page support
> > nand devices.
> > 
> > This driver was originally developed by Arve Hj?nnev?g at google.
> > Its source is available at
> > http://android.git.kernel.org/?p=kernel/msm.git under
> > android-msm-2.6.35 branch.
> > 
> > CC: Dima Zavin <dima@android.com>
> > CC: Brian Swetland <swetland@google.com>
> > CC: Arve Hj?nnev?g <arve@android.com>
> > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > ---
> > Changes in V2
> > * Turn most of the pr_info() calls into pr_debug().
> > 
> >  drivers/mtd/devices/Kconfig    |   11 +
> >  drivers/mtd/devices/Makefile   |    1 +
> >  drivers/mtd/devices/msm_nand.c | 1597 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/devices/msm_nand.h |   77 ++
> >  4 files changed, 1686 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/mtd/devices/msm_nand.c
> >  create mode 100644 drivers/mtd/devices/msm_nand.h
> > 
> 
> For the record, I am not sure it is a great idea to make nand drivers
> independent of the nand layer.

This is not acceptable. Nand drivers should use the nand_base framework.
If the framework is limiting, buggy, slow, etc for your case (which is
quite possible) - the framework should be improved.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
