From: dianders@google.com (Doug Anderson)
Date: Mon, 14 Nov 2016 10:15:30 -0800
Subject: [PATCH v2 1/2] phy: rockchip-inno-usb2: correct clk_ops callback
In-Reply-To: <1479106911-16049-2-git-send-email-wulf@rock-chips.com>
References: <1479106911-16049-1-git-send-email-wulf@rock-chips.com>
 <1479106911-16049-2-git-send-email-wulf@rock-chips.com>
Message-ID: <CAD=FV=W36tdw3LqPq3tp58U4trYX6n=qaotMTsP6tm0QzZrRWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

William

On Sun, Nov 13, 2016 at 11:01 PM, William Wu <wulf@rock-chips.com> wrote:
> Since we needs to delay ~1ms to wait for 480MHz output clock
> of USB2 PHY to become stable after turn on it, the delay time
> is pretty long for something that's supposed to be "atomic"
> like a clk_enable(). Consider that clk_enable() will disable
> interrupt and that a 1ms interrupt latency is not sensible.
>
> The 480MHz output clock should be handled in prepare callbacks
> which support gate a clk if the operation may sleep.
>
> Signed-off-by: William Wu <wulf@rock-chips.com>
> ---
>  drivers/phy/phy-rockchip-inno-usb2.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
