From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 4 May 2012 11:21:42 +0530
Subject: [PATCH V2 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <2b4c7e15add17a63aeab924b5b5dc2d6fadfd259.1336039716.git.viresh.kumar@st.com>
References: <cover.1336039716.git.viresh.kumar@st.com>
 <2b4c7e15add17a63aeab924b5b5dc2d6fadfd259.1336039716.git.viresh.kumar@st.com>
Message-ID: <4FA36E6E.3060800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2012 3:42 PM, Viresh KUMAR wrote:
> +static int gpio_request_endisable(struct pinctrl_dev *pctldev,
> +               struct pinctrl_gpio_range *range, unsigned offset, bool enable)
> +{
> +       struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
> +       struct spear_gpio_pingroup *gpio_pingroup;
> +
> +       gpio_pingroup = get_gpio_pingroup(pmx, offset);
> +       if (PTR_ERR(gpio_pingroup))
> +               return PTR_ERR(gpio_pingroup);
> +

Minor fixup:

---
 drivers/pinctrl/spear/pinctrl-spear.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 2596fa6..c0c3b28 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -316,7 +316,7 @@ static int gpio_request_endisable(struct pinctrl_dev *pctldev,
        struct spear_gpio_pingroup *gpio_pingroup;
 
        gpio_pingroup = get_gpio_pingroup(pmx, offset);
-       if (PTR_ERR(gpio_pingroup))
+       if (IS_ERR(gpio_pingroup))
                return PTR_ERR(gpio_pingroup);
 
        if (gpio_pingroup) {

-- 
viresh
