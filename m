From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 21 Mar 2013 11:00:32 +0100
Subject: [PATCH] i2c: s3c24xx: allow device core to setup default pin
 configuration
In-Reply-To: <1362404573-30406-1-git-send-email-thomas.abraham@linaro.org>
References: <1362404573-30406-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130321100032.GC19297@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 07:12:53PM +0530, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the call to devm_pinctrl_get_select_default can be removed. And
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is also removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> 
> Hi Heiko, Tomasz,
> 
> We have to make a choice on the path forward for pinctrl support
> on Samsung platforms. We have three cases to deal with.
> 
> A. Samsung platforms without DT support.
> B. Samsung platforms with DT support using old Samsung specific
>    gpio bindings for pin-configuration (s3c24xx and s3x64xx).
> C. Samsung platforms with DT support using using pinctrl based
>    pin-configurations (Exynos4 and Exynos5).
> 
> For [A], we just let the platform specific callbacks handle the
> pin setup. For [B] and [C], based on Linus Walleij's pin grab
> by device core patch and subsequent discussions with him on the
> mailing list, would it be acceptable that we discontinue support
> for [B] in Samsung SoC device drivers. This will impact your
> current DT work on s3c24xx and s3c64xx platforms. Pinctrl is
> inevitable and we have to migrate to it. Instead of workarounds
> to maintain support for [B], it might be better that we migrate
> s3c24xx and s3c64xx platforms to pinctrl.
> 
> Please do let us know your opinion on this.

Dropping [B] sounds good, but I think it makes sense to wait with this
patch until pinctrl support for s3c24xx is in place?
