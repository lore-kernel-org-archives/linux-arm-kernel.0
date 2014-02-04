From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 17:07:46 +0000
Subject: [PATCH 08/17] spi: pl022: Fully gate clocks at request inactivity
In-Reply-To: <1391529538-21685-9-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-9-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140204170746.GD22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:49PM +0100, Ulf Hansson wrote:
> Use clk_disable_unprepare and clk_prepare_enable from the runtime PM
> callbacks, to fully gate|ungate clocks. Potentially this will save more
> power, depending on the clock tree for the current SOC.

The same patch has already been applied (I noticed and fixed it while
doing unrelated code review).

>  	pinctrl_pm_select_default_state(dev);
> -	clk_enable(pl022->clk);
> +	clk_prepare_enable(pl022->clk);

Someone should really make this check errors though!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/c63f5f55/attachment.sig>
