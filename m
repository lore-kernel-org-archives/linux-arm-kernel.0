From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 24 Sep 2015 05:17:38 -0700
Subject: [PATCH v2] clk:mxs: Fix bug on frequency divider
In-Reply-To: <55FBBB6D.4010805@i2se.com>
References: <55BBB1AC.6070102@codeaurora.org>
 <1441010707-17178-1-git-send-email-victorien.vedrine@ophrys.net>
 <55FBBB6D.4010805@i2se.com>
Message-ID: <20150924121738.GP3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:21:17AM +0200, Stefan Wahren wrote:
> +Shawn's new address
> +linux-arm-kernel
> 
> > On drivers/clk/mxs/clk-frac.c, the function clk_frac_round_rate returned a bad
> > result. The division before multiplication computes a wrong value ; the
> > calculation is inverted to fix the problem. The second issue is that the exact
> > rate have decimals and they are truncate. The consequence is that the function
> > clk_frac_set_rate (which use the result of clk_frac_round_rate) computes a
> > wrong value for the register (the rate generated can be closer to the desired
> > rate). The correction is : if there is decimal to the result, it is rounded to
> > the next larger integer.
> > On drivers/clk/mxs/clk-frac.c, the function clk_frac_recalc_rate returned
> > a bad result. The multiplication is made before the division to compute a
> > correct value.
> >
> > Signed-off-by: Victorien Vedrine <victorien.vedrine@ophrys.net>

Acked-by: Shawn Guo <shawnguo@kernel.org>
