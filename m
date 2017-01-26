From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Jan 2017 17:07:47 +0000
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
 <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
 <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
Message-ID: <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 12:52:15AM +0800, Daniel Kurtz wrote:
> On Fri, Jan 27, 2017 at 12:35 AM, Dmitry Torokhov <dtor@chromium.org> wrote:

> > Nobody doing DMA likes unaligned buffers. In fact, memory used for DMA
> > must be cacheline aligned, or you going to have trouble. What
> > component supplies unaligned buffers to SPI core for transfers?

> cros-ec-spi

That needs fixing then - I keep thinking we should add a warning to the
core for this, especially now we do DMA mapping in the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/e9fe70d0/attachment.sig>
