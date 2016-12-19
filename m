From: sr@denx.de (Stefan Roese)
Date: Mon, 19 Dec 2016 07:15:15 +0100
Subject: [PATCH] mtd: nand: fsmc: remove stale non-DT probe path
In-Reply-To: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
References: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <417a2f4f-7ef0-72c9-fa9c-223b40c0bda3@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.12.2016 12:34, Linus Walleij wrote:
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

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
