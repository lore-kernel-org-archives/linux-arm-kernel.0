From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 1 Feb 2017 21:04:27 -0800
Subject: [PATCH v5 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
In-Reply-To: <1484714522-26651-3-git-send-email-baoyou.xie@linaro.org>
References: <1484714522-26651-1-git-send-email-baoyou.xie@linaro.org>
 <1484714522-26651-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170202050425.GA7360@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Bao,

On Wed, Jan 18, 2017 at 12:42:02PM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

<cut>

> +
> +	/*
> +	 * Calculate temperature
> +	 *   922	initial value of calibration cure
> +	 *   1.951	slope of calibration cure
> +	 */
> +	*temp = DIV_ROUND_CLOSEST((val - 922) * 1000, 1951);

You can describe the offset and slope using DT and avoid this to be hard
coded in your driver. Besides, if you read offset and slope from DT,
your driver will be ready for any upcoming sensor addition that you may
want to support in future, given that would required slope and offset
change, per sensor, per chip version.

Can you please check if you can move these to DT?

BR,
> -- 
> 2.7.4
> 
