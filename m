From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 18:27:11 +0200
Subject: [PATCH 2/3] gpio: zynq: Fixed broken wakeup implementation
In-Reply-To: <1409335127-26712-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
 <1409335127-26712-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdbb0oeA0b5SSLtR6U7jv8asCeEJdHEsDAg7_tH+GHc5RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 7:58 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> From: Ezra Savard <ezra.savard@xilinx.com>
>
> Use of unmask/mask in set_wake was an incorrect implementation. The new
> implementation correctly sets wakeup for the gpio chip's IRQ so the gpio chip
> will not sleep while wakeup-enabled gpio are in use.
>
> Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied.

However the problems seems quite generic.

Do you see this kind of error in other GPIO drivers?

IRQchip semantics always make me nervous.

Yours,
Linus Walleij
