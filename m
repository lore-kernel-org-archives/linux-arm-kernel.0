From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Nov 2015 13:01:10 -0800
Subject: [PATCH v2 5/8] clk: rockchip: fix usbphy-related clocks
In-Reply-To: <1446998681-26436-6-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <1446998681-26436-6-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=X6icKQKnKnJkkhd-mNC6rCxJnvP6nemhzCabG4-UvM5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Sun, Nov 8, 2015 at 8:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> The otgphy clocks really only drive the phy blocks. These in turn
> contain plls that then generate the 480m clocks the clock controller
> uses to supply some other clocks like uart0, gpu or the video-codec.
>
> So fix this structure to actually respect that hirarchy and removed
> that usb480m fixed-rate clock working as a placeholder till now, as
> this wouldn't even work if the supplying phy gets turned off while
> its pll-output gets used elsewhere.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3188.c | 11 +++--------
>  drivers/clk/rockchip/clk-rk3288.c | 16 +++++-----------
>  2 files changed, 8 insertions(+), 19 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
