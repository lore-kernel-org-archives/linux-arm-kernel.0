From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jan 2015 12:54:25 +0100
Subject: [PATCH v2 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <CAFd313zMoW86ZcXURrk2K+E6129L+BruOp4E0A=w0PQEcMr-Yw@mail.gmail.com>
References: <1420628981-22774-1-git-send-email-rsahu@apm.com>
 <1701652.4qUlzcU1j2@wuerfel>
 <CAFd313zMoW86ZcXURrk2K+E6129L+BruOp4E0A=w0PQEcMr-Yw@mail.gmail.com>
Message-ID: <2355599.PaLfD1Yyf4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 January 2015 14:56:33 Rameshwar Sahu wrote:
> 
> > Also add the correct dma-ranges property in the parent, or else this will
> > fail in the future once we add proper checks to dma_set_mask.
> 
> I see arch/arm64 kernel doesn't use dma range value parsed from
> dma-range property currently, I will check it more.
> It doesn't use dma_pfn_offset value calculated by the dma-ranges in
> dma mapping API.
> dma-ranges value should test properly before adding.
> Is there any use to add this dma-ranges properly if arch code doesn't support ??

Of course: the dt needs to describe the hardware correctly. This is
just a bug in the current arm64 code and it will soon be fixed.

	Arnd
