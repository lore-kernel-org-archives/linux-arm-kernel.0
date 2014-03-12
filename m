From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Mar 2014 15:16:32 +0100
Subject: [PATCH v4 2/6] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <1394614210-15698-3-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-3-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdY4FJ04=jnU_7GVM_W80Lx=t2nggx9=2=cfdHAJdN2kNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 9:50 AM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

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

This v4 version applied to the pinctrl devel branch with
Lee's ACK.

Yours,
Linus Walleij
