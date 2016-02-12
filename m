From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Feb 2016 14:04:54 -0800
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <20160212212600.GA18872@sirena.org.uk>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <20160212212600.GA18872@sirena.org.uk>
Message-ID: <20160212220454.GF4847@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12, Mark Brown wrote:
> On Fri, Feb 12, 2016 at 09:30:17AM -0800, Stephen Boyd wrote:
> > This reverts commit 18560a4e3b07438113b50589e78532d95f907029.
> > 
> > The commit that caused us to specify LE device endianness here,
> > 29bb45f25ff3 (regmap-mmio: Use native endianness for read/write,
> > 2015-10-29), has been reverted in mainline so now when we specify
> 
> So, I applied this to -next as that's where it applies but it seems that
> you're trying to revert a commit that's in Linus' tree so should go as a
> fix to him.  Can you send a fix against Linus' tree too please?

Did you want me to send the fix directly to Linus? The patch
applies to both -next and Linus' tree, although you're right I
generated this patch against -next. If I apply it to Linus' tree
and then git format-patch it's exactly the same except for the
commit hash:

$ diff linus next
1c1
< From 4f7c654bfcd159b3068b01e3b522e8af88069cb9 Mon Sep 17 00:00:00 2001
---
> From 798212b523668d5a37a977c660554827aa0d89ed Mon Sep 17 00:00:00 2001

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
