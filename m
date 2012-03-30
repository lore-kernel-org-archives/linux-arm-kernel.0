From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 10:23:26 -0600
Subject: [PATCH] pinctrl: Replace list_*() with get_*_count()
In-Reply-To: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
References: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
Message-ID: <4F75DDFE.3030408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2012 11:55 PM, Viresh Kumar wrote:
> Most of the SoC drivers implement list_groups() and list_functions() routines
> for pinctrl and pinmux. These routines continue returning zero until the
> selector argument is greater than total count of available groups or functions.
> 
> This patch replaces these list_*() routines with get_*_count() routines, which
> returns the number of available selection for SoC driver. pinctrl layer will use
> this value to check the range it can choose.
> 
> This patch fixes all user drivers for this change. There are other routines in
> user drivers, which have checks to check validity of selector passed to them. It
> is also no more required and hence removed.
> 
> Documentation updated as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

This looks fine to me, so:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

One small issue to fix though: In pinctrl-tegra.c, you've removed all
the range-checkes from the ops functions, except you forgot to update
tegra_pinctrl_disable().

This is simple enough I don't think I need to test it; it doesn't
actually apply to my local tree since it conflicts with all the pinctrl
DT work I have.
