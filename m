From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Mon, 5 Dec 2011 16:18:00 +0100
Subject: [RFC 0/5] OMAP groundwork for IOMMU-based DMA API
In-Reply-To: <CAK=WgbY18K00DRcmP56+UJrmMu5h_O=GaO+i_GzbC5SzCvrnRA@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <20111115103926.GA5627@amd.com>
 <CAK=WgbY18K00DRcmP56+UJrmMu5h_O=GaO+i_GzbC5SzCvrnRA@mail.gmail.com>
Message-ID: <20111205151800.GD25178@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 04:21:21PM +0200, Ohad Ben-Cohen wrote:
> Hi Joerg,
> 
> On Tue, Nov 15, 2011 at 12:39 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> > On Sun, Sep 25, 2011 at 06:58:52AM -0400, Ohad Ben-Cohen wrote:
> >> Ohad Ben-Cohen (5):
> >> ? ARM: dev_archdata: add private iommu extension
> >> ? ARM: OMAP: omap_device: add a method to set iommu private archdata
> >> ? ARM: OMAP: iommu: declare a private iommu binding struct
> >> ? ARM: OMAP3: bind omap3isp_device to its iommu device
> >> ? iommu/omap: eliminate the public omap_find_iommu_device() method
> >
> > It doesn't apply cleanly, can you please rebase the code, collect the
> > Acked-by's and resend?
> 
> I have collected Tony's and Laurent's Acked-by's and amended them to
> the commit logs.
> 
> I have also made sure it applies cleanly to a recent 3.2, and tested
> it with OMAP4/remoteproc. I couldn't test it with omap3isp though,
> because I'm gated by (what looks like a) 3.2 omap3isp regression (see
> http://www.spinics.net/lists/linux-omap/msg60510.html). I did test it
> of course with omap3isp and 3.1, so I don't expect any omap3isp/iommu
> issues with these patches. Anyway, when the omap3isp issue will be
> resolved I'll make sure there isn't any iommu regression.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> 
>   Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/ohad/linux.git for-joerg
> 
> Ohad Ben-Cohen (3):
>       ARM: OMAP: iommu: declare a private iommu binding struct
>       ARM: OMAP3: bind omap3isp_device to its iommu device
>       iommu/omap: eliminate the public omap_find_iommu_device() method
> 
>  arch/arm/mach-omap2/devices.c           |    7 ++++
>  arch/arm/plat-omap/include/plat/iommu.h |   31 +++++++++++++++--
>  arch/arm/plat-omap/include/plat/iovmm.h |   12 +++---
>  drivers/iommu/omap-iommu.c              |   58 ++++++++++++++-----------------
>  drivers/iommu/omap-iovmm.c              |   31 +++++++++++------
>  drivers/media/video/omap3isp/isp.c      |   30 +++-------------
>  drivers/media/video/omap3isp/isp.h      |    2 -
>  drivers/media/video/omap3isp/ispccdc.c  |   18 +++++-----
>  drivers/media/video/omap3isp/ispstat.c  |    8 ++--
>  drivers/media/video/omap3isp/ispvideo.c |    4 +-
>  10 files changed, 107 insertions(+), 94 deletions(-)

Pulled into arm/omap, thanks Ohad.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
