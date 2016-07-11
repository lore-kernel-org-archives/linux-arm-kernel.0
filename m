From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 11 Jul 2016 17:39:58 -0500
Subject: [PATCH 3/3] regulator: qcom_smd: Avoid overlapping linear
 voltage ranges
In-Reply-To: <20160711215009.4519-4-sboyd@codeaurora.org>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
 <20160711215009.4519-4-sboyd@codeaurora.org>
Message-ID: <20160711223958.GB6053@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 02:50:09PM -0700, Stephen Boyd wrote:
> The pm8x41_hfsmps ranges overlap. The first range is from 375000
> to 1562500:
> 
>  375000 + (95 * 12500) == 1562500
> 
> and the second range starts at 1550000. Interestingly, the second
> range ends at the correct value when it's set to be the
> appropriate start value, 1575000:
> 
>  1575000 + ((158 - 96) * 25000) == 3125000
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: da65e367b67e ("regulator: Regulator driver for the Qualcomm RPM")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Reviewed-by: Andy Gross <andy.gross@linaro.org>
