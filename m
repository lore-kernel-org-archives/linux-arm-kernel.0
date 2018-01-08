From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Jan 2018 09:13:55 +0530
Subject: [PATCH V3 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
In-Reply-To: <1515377091-10422-2-git-send-email-Anson.Huang@nxp.com>
References: <1515377091-10422-1-git-send-email-Anson.Huang@nxp.com>
 <1515377091-10422-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180108034355.GA4003@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-01-18, 10:04, Anson Huang wrote:
> Add 696MHz operating point for i.MX6UL, only for those
> parts with speed grading fuse set to 2b'10 supports
> 696MHz operating point, so, speed grading check is also
> added for i.MX6UL in this patch, the clock tree for each
> operating point are as below:
> 
> 696MHz:
>     pll1                       696000000
>        pll1_bypass             696000000
>           pll1_sys             696000000
>              pll1_sw           696000000
>                 arm            696000000
> 528MHz:
>     pll2                       528000000
>        pll2_bypass             528000000
>           pll2_bus             528000000
>              ca7_secondary_sel 528000000
>                 step           528000000
>                    pll1_sw     528000000
>                       arm      528000000
> 396MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            396000000
> 198MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            198000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> changes since v2:
> 	add reviewed-by.
>  drivers/cpufreq/imx6q-cpufreq.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
