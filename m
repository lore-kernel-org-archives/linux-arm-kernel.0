From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 23:44:35 +0100
Subject: [PATCH v5 1/2] i2c: qup: Add device tree bindings information
In-Reply-To: <1394762863-12154-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140328224435.GA29200@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 07:07:42PM -0700, Bjorn Andersson wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
> provide input and output FIFO's for it. I2C controller can operate
> as master with supported bus speeds of 100Kbps and 400Kbps.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> [bjorn: reformulated part of binding description
>         added version to compatible
>         cleaned up example]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

...

> + i2c at f9924000 {
> + 	compatible = "qcom,i2c-qup-v2.2.1";
> + 	reg = <0xf9924000 0x1000>;
> + 	interrupts = <0 96 0>;
> +
> + 	clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> + 	clock-names = "core", "iface";
> +
> + 	clock-frequency = <355000>;
> +
> + 	#address-cells = <1>;
> + 	#size-cells = <0>;
> +
> + 	dummy at 60 {
> + 		compatible = "dummy";
> + 		reg = <0x60>;
> + 	};
> + };

Removed the dummy child node (confusing example) and Applied to
for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/6b277826/attachment-0001.sig>
