From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 10:49:19 +0200
Subject: [PATCH 01/10] pinctrl: mediatek: data struct optimize and remove
 unused member
In-Reply-To: <1431567346-33780-2-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-2-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZhxAxOMCwvMz2BWqND053kZ0taVstQn8n2emN=wktF-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 3:35 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> struct mtk_desc_pin.chip, mtk_pinctrl_devdata.invser_offset
> and mtk_pinctrl_devdata.chip_type are never used in code.
> Remove them.
>
> Some per-pin data are using int for pin number and offsets.
> Change to short and rearrange to reduce const data size.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied.

However I suggest you use:

unsigned int => u32
unsigned short => u16
unsigned char => u8

These kernel-specific types are more to the point,
you immediately see how many bits they use, so a
patch chaning all of the types to u32/u16/u8 would
be welcome.

Yours,
Linus Walleij
