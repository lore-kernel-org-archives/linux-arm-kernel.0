From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2018 10:53:33 +0100
Subject: [PATCH V5 1/1] gpio: vf610: add optional clock support
In-Reply-To: <1541426614-17299-1-git-send-email-aisheng.dong@nxp.com>
References: <CACRpkdaO-cUd7wVksboUU0-qu20aBo370Rio=GkNH11U0CB4Jw@mail.gmail.com>
 <1541426614-17299-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdYpmfkB82OLG8ksVO9xFz+uW3OAC1uFwEztCS9CNNZeSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 3:08 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> Some SoCs need the gpio clock to be enabled before accessing
> HW registers. This patch add the optional clock handling.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v4->v5:
>  * refine gpio clk get
>  * add remove

This looks good but doesn't apply to the GPIO "devel" branch
for some reason:

$ git am --signoff dong1.patch
Applying: gpio: vf610: add optional clock support
error: patch failed: drivers/gpio/gpio-vf610.c:16
error: drivers/gpio/gpio-vf610.c: patch does not apply
Patch failed at 0001 gpio: vf610: add optional clock support
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

$ patch -p1 < dong1.patch
patching file drivers/gpio/gpio-vf610.c
Hunk #1 succeeded at 7 with fuzz 2 (offset -9 lines).
Hunk #2 FAILED at 42.
patch: **** malformed patch@line 136: ev)

Can you check and rebase/resend?

Yours,
Linus Walleij
