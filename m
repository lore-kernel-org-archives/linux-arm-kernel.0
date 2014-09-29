From: zhangfei.gao@linaro.org (zhangfei)
Date: Mon, 29 Sep 2014 20:49:22 +0800
Subject: [PATCH v2 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <1411878129-19743-3-git-send-email-zhangfei.gao@linaro.org>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
 <1411878129-19743-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <54295552.2020501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/28/2014 12:22 PM, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei@huawei.com>
>
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>
> Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/i2c/busses/Kconfig       |   10 +
>   drivers/i2c/busses/Makefile      |    1 +
>   drivers/i2c/busses/i2c-hix5hd2.c |  554 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 565 insertions(+)
>   create mode 100644 drivers/i2c/busses/i2c-hix5hd2.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..ba0f43c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -77,6 +77,16 @@ config I2C_AMD8111
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-amd8111.
>
> +config I2C_HIX5HD2
> +	tristate "Hix5hd2 high-speed I2C driver"
> +	depends on ARCH_HIX5HD2

Would like to remove the dependence in next version to enable compile-test.
The commit 4c255791ffd6410f ("asm-generic: io: implement relaxed 
accessor macros as conditional wrappers") adds wrappers to asm-generic 
of {read,write}{b,w,l,q}_relaxed.

Thanks
