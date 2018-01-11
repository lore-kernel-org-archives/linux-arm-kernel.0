From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Jan 2018 19:22:50 -0800
Subject: [PATCH v3 2/2] phy: rockchip-emmc: use regmap_read_poll_timeout
 to poll dllrdy
In-Reply-To: <1515638427-15117-3-git-send-email-wxt@rock-chips.com>
References: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
 <1515638427-15117-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=UPvqDiU6jzfGy9WwbDqnOyfuPTFw9OyLSah4HdjW0zoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 10, 2018 at 6:40 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> Just use the API instead of open-coding it, no functional change
> intended.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
>
> Changes in v3:
> - As Doug commented on https://patchwork.kernel.org/patch/10154797,
>   Change "1, 50" to "0, 50".
>
> Changes in v2:
> - As Brian commented on https://patchwork.kernel.org/patch/10139891/,
>   changed the note and added to print error value with
>   regmap_read_poll_timeout API.
>
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 33 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
