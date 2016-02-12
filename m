From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Feb 2016 14:08:16 -0800
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <2686474.cvCA6vY47l@wuerfel>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <2686474.cvCA6vY47l@wuerfel>
Message-ID: <20160212220816.GG4847@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12, Arnd Bergmann wrote:
> 
> drivers/clk/qcom/gcc-apq8084.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-ipq806x.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-msm8660.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-msm8916.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/gcc-msm8974.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/lcc-ipq806x.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/lcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/mmcc-apq8084.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/mmcc-msm8960.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/mmcc-msm8960.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
> drivers/clk/qcom/mmcc-msm8974.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,

These are taken care of.

> 
> drivers/nvmem/qfprom.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,

I don't plan on reverting this one because it's only in -next. It
is redundant, but it's not actively breaking anything when the
driver tree and the regmap tree are merged together.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
