From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 7 Mar 2014 10:37:44 +0000
Subject: [PATCH v2 3/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <1394185272-26054-4-git-send-email-maxime.coquelin@st.com>
References: <1394185272-26054-1-git-send-email-maxime.coquelin@st.com>
 <1394185272-26054-4-git-send-email-maxime.coquelin@st.com>
Message-ID: <5319A178.7040002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peppe,
Thanks for the patch.

On 07/03/14 09:41, Maxime COQUELIN wrote:
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
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>


--srini
