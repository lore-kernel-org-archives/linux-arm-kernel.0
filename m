From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 17 Jan 2018 17:47:34 -0600
Subject: [PATCH v3] firmware: qcom: scm: Fix incorrect of_node_put calls
 in scm_init
In-Reply-To: <20180116164549.GE478@tuxbook>
References: <1513345214-22835-1-git-send-email-lollivier@baylibre.com>
 <20180116164549.GE478@tuxbook>
Message-ID: <20180117234734.GA4402@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 08:45:49AM -0800, Bjorn Andersson wrote:
> On Fri 15 Dec 05:40 PST 2017, Loys Ollivier wrote:
> 
> > When using other platform architectures, in the init of the qcom_scm
> > driver, of_node_put is called on /firmware if no qcom dt is found.
> > This results in a kernel error: Bad of_node_put() on /firmware.
> > 
> > These calls to of_node_put from the qcom_scm init are unnecessary as
> > of_find_matching_node and of_platform_populate are calling it
> > automatically.
> > 
> > Remove the calls to of_node_put() on fw_np.
> > 
> > Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
> > Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> 
> Hi Loys,
> 
> Your patch is correct! We are however removing all this logic from
> qcom_scm_init() in v4.16.
> 
> See:
> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/commit/?h=for-next&id=3aa0582fdb824139630298880fbf78d4ac774d3c
> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/commit/?h=for-next&id=3aa0582fdb824139630298880fbf78d4ac774d3c


Yeah sorry for the delay in response.  I pulled in the second part of a separate
fix that removes all that code from the qcom_scm.  It made more sense to do it
automatically from the base code.

Andy
