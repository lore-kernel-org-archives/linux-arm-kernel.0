From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jun 2015 09:57:00 +0800
Subject: [linux-sunxi] [PATCH 1/2] clk: sunxi: Add support for the usb-clk
 on sun8i a23 and a33 SoCs
In-Reply-To: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
References: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v666A6WRwpQyyUWtnX90bQUoa_jjbxz9oZ9thDLKOsXysg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 2:23 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The usb-clk on sun8i a23 and a33 SoCs is similar to the ones found
> on sun6i-a31 SoCs but instead of a 3th phy the a23 / a33 have a hsic
> interface which gets enabled by almost the same bits as used on
> the a31 for the 3th phy, but not exactly the same bits so we need
> a new compatible for this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I have almost the exact same patches in my old sun8i-otg branch.
I was planning to rebase them onto the new musb patches today,
but since you beat me to them,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

My old patches are in https://github.com/wens/linux/tree/sun8i-usb
I planned on testing EHCI/OHCI first before posting anything.

Regards
ChenYu

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-usb.c                       | 11 +++++++++++
>  2 files changed, 12 insertions(+)
