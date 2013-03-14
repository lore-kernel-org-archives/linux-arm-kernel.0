From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 09:09:21 +0000
Subject: [PATCH v4 2/5] clk: hi3xxx: add clock support
In-Reply-To: <1363245584-24488-3-git-send-email-haojian.zhuang@linaro.org>
References: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
 <1363245584-24488-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303140909.21267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Haojian Zhuang wrote:
> 
> Add clock support with device tree on Hisilicon SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Looks good to me, just one final comment from my side:

> +
> +static struct hs_clk hs_clk;
> +
> +static void __init hs_init_clocks(void);
> +

Please move the hs_init_clocks() function itself to the top of the file to
avoid the forward declaration.

	Arnd
