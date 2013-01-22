From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Jan 2013 08:54:55 -0200
Subject: [PATCH 06/15] clk: export __clk_get_name
In-Reply-To: <1358788568-11137-7-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-7-git-send-email-arnd@arndb.de>
Message-ID: <CAOMZO5AON+FhTQpTbEdjwZaEaxsPoEVLeALhH2s34biWH_EeOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 3:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The __clk_get_name is used by drivers that provide their
> own clocks, which have traditionally all been built-in.
> The new imx drm driver however provides clocks but can
> be built as a module, so we need to export __clk_get_name.
>
> While this is only a staging driver, it's likely that
> there will be others like it in the future.
>
> Without this patch, building ARM allmodconfig results in:
>
> ERROR: "__clk_get_name" [drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.ko] undefined!
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mike Turquette <mturquette@linaro.org>

A fix from Niels de Vos has already been applied into clk-next:
https://patchwork.kernel.org/patch/1871981/
