From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 14:32:35 +0200
Subject: [PATCH 2/2] soc: mediatek: PMIC wrap: Fix register state machine
 handling
In-Reply-To: <1432633064-16839-3-git-send-email-s.hauer@pengutronix.de>
References: <1432633064-16839-1-git-send-email-s.hauer@pengutronix.de>
 <1432633064-16839-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeK2_-_FQ2g3qZ=u-VuEK3AtXaWA_1XTXLd_HvqBc+hLiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-26 11:37 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> When the PMIC wrapper state machine has read a register it goes into the
> "wait for valid clear" (vldclr) state. The state machine stays in this
> state until the VLDCLR bit is written to. We should write this bit after
> reading a register because the SCPSYS won't let the system go into
> suspend as long as the state machine waits for valid clear.
>
> Since now we never leave the state machine in vldclr state we no longer
> have to check for this state on pwrap_read/pwrap_write entry and can
> remove the corresponding code.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>

Applied, thanks.
Matthias
