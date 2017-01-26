From: dtor@chromium.org (Dmitry Torokhov)
Date: Thu, 26 Jan 2017 09:26:13 -0800
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
 <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
 <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
 <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
Message-ID: <CAE_wzQ-an3v_32E+JFzTQMKXf=J6BVGf56QZKL+YCV=mZk6-LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 9:07 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 27, 2017 at 12:52:15AM +0800, Daniel Kurtz wrote:
>> On Fri, Jan 27, 2017 at 12:35 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
>
>> > Nobody doing DMA likes unaligned buffers. In fact, memory used for DMA
>> > must be cacheline aligned, or you going to have trouble. What
>> > component supplies unaligned buffers to SPI core for transfers?
>
>> cros-ec-spi
>
> That needs fixing then - I keep thinking we should add a warning to the
> core for this, especially now we do DMA mapping in the core.

OTOH the full buffer used by cros ec *is* DMA-safe (allocated with
kmalloc), it is that cors ec uses it at offset while transferring data
piece by piece. Do we want to support this?
