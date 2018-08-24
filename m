From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 09:51:31 +0200
Subject: [PATCH v8 0/4] drm/atmel-hlcdc: bus-width override support
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
Message-ID: <20180824095131.5d9cb33f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, 10 Aug 2018 15:03:55 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> The background for these patches is that our PCB interface between
> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> this has to be described somewhere, or the atmel-hlcdc driver have no
> chance of selecting the correct output mode. Since we have similar
> problems with a tda19988 HDMI encoder I added patches to override
> the atmel-hlcdc output format via DT properties compatible with the
> media video-interface binding and things start to play together.
> 
> Cheers,
> Peter
> 
> Changes since v7  https://lkml.org/lkml/2018/8/4/288
> - The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
>   which simplifies fixing this in patch 4/4 (and adds flexibility)
>   and adjust patch 4/4 to the changes done in the new 3/4.
> - return -ENOMEM on allocation failure in patch 4/4

I stopped following the discussion at some point. Are there any open
issues or Ack you're waiting for?
