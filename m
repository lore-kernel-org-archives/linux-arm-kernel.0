From: js@sig21.net (Johannes Stezenbach)
Date: Mon, 4 Apr 2016 16:31:46 +0200
Subject: [PATCH v3] dma: pl08x: allocate OF slave channel data at probe
 time
In-Reply-To: <1459710079-8525-1-git-send-email-linus.walleij@linaro.org>
References: <1459710079-8525-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160404143146.GA457@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Apr 03, 2016 at 09:01:19PM +0200, Linus Walleij wrote:
> The current OF translation of channels can never work with
> any DMA client using the DMA channels directly: the only way
> to get the channels initialized properly is in the
> dma_async_device_register() call, where chan->dev etc is
> allocated and initialized.
> 
> Allocate and initialize all possible DMA channels and
> only augment a target channel with the periph_buses at
> of_xlate(). Remove some const settings to make things work.
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Cc: Johannes Stezenbach <js@sig21.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop the patch and variable for fixed signal assignment.
> - Always assign a fixed channel number when registering
>   the channels.

Your patch looks good, and I just tested it and
it also works :-)  Perfect!


Thanks,
Johannes
