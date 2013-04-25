From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 11:20:18 +0200
Subject: [PATCH 01/32] dmaengine: ste_dma40: Assign memcpy channels in the
 driver
In-Reply-To: <1366279934-30761-2-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaMS8RBi7aWyBRRZbf7OpK82C3-79tEaq+A-QU5zbVyxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The channels reserved for memcpy are the same for all currently
> supported platforms. With this in mind, we can ease the platform
> data passing requirement by moving these assignments out from
> platform code and place them directly into the driver.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

(...)
> -       if (num_log_chans + plat_data->memcpy_len) {
> +       if (num_log_chans + ARRAY_SIZE(dma40_memcpy_channels)) {
>                 /*
>                  * The max number of logical channels are event lines for all
>                  * src devices and dst devices

So as mentioned in review of another patch there is a kzalloc
right below here where you forget to add + ARRAY_SIZE(dma40_memcpy_channels)
please fix this...

Yours,
Linus Walleij
