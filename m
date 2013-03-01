From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 14:07:56 +0100
Subject: [PATCH 2/2] pinctrl: imx: use pin_func_ids to search the pinctrl
 item.
In-Reply-To: <1361932553-8218-2-git-send-email-b32955@freescale.com>
References: <1361932553-8218-1-git-send-email-b32955@freescale.com>
 <1361932553-8218-2-git-send-email-b32955@freescale.com>
Message-ID: <CACRpkdYO5UN=t_nu1XQmBAjH6zWZRgnOY2zSQeO2K=ERrUPQCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 3:35 AM, Huang Shijie <b32955@freescale.com> wrote:

> The uart may works in DTE mode or DCE mode. The customer can sets the different
> modes by the pinctrl. But the pinctrl items for DTE or DCE may share the
> same Pad id, such as:
>   MX6Q_PAD_EIM_D27__UART2_RXD_DTE and MX6Q_PAD_EIM_D27__WEIM_WEIM_D_27
>   share the same MX6Q_PAD_EIM_D27 pad id.
>
> The current code only search the pinctrl items by pad id. So if there two
> pinctrl items shares the same pad id, the current code only use the first one,
> even you tell the system to use the second one in the DTS file.
>
> This patch adds a new field pin_func_ids to imx_pin_group{}, and uses the
> pin_func_ids as the index to search the pinctrl items. In this way, we can
> avoid the issue.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Dong/Shawn: what about this patch?

The patches anyway has to be merged through the i.MX tree I think,
if there is a huge movement in these files currently.

Yours,
Linus Walleij
