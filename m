From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 13:28:18 +0200
Subject: [PATCH v2] gpio/xilinx: Use correct address when setting initial
 values.
In-Reply-To: <1435130385.30543.3.camel@localhost>
References: <1435130385.30543.3.camel@localhost>
Message-ID: <CACRpkdZUQ+-q28dPiEMy7PXgY6vUBHHrGfq+gANx62B9aJd20Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 9:19 AM, Rapha?l Teysseyre <rteysseyre@gmail.com> wrote:

> xgpio_save_regs() is used in this driver to setup the initial
> values of the registers in the hardware.
>
> The relevant registers at that time are:
> 0x0 -> channel 0 data (32 bits, one for each GPIO on this channel).
> 0x4 -> channel 0 tri, controls in/out status for each GPIO of this channel.
> 0x8 -> channel 1 data
> 0xC -> channel 1 tri
>
> gpio-xilinx.c defines these:
> XGPIO_DATA_OFFSET   (0x0)
> XGPIO_TRI_OFFSET    (0x4)
> XGPIO_CHANNEL_OFFSET    0x8
>
> Before this patch, the "data" register value of channel 1 was written
> at 0x4 intead of 0x8 (overwriting the channel 0 "tri" register),
> and the "tri" register value for channel 1 was written at 0x8 instead of 0xC.
>
> Signed-off-by: Rapha?l Teysseyre <rteysseyre@gmail.com>

Patch applied with review tags.

Yours,
Linus Walleij
