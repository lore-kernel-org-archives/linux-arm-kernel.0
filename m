From: prem.mallappa@broadcom.com (Prem (Premachandra) Mallappa)
Date: Sat, 19 Dec 2015 04:47:30 +0000
Subject: [PATCH v2 1/2] IOMMU: arm-smmu-v3: Fix broken STE.VALID check
 in Broadcom Vulcan
In-Reply-To: <20151217114216.GB11456@arm.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
 <20151217114216.GB11456@arm.com>
Message-ID: <CC0BC9CB4553B146B290EC1D4DC5C35901096047@SJEXCHMB15.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, 

> 
> Is this workaround only needed for bypass STEs? If not, we have a problem
> when we install a stage-1 entry, because we'll clear the EATS bits as it stands.
>

Yes, this _was_ needed only in Bypass STEs, AFAIK.
However, the h/w fixes that were committed recently has this worked out. 
I have tested and confirmed this patch is no longer necessary. We'll drop this series as STE.VALID is not broken anymore :).

Cheers,
/Prem
