From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Nov 2016 10:32:30 +0100
Subject: [PATCH v2 1/6] pinctrl-aspeed-g5: Never set SCU90[6]
In-Reply-To: <1478097481-14895-2-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-2-git-send-email-andrew@aj.id.au>
Message-ID: <CACRpkdack8N+eAmNXwke_s_ZD+sUC+KnTF1GEJQJV0D=s=_U2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 2, 2016 at 3:37 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

> If a pin depending on bit 6 in SCU90 is requested for GPIO, the export
> will succeed but changes to the GPIO's value will not be accepted by the
> hardware. This is because the pinmux driver has misconfigured the SCU by
> writing 1 to the reserved bit.
>
> The description of SCU90[6] from the datasheet is 'Reserved, must keep
> at value ?0?'. The fix is to switch pinmux from the bit-flipping macro
> to explicitly configuring the .enable and .disable values to zero.
>
> The patch has been tested on an AST2500 EVB.
>
> Fixes: 56e57cb6c07f (pinctrl: Add pinctrl-aspeed-g5 driver)
> Reported-by: Uma Yadlapati <yadlapat@us.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>
> This patch should be applied for 4.9.

Patch applied for fixes, adding Joel's review tag.

Yours,
Linus Walleij
