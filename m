From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 23 Aug 2012 11:12:46 +0300
Subject: [PATCH v3 5/9] ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux
 configuration code
In-Reply-To: <20120822191506.GL7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
 <20120822191506.GL7995@opensource.wolfsonmicro.com>
Message-ID: <5035E5FE.90401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/22/2012 10:15 PM, Mark Brown wrote:
> Applied but this didn't quite apply cleanly, please check that it did so.

The part which removes the omap_mcbsp_6pin_src_mux() function from
sound/soc/omap/mcbsp.c is the one which did not made it.

It failed to apply on top of topic/omap is that the branch does not have the
following commit:
d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration

This patch is in your for-next branch. I can not find it in the for-3.6 or
for-3.7 branch either.

Commit d0db84e was planed to be part of 3.6 AFAIK. Without that patch in
topic/omap we are going to have merge issue with 3.7.

I can send a patch which removes the omap_mcbsp_6pin_src_mux() in topic/omap
but the patch will similarly fail when we going to have d0db84e already
applied mainline.

-- 
P?ter
