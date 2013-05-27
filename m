From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:37:37 +0200
Subject: [PATCH] ARM: ux500: Provide supplies for AUX1, AUX2 and AUX3
In-Reply-To: <1369394539-3713-1-git-send-email-lee.jones@linaro.org>
References: <1369394539-3713-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZGHNG0uG+vicpQEQ0y61bAM0FTg-wMrZ3SbsW2Owf0PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 1:22 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch fixes a bug introduced in the v3.10 merge window.
>
> The AB8500 External Regulator driver has recently landed upstream,
> which registers each of the 3 external regulators located on the
> AB8500. If these regulators are marked as 'always on', there is a
> potential for power-loss. If they're not and are seemingly unused
> the Regulator subsystem will attempt to disable them to save power.
> This causes an issue for AUX1, AUX2 and AUX3 as they obtain their
> power from EXT3. So we're specifying that here to prevent EXT3 from
> being powered down.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied for ux500-fixes, thanks!

Yours,
Linus Walleij
