From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Jan 2017 12:41:09 +0530
Subject: [PATCH] mtd: nand: fsmc: remove stale non-DT probe path
In-Reply-To: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
References: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20170102071109.GD8588@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-12-16, 12:34, Linus Walleij wrote:
> The FSMC driver has an execution path and a header file in
> <linux/mtd/fsmc.h> that serves to support passing in platform
> data through board files, albeit no upstream users of this
> mechanism exist.
> 
> The header file also contains function headers for functions that
> do not exist in the kernel.
> 
> Delete this and move the platform data struct, parsing and
> handling into the driver, assume we are using OF and make the
> driver depend on OF, remove the ifdefs making that optional.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/Kconfig     |   1 +
>  drivers/mtd/nand/fsmc_nand.c | 153 ++++++++++++++++++++++++++++++++++++------
>  include/linux/mtd/fsmc.h     | 156 -------------------------------------------
>  3 files changed, 133 insertions(+), 177 deletions(-)
>  delete mode 100644 include/linux/mtd/fsmc.h

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
