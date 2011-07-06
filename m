From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jul 2011 23:28:53 -0600 (MDT)
Subject: [PATCH v2 4/5] OMAP4: clock data: Keep GPMC clocks always enabled
	and hardware managed
In-Reply-To: <1309552060-4547-5-git-send-email-b-cousson@ti.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
	<1309552060-4547-5-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107052321590.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> On OMAP4, CPU accesses on unmapped addresses are redirected to GPMC by
> L3 interconnect. Because of CPU speculative nature, such accesses are
> possible which can lead to indirect access to GPMC and if it's clock is
> not running, it can result in hang/abort on the platform.
> 
> Above makes access to GPMC unpredictable during the execution, so it's
> module mode needs to be kept under hardware control instead of software
> control.
> Since the auto gating is supported for GPMC, there isn't any power impact
> because of this change.
> 
> The issue was un-covered with security middleware running along with HLOS.
> In this case GPMC had a valid MMU descriptor on secure side where as HLOS
> didn't map the GMPC because it isn't being used.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [b-cousson at ti.com: Update subject and fix typos in the changelog]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'hardware_workarounds_3.1' branch.


- Paul
