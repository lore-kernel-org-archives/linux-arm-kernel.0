From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 23 Feb 2011 00:20:59 +0000
Subject: [PATCH v2] i2c: tegra: Add i2c support
In-Reply-To: <1298250861-27094-1-git-send-email-ccross@android.com>
References: <AANLkTim0X=gUwYJmR+EAYjGamiJb7tgiVEjwqCEF0-L0@mail.gmail.com>
	<1298250861-27094-1-git-send-email-ccross@android.com>
Message-ID: <20110223002059.GV15795@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 05:14:21PM -0800, Colin Cross wrote:
> Adds I2C bus driver for nVidia Tegra SoCs.  Tegra includes 4 I2C
> controllers, one of which is inside the Dynamic Voltage Controller
> and has a slightly different register map.
> 
> Signed-off-by: Colin Cross <ccross@android.com>

Would have been helpful to start a new thread, missed this the first time
around.

> +	i2c_dev = kzalloc(sizeof(struct tegra_i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev) {

no error print here.

> +		ret = -ENOMEM;
> +		goto err_i2c_clk_put;
> +	}

> +	if (pdev->id == 3)
> +		i2c_dev->is_dvc = 1;
> +	init_completion(&i2c_dev->msg_complete);

you might want to think about having a seperate platform bus name for
this case, and switching the is_dvc field on that. It'll make life much
easier if someone decides that what the next tegra i2c needs is 5 i2c
controllers.

I'll consider putting this (as is) into the -next tree, but would like
to see the issues with readsl/writesl sorted out and any other review
comments sorted.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
