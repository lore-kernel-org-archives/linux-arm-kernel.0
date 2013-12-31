From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 21:15:58 -0800
Subject: [PATCH v2 6/7] drm/msm: Drop unnecessary mach include
In-Reply-To: <CAF6AEGt7o65zpPPJa1chvYdp+K-dkSH9Buq=rDxyrUyS0zh3eA@mail.gmail.com>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <1388438133-431-7-git-send-email-sboyd@codeaurora.org>
 <CAF6AEGtortD9FQP-vDj7apsmdkXcoOiahJf++zPcSh=OYg7WfA@mail.gmail.com>
 <CAF6AEGt7o65zpPPJa1chvYdp+K-dkSH9Buq=rDxyrUyS0zh3eA@mail.gmail.com>
Message-ID: <20131231051558.GB14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30, Rob Clark wrote:
> On Mon, Dec 30, 2013 at 8:12 PM, Rob Clark <robdclark@gmail.com> wrote:
> > On Mon, Dec 30, 2013 at 4:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> This file doesn't use the clk_reset() API that is exposed in
> >> mach-msm's mach/clk.h file. Remove the include so that this
> >> driver can be compiled as part of the multi-platform kernel.
> >
> > Thanks!
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>

I think you mean Acked-by? Signed-off-by usually means you're
sending the patch along.

> 
> oh, fwiw, things are a bit re-arranged on msm-next-staging (to add
> 8074 and 8060a support).. currently I have:
> 
> ------------------
> #if defined(CONFIG_ARCH_MSM)
> #  include <mach/clk.h>
> #elif defined(CONFIG_COMPILE_TEST)
> /* stubs we need for compile-test: */
> static inline struct device *msm_iommu_get_ctx(const char *ctx_name)
> {
>         return NULL;
> }
> #endif
> ------------------
> 
> Not really sure what to do about msm_iommu_get_ctx(), or whether I
> still need that?
> 

I think the drm Kconfig should be selecting the MSM iommu Kconfig
symbol. At least for now, it's a direct compile time dependency
of this driver. I still don't see a use of mach/clk.h though, so
we should be able to drop it completely.

Is your msm-next-staging tree going into v3.14? I don't see
anything in linux-next so far.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
