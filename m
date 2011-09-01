From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 1 Sep 2011 15:42:09 +0200
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <201109011531.13980.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
	<CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
	<201109011531.13980.laurent.pinchart@ideasonboard.com>
Message-ID: <20110901134209.GD16691@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 09:31:13AM -0400, Laurent Pinchart wrote:
> Hi Ohad,
> 
> On Thursday 01 September 2011 13:47:26 Ohad Ben-Cohen wrote:
> > On Wed, Aug 31, 2011 at 1:52 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > > omap3isp failures (i.e. whenever the buffer passed from userspace is not
> > > page-aligned).
> > > 
> > > Remove this limitation by rounding the address of the first page entry
> > > down, and adding the offset back to the device address.
> > 
> > Seems like the unmap paths were skipped (need to adjust the sizes in
> > the unmap path too).
> > 
> > Laurent, if it looks good to you, I'll just squash it to the original
> > patch and repost:
> 
> Do you have a tree where the current code base can be found ?

Please base your upstream-patches against

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git arm/omap

Thanks,

	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
