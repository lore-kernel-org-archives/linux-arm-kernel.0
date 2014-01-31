From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 11:13:51 +0100
Subject: [PATCH v2 09/21] pinctrl: mvebu: dove: provide generic mpp
 callbacks
In-Reply-To: <1390869573-27624-10-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-10-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdYpGm-KAFqU5cpzbhrM1NaZJYtQa86wP7qJFrai2bDYbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> We want to get rid of passing register addresses to common pinctrl
> driver, so provide set/get callbacks for generic mpp pins.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

OK...

> +static int dove_mpp_ctrl_get(struct mvebu_mpp_ctrl *ctrl,
> +                            unsigned long *config)
> +{


(...)

This is fine.

> @@ -374,7 +398,7 @@ static struct mvebu_mpp_ctrl dove_mpp_controls[] = {
>         MPP_FUNC_CTRL(13, 13, "mpp13", dove_pmu_mpp_ctrl),
>         MPP_FUNC_CTRL(14, 14, "mpp14", dove_pmu_mpp_ctrl),
>         MPP_FUNC_CTRL(15, 15, "mpp15", dove_pmu_mpp_ctrl),
> -       MPP_REG_CTRL(16, 23),
> +       MPP_FUNC_CTRL(16, 23, NULL, dove_mpp_ctrl),

What does this have to do with the rest of the patch?

(Maybe I'm stupid, beware I'm just glancing over this stuff as I
see the patch set is still in development.)

Yours,
Linus Walleij
