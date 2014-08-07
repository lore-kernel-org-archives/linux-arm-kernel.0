From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 16:23:46 +0200
Subject: [PATCH v2 06/11] pwm: sti: Add new driver for ST's PWM IP
In-Reply-To: <1405348412-7352-7-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <1405348412-7352-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20140807142344.GA11095@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:33:27PM +0100, Lee Jones wrote:
[...]
> +static int sti_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	pc->clk = of_clk_get_by_name(np, "pwm");

This didn't compile because the np variable isn't declared. It was easy
to fix up, so I did, but please be more careful next time that the
patches you submit at least compile (preferably without sparse warnings
of which I also fixed up a couple).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/7d1ba92b/attachment.sig>
