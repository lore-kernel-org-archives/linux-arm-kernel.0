From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Feb 2013 11:46:41 -0700
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <51251A11.2030300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 12:08 AM, Shawn Guo wrote:
> This turns the imx pin function number defined by binding document
> into #define constants in header which can be used in dts and handled
> by pre-processor to improve the readability of device tree sources.

> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt

> -See below for available PIN_FUNC_ID for imx35:
> -0 MX35_PAD_CAPTURE__GPT_CAPIN1
...
> -951 MX35_PAD_TEST_MODE__TCU_TEST_MODE
> +Refer to arch/arm/boot/dts/imx35-pinfunc.h for all available imx35 PIN_FUNC_ID.

So that path is specific to the Linux kernel. The DT binding
documentation isn't supposed to be specific to the Linux kernel. I
wonder if we shouldn't put all the header files into
Documentation/devicetree/bindings rather than arch/*/boot/dts. That way,
you could encode relative path names into the DT binding docs. The
headers are logically part of the documentation anyway.

This all plays into whatever plans exist for removing the DT binding
docs and/or .dts files from the kernel, and how things will end up
getting laid out then though. That's something we should discuss with at
least Grant and Rob. I note that the DT maintainers weren't Cc'd on this
series though. I added them for this reply.

Perhaps I should just send a patch to the dtc and kernel include paths
which implements that, and see what people say.

> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt

>  See below for available PIN_FUNC_ID for imx6q:
> -MX6Q_PAD_SD2_DAT1__USDHC2_DAT1			0

You forgot to add a reference to the header filename to this file.
