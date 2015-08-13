From: sricharan@codeaurora.org (Sricharan)
Date: Thu, 13 Aug 2015 12:07:59 +0530
Subject: [PATCH 4/5] iommu/msm: Set cacheability attributes without tex
 remap
In-Reply-To: <20150812145346.GH23540@arm.com>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
 <1439390869-6347-5-git-send-email-sricharan@codeaurora.org>
 <20150812145346.GH23540@arm.com>
Message-ID: <000201d0d592$9ce1a740$d6a4f5c0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Will Deacon
> Sent: Wednesday, August 12, 2015 8:24 PM
> To: Sricharan R
> Cc: devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> joro at 8bytes.org; robdclark at gmail.com; iommu at lists.linux-foundation.org;
> srinivas.kandagatla at linaro.org; laurent.pinchart at ideasonboard.com;
> treding at nvidia.com; Robin Murphy; linux-arm-kernel at lists.infradead.org;
> stepanm at codeaurora.org
> Subject: Re: [PATCH 4/5] iommu/msm: Set cacheability attributes without
tex
> remap
> 
> On Wed, Aug 12, 2015 at 03:47:48PM +0100, Sricharan R wrote:
> > The cacheablity attributes are set when IOMMU_CACHE property is true.
> > So cachebility is set as either noncached (normal) or cached (normal
> > WBWA) directly and avoid setting using tex remap.
> 
> Does this IOMMU support the ARMv7 short descriptor format? If so, would it
> work with Yong's patch here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-
> August/361615.html
> 
> I've not gotten around to reviewing the latest version yet, but having
other
> IOMMUs consolidate on one set of page table code would be a good thing.

     Yes, this is ARMv7 short descriptor complaint. I will rebase the next
one the
     above. That should reduce more code in this driver. Thanks.

Regards,
  Sricharan
