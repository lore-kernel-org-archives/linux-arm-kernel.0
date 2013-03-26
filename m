From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Mar 2013 16:48:48 -0300
Subject: [PATCH] ARM: imx: replace width with mask for clk_busy_mux
In-Reply-To: <1364326685-8545-1-git-send-email-mturquette@linaro.org>
References: <1364326685-8545-1-git-send-email-mturquette@linaro.org>
Message-ID: <CAOMZO5DqArX_gC-n=qkgZQSKhr_7eBoFRgFTZP1He8KcuucbKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Mar 26, 2013 at 4:38 PM, Mike Turquette <mturquette@linaro.org> wrote:
> The recent addition of table-based parent lookups[1] in the common
> clk_mux implementation removed the width member of struct clk_mux and
> replaced it with an arbitrary mask.  This broke compilation for i.MX
> platforms using clk_busy_mux which builds upon the common clk_mux.
>
> Fixed by populating the mask member during clk_busy_mux registration
> instead of the now non-existent width member.
>
> [1] http://article.gmane.org/gmane.linux.ports.tegra/10028
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>

I sent the same fix earlier today:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/226143
