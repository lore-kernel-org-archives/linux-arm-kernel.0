From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 May 2016 13:17:18 -0300
Subject: [PATCH v2 2/2] nvmem: mxs-ocotp: remove nvmem regmap dependency
In-Reply-To: <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462202578-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1462202578-15433-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAOMZO5A5JbJV00AsxfqkAsPPR=gB81gobhU4t-+HSX07Q=bCZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 2, 2016 at 12:22 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

>  static const struct of_device_id mxs_ocotp_match[] = {
> -       { .compatible = "fsl,imx23-ocotp", .data = &imx23_access },
> -       { .compatible = "fsl,imx28-ocotp", .data = &imx28_access },
> +       { .compatible = "fsl,imx23-ocotp", .data = &imx23_data },
> +       { .compatible = "fsl,imx28-ocotp", .data = &imx23_data },

This should &imx28_data.
