From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Aug 2015 15:52:13 -0700
Subject: [PATCH 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
In-Reply-To: <4605286.lfFsCUY5jc@diego>
References: <15143985.aGzb1oeyb9@diego>
 <CAD=FV=W2LSQh4e9+=ooTf34VzM_yPZn497DqSVEdb1kehZbqQQ@mail.gmail.com>
 <4605286.lfFsCUY5jc@diego>
Message-ID: <CAD=FV=VHsU08e5HB4bGoVNEy-nRG_f2SkxPOK6wu_BA=r4xVeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 1, 2015 at 3:52 PM, Heiko St?bner <heiko@sntech.de> wrote:

> The dt code when creating the platform-devices assumes a 32bit dma mask and
> expects the drivers to set the correct dma_masks (in of_dma_configure). But
> from the original description this looks more like a limitation of the rk3288,
> not the individual dwmmc, dwc2, etc.
>
> So from my cursory glance, ZONE_DMA seems to be the best solution. As you said
> that this was investigated too, do you know if they encountered any obstacles
> that resulted in not adjusting the dma zone?
>
>
> @Jeffy: do you know how widespread this is? I.e. are socs like the rk3128 or
> possibly more importantly the rk3368 also affected by this in 4GB
> configurations?
>
>
> If the rk3368 does it too, this might get "interesting". In one of the mails
> about ZONE_DMA from september 2014, Arnd mentioned that there was a patch
> about getting the zone size from devicetree floating around, but it doesn't
> look like this landed.

I don't actually know all the details of the problems since others
investigated.  I was just trying to quickly summarize what I could
find in the internal bug for the benefit of the list...  Sorry if
that's not terribly helpful.  :(

-Doug
