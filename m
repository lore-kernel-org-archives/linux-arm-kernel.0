From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:34:05 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add quirky select input for
 USB_OTG_ID
In-Reply-To: <1375330924-27384-2-git-send-email-shawn.guo@linaro.org>
References: <1375330924-27384-1-git-send-email-shawn.guo@linaro.org>
 <1375330924-27384-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdb5caZkqweDF5Sr6z3ikYZENP58ot5GpL8Eer2pdB8YCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 6:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> For some reason, the select input of pin function USB_OTG_ID is not
> implemented via a regular select input register but using the bit
> USB_OTG_ID_ SEL (shift 13) of IOMUXC_GPR1 register (offset 0x4).
>
> As per the workaround for such quirk implemented in pinctrl driver,
> we need to compose the input_val cell as below.
>
>         31     23      15      7        0
>         | 0xff | shift | width | select |
>
> Thus, we have 0xff0d0100 for MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID and
> 0xff0d0101 for MX6QDL_PAD_GPIO_1__USB_OTG_ID in input_val cell.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

This does not apply on top of my "devel" branch in the pinctrl tree.

Could you respin this on top of devel and resend?

Or do I need some other patch(es) for this to apply?

Yours,
Linus Walleij
