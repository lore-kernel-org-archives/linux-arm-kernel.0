From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Aug 2017 19:57:19 +0100
Subject: [RESEND PATCH 2/3] regulator: Add support for stm32-vrefbuf
In-Reply-To: <1503925133-30722-3-git-send-email-fabrice.gasnier@st.com>
References: <1503925133-30722-1-git-send-email-fabrice.gasnier@st.com>
 <1503925133-30722-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170829185719.h5fxvzmxbysyxwml@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 02:58:52PM +0200, Fabrice Gasnier wrote:

> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clk prepare failed\n");

If you're printing an error include the error code, it'll help users
figure out what went wrong.

> +	dev_info(&pdev->dev, "STM32 VREFBUF initialized\n");

This is just noise, remove it.

> +static int __init stm32_vrefbuf_init(void)
> +{
> +	return platform_driver_register(&stm32_vrefbuf_driver);
> +}
> +subsys_initcall(stm32_vrefbuf_init);

Why is this at subsys_initcall()?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170829/526be2b5/attachment.sig>
