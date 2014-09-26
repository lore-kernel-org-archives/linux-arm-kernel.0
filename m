From: dianders@chromium.org (Doug Anderson)
Date: Fri, 26 Sep 2014 13:03:24 -0700
Subject: [PATCH v4 6/8] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <1411757591-16142-7-git-send-email-heiko@sntech.de>
References: <1411757591-16142-1-git-send-email-heiko@sntech.de>
 <1411757591-16142-7-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=WNF6F497kY3y4=9ntRLwKFYRQNi3GqBZLTMPQKdCS3QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Sep 26, 2014 at 11:53 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> +struct clk *rockchip_clk_register_cpuclk(const char *name,
> +                       const char **parent_names, u8 num_parents,
> +                       const struct rockchip_cpuclk_reg_data *reg_data,
> +                       struct rockchip_cpuclk_rate_table *rates, int nrates,

It would be nice if this was "const struct rockchip_cpuclk rate_table
*rates" here and elsewhere.  It's OK if we make it const here even if
we can't figure out how to make the tables "initconst".

...but it sure seems like that could happen in a followup patch, so:

Reviewed-by: Doug Anderson <dianders@chromium.org>

On a rk3288-board:

Tested-by: Doug Anderson <dianders@chromium.org>
