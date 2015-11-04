From: dianders@chromium.org (Doug Anderson)
Date: Wed, 4 Nov 2015 15:34:59 -0800
Subject: [PATCH 1/8] phy: rockchip-usb: fix clock get-put mismatch
In-Reply-To: <1446673454-9529-2-git-send-email-heiko@sntech.de>
References: <1446673454-9529-1-git-send-email-heiko@sntech.de>
 <1446673454-9529-2-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=X=tDxuc_wur-Bedi4PqWhe9Z3t_oaUQ1+6vQHmOSb+Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko

On Wed, Nov 4, 2015 at 1:44 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Currently the phy driver only gets the optional clock reference but
> never puts it again, neither during error handling nor on remove.
> Fix that by moving the clk_put to a devm-action that gets called at
> the right time when all other devm actions are done.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/phy/phy-rockchip-usb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
