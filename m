From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Jan 2017 13:36:21 +0000
Subject: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
In-Reply-To: <CAE_wzQ-an3v_32E+JFzTQMKXf=J6BVGf56QZKL+YCV=mZk6-LA@mail.gmail.com>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
 <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
 <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
 <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
 <CAE_wzQ-an3v_32E+JFzTQMKXf=J6BVGf56QZKL+YCV=mZk6-LA@mail.gmail.com>
Message-ID: <20170127133621.bifp64y2cdljld65@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:26:13AM -0800, Dmitry Torokhov wrote:

> OTOH the full buffer used by cros ec *is* DMA-safe (allocated with
> kmalloc), it is that cors ec uses it at offset while transferring data
> piece by piece. Do we want to support this?

I'm not sure the complexity is worth it as a general feature, I worry
about the cost of worrying about cutting the transaction up to include a
PIO portion.  That said that's just a gut feeling, if there were a
sufficiently simple/nice implementation it'd definitely avoid bugs.

To me part of DMA safety is the alignment restrictions.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/e7044d87/attachment.sig>
