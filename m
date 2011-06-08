From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 8 Jun 2011 11:35:46 +0200
Subject: [PATCH 0/4] drivers/iommu/ relocations
In-Reply-To: <1307522062-19273-1-git-send-email-ohad@wizery.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
Message-ID: <20110608093546.GG4407@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Cc'ing Ingo)

On Wed, Jun 08, 2011 at 04:34:18AM -0400, Ohad Ben-Cohen wrote:
> Create a dedicated iommu drivers folder, put the base iommu code there,
> and move the existing IOMMU API users as well (msm-iommu, amd_iommu and
> intel-iommu).
> 
> Putting all iommu drivers together will ease finding similarities
> between different platforms, with the intention of solving problems once,
> in a generic framework, which everyone can use.
> 
> OMAP's iommu will be moved too as soon as it's migrated.

Great, thanks. I'll apply the patches as soon as the relevant ACKs come
in. Looking at the MAINTAINERS file David Brown needs to ACK the MSM
patch and David Woodhouse the VT-d patch.

David B., David W., is this direction ok for both of you?

A more important question is how we handle the IOMMU tree. Currently the
situation is as follows:

	* The AMD IOMMU changes go upstream through Ingo
	* David Woohouse has his own tree which he sents directly to
	  Linus
	* Not sure about the ARM IOMMU code
	* And to comlicate things further there is the upcoming ARM
	  integration tree which may contain code that depends on IOMMU
	  changes

My suggestion is that the ARM tree pulls in the necessary changes from
the IOMMU tree and the IOMMU code goes upstream through Ingo or directly
to Linus (with some time in linux-next, of course). Thoughts?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
