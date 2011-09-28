From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 07:25:49 +0200
Subject: [PATCH 2/3] mmc: mmci: Provide option to configure bus signal
	direction
In-Reply-To: <1317123738-29867-1-git-send-email-ulf.hansson@stericsson.com>
References: <1317123738-29867-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbUO96VerVShwWfd99245T90JcEGcO0PXCy80PLPLygQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 1:42 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> @@ -30,6 +43,8 @@ struct dma_chan;
> ?* @cd_invert: true if the gpio_cd pin value is active low
> ?* @capabilities: the capabilities of the block as implemented in
> ?* this platform, signify anything MMC_CAP_* from mmc/host.h
> + * @sigdir: a bit field indicating for what bits in the MMC bus the host
> + * should enable signal direction indication.
> ?* @dma_filter: function used to select an appropriate RX and TX
> ?* DMA channel to be used for DMA, if and only if you're deploying the
> ?* generic DMA engine
> @@ -52,6 +67,7 @@ struct mmci_platform_data {
> ? ? ? ?int ? ? gpio_cd;
> ? ? ? ?bool ? ?cd_invert;
> ? ? ? ?unsigned long capabilities;
> + ? ? ? unsigned int sigdir;

u32 again, no big deal. Can be fixed when submitting it to the patch tracker.
Acked-by.

Yours,
Linus Walleij
