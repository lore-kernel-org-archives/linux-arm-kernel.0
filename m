From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 28 Sep 2012 20:31:18 +0530
Subject: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to
 platform_data/dma-omap
In-Reply-To: <20120928145459.GZ4840@atomide.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
 <20120928145459.GZ4840@atomide.com>
Message-ID: <CAMQu2gw9DJSZ4QVvo83atTpnsXyegneuQ2rJKBc+5ioiwEaqaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 8:25 PM, Tony Lindgren <tony@atomide.com> wrote:
>
> * Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
> > Move plat/dma.h header to platform_data/dma-omap.h as
> > part of the single zImage work.
>
> Hmm there's no platform data in this header, just
> exported things for drivers to use. So it should not
> be placed into platform_data.
>
> Maybe it should be #include <asm/mach/dma-omap.h> for now?
>
I wasn't sure either when the file was placed under platform-data.
I agree for now we can keep it mach layer but than means OMAP1 and
OMAP2+ DMA header and source code needs to be split. That
is not so straight forward.

With DMA engine conversion hopefully, we might get rid of the
header eventually, but for now not sure whether we should
go ahead and follow the splitting part.

Thoughts ?

Regards
Santosh
