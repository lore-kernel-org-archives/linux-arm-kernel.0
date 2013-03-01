From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 01:52:15 +0100
Subject: [PATCH v5 12/12] ARM: dts: support pinmux in pxa910
In-Reply-To: <1361764181-26647-13-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
 <1361764181-26647-13-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdY0DOr-7RRH3kYGVmXYOzu=xC6Qy0_azhe4QqnM1XRR6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 4:49 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add gpio range, pinmux settings in pxa910 dkb DTS file.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Overall the file is looking real nice.

> +                                               &range 55 55 0  /* GPIO0 ~ GPIO54 */
> +                                               &range 188 5 1  /* GPIO55 ~ GPIO59 */
(...)
> +                                               0x198 0x6       /* GPIO47_UART1_RXD */
> +                                               0x19c 0x6       /* GPIO48_UART1_TXD */

The Freescale people just started using the new C preprocessor
for defining real constants for this type of stuff.

In this case it's be way more helpful to use

#define GPIO47_UART1_RXD 0x198

and use that.

(Though I'm not sure why hex numbers are helpful on such physical
things as pins, but your choice.)

Yours,
Linus Walleij
