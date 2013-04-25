From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 11:00:22 +0200
Subject: [PATCH 12/32] ARM: ux500: Remove superfluous 'psize' attribute
 from Audio platform data
In-Reply-To: <1366279934-30761-13-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbu-e75rz+BgbfFH7nXMWMTzpFT=k2yhA80jJKv9jpzkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> 'psize' is used to calculate the maximum DMA burst size. However it
> is only taken into consideration when editing the DMA channel's
> configuration. The Audio DMA platform data is only used to allocate
> a channel, not configure it. That will be done at a later date within
> the MSP driver.
>
> We're also removing comments which are no longer required, as
> 'data_width' is no longer set in any device's platform data period.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Pls CC patches like this to Ola LILJA.

So if I understand correctly this is now handled by
dmaengine_pcm.c, os that right?

Yours,
Linus Walleij
