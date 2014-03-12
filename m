From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 09:38:25 +0000
Subject: [PATCH v4 2/6] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <1394614210-15698-3-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-3-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140312093825.GE5672@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> This patch adds a new logic inside the st pinctrl to manage
> an unsupported scenario: some sysconfig are not available!
> 
> This is the case of STiH407 where, although documented, the
> following registers from SYSCFG_FLASH have been removed from the SoC.
> 
> SYSTEM_CONFIG3040
>    Output Enable pad control for all PIO Alternate Functions
> and
> SYSTEM_ CONFIG3050
>    Pull Up pad control for all PIO Alternate Functions
> 
> Without managing this condition an imprecise external abort
> will be detect.
> 
> To do this the patch also reviews the st_parse_syscfgs
> and other routines to manipulate the registers only if
> actually available.
> In any case, for example the st_parse_syscfgs detected
> an error condition but no action was made in the
> st_pctl_probe_dt.
> 
> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  drivers/pinctrl/pinctrl-st.c | 104 +++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 43 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
