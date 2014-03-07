From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Mar 2014 11:10:43 +0800
Subject: [PATCH 3/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <1393589841-6634-4-git-send-email-maxime.coquelin@st.com>
References: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
 <1393589841-6634-4-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdYczgJiDQEfkiiJdXVtm-42_rRSedf6HGd7Eoq0ttWJ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 8:17 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

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

Hm this does not apply to my tree at all. It appears this is not
a stand-alone, patch, so it depends on some other patch to
pinctrl-sti?

Yours,
Linus Walleij
