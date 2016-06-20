From: briannorris@chromium.org (Brian Norris)
Date: Mon, 20 Jun 2016 09:19:09 -0700
Subject: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
In-Reply-To: <5767EB7E.3040606@ti.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <5767EB7E.3040606@ti.com>
Message-ID: <20160620161908.GA30459@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-mmc, Ulf

On Mon, Jun 20, 2016 at 06:41:26PM +0530, Kishon Vijay Abraham I wrote:
> On Friday 13 May 2016 04:13 AM, Brian Norris wrote:
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > According to the databook, 10.2us is the max time for dll to be ready to
> > work. However in testing, some chips need 20us for dll to be ready. This
> > patch adds some extra margin for dllrdy to be ready, fixing our
> > -ETIMEDOUT issues.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks! I take it that to mean you're agreeing with Doug's suggestion
here:

https://lkml.org/lkml/2016/6/13/1067

"Since [the $subject series patches] aren't in 4.7-rc1 presumably they
would also make sense to take through the MMC tree if others agree."

Ulf,

I see I didn't CC you or linux-mmc on this patch series. Please let me
know if I should resend, or if you can pick these up off of LKML -- Doug
gave nice patchwork links in his linked series. NB: patch 2 has a
version 2, while the others were left unmodified.

Regards,
Brian
