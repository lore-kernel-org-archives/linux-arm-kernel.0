From: agross@codeaurora.org (Andy Gross)
Date: Thu, 17 Sep 2015 16:42:18 -0500
Subject: [PATCH v2 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
 <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
Message-ID: <20150917214218.GA6003@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 12:56:51PM -0700, Andrew Morton wrote:
> On Thu, 17 Sep 2015 12:02:08 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The SMD driver is reading and writing chunks of data to iomem,
> > and there's an __iowrite32_copy() function for the writing part, but
> > no __ioread32_copy() function for the reading part. This series
> > adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
> > case this should go through the -mm tree. Otherwise the target
> > of this patch series is SMD, so I've sent it to Andy.
> > 
> > Note this patch series relies on a previous patch on the list that
> > changes the readl() to __raw_readl() in the smd driver[1].
> 
> Well that's awkward.
> 
> "[PATCH v2 6/8] soc: qcom: smd: Handle big endian CPUs" is one patch in
> an eight-patch series.  My usual approach would be to suck in the whole
> series, stage it behind linux-next, drop patches if/when others merge
> them into subsystem trees and thus retain all the dependencies for this
> patch series in a maintainable-by-me fashion.
> 
> But that 8-patch series doesn't apply:
> 
> checking file drivers/soc/qcom/smd.c
> Hunk #6 FAILED at 360.
> Hunk #15 FAILED at 733.
> Hunk #16 FAILED at 741.
> 3 out of 19 hunks FAILED
> Failed to apply soc-qcom-smd-handle-big-endian-cpus
> 
> 
> ho hum.  I think I'll go with plan B: merge just "lib: iomap_copy: Add
> __ioread32_copy()" and send that into Linus promptly.  That way you
> guys can sort out the driver patches in the usual fashion.
> 

I just pulled in the original 8 patches and rebased.  My plans were to stage
those in linux-next through my for-next.  Then add those on top just like you
specified.  But i could go either way.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
