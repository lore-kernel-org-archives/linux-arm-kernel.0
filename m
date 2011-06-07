From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 7 Jun 2011 09:52:21 +0200
Subject: [RFC 0/6] iommu: generic api migration and grouping
In-Reply-To: <BANLkTinx21-E3DRe9D7LRB8e1aeOwv=-9A@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<20110606100950.GC30762@amd.com>
	<BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
	<20110606153557.GE1953@amd.com>
	<BANLkTinwwVO4TmsxuTfSBf6jqYrEVV3b_A@mail.gmail.com>
	<20110606192030.GA4356@amd.com>
	<BANLkTinx21-E3DRe9D7LRB8e1aeOwv=-9A@mail.gmail.com>
Message-ID: <20110607075221.GB4407@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 04:09:33PM -0400, Ohad Ben-Cohen wrote:
> On Mon, Jun 6, 2011 at 10:20 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> > Well, it certainly makes sense to have a single implementation for this.
> > But I want to hide this complexity to the user of the IOMMU-API. The
> > best choice is to put this into the layer between the IOMMU-API and the
> > backend implementation.
> 
> I agree.
> 
> The IOMMU API should take physically contiguous regions from the user,
> split them up according to page-sizes (/alignment requirements)
> supported by the hardware, and then tell the underlying implementation
> what to map where.

Yup. Btw, is there any IOMMU hardware which supports non-natural
alignment? In this case we need to expose these requirements somehow.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
