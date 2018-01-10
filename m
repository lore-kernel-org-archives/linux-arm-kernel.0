From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Jan 2018 11:36:10 -0800
Subject: [PATCH v2 2/2] phy: rockchip-emmc: use regmap_read_poll_timeout
 to poll dllrdy
In-Reply-To: <1515569879-31808-3-git-send-email-wxt@rock-chips.com>
References: <1515569879-31808-1-git-send-email-wxt@rock-chips.com>
 <1515569879-31808-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=VHVrnbxsLXLEjbsN=U-7+X4Up9nMH1CZykn_yPcfhJ0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 9, 2018 at 11:37 PM, Caesar Wang <wxt@rock-chips.com> wrote:
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
> Changes in v2:
> - As Brian commented on https://patchwork.kernel.org/patch/10139891/,
>   changed the note and added to print error value with
>   regmap_read_poll_timeout API.
>
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 33 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)

See comments in Shawn's v2.  AKA: <https://patchwork.kernel.org/patch/10154797/>
