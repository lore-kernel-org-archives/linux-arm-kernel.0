From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 12:50:38 +0000
Subject: [PATCH] arm64: qcom: enable GPIOLIB in Kconfig
In-Reply-To: <20161021175608.19073-1-michael.scott@linaro.org>
References: <20161021175608.19073-1-michael.scott@linaro.org>
Message-ID: <20161030125038.qp55gvscygvdiiym@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 10:56:08AM -0700, Michael Scott wrote:
> While debugging a kernel image size issue, I discovered that if all
> non ARCH_QCOM configs in the ARM64 defconfig are disabled, the QCOM
> pinctrl drivers will not be built.
> 
> The QCOM pinctrl drivers have a dependency on GPIOLIB which was being
> selected when other ARCH configs were enabled, but ARCH_QCOM doesn't
> select GPIOLIB directly.  Let's select GPIOLIB here to ensure the pinctrl
> drivers are built for QCOM platforms.
> 
> Signed-off-by: Michael Scott <michael.scott@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms | 1 +

Such patches are normally handled by arm-soc (cc'ed).

-- 
Catalin
