From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Fri, 02 Nov 2018 14:05:14 +0100
Subject: [PATCH v6 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
 <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <ce0a3e6bf6ef438987f3ad390c2aa1bccc75f5ea.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-02 at 00:30 +0800, Jianxin Pan wrote:
> +struct meson_sclk_div_data  mmc_clkc_div_data = {
> +       .div = {
> +               .reg_off = SD_EMMC_CLOCK,
> +               .shift   = (0),
> +               .width   = (6),
> +       },
> +       .hi = {
> +               .reg_off = 0,
> +               .shift   = 0,
> +               .width   = 0,
> +       },
> +};

Jianxin,

When replying to v5: https://patchwork.kernel.org/patch/10646723/#22288117
I think I have clearly explained that:
a. sclk needs some change you want to use it for the eMMC (not done )
b. you can't declare sclk statically like that since there is cached data in
it and this would forbib multiple instance of the controller which is not
acceptable for this pariticular controller

This is just not adressed in your series.

Also some comments from Martin about useless definition were already given on
past version.

Seeing this, I did not review the rest of series.
Please make sure you have addressed all the comments of past reviews before
reposting. It is OK to ask questions if things are unclear.

Jerome
