From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 26 Oct 2012 14:25:36 +0530
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpokEXAGD-nUF6u8tugvF2ffJx3HLLd+Zgc2+6GB9hxnT6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 16 October 2012 09:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> dw_dmac driver already supports device tree but it used to have its platform
> data passed the non-DT way.
>
> This patch does following changes:
> - pass platform data via DT, non-DT way still takes precedence if both are used.
> - create generic filter routine
> - Earlier slave information was made available by slave specific filter routines
>   in chan->private field. Now, this information would be passed from within dmac
>   DT node. Slave drivers would now be required to pass bus_id (a string) as
>   parameter to this generic filter(), which would be compared against the slave
>   data passed from DT, by the generic filter routine.
> - Update binding document

I can see that you applied these patches and they are present in
linux-next. But i feel
the order of patches is bad.

git log --oneline gives following:

879a0ec dmaengine: dw_dmac: Update documentation style comments for
dw_dma_platform_data
d0e35f3 dmaengine: dw_dmac: Enhance device tree support
4c4c30c ARM: SPEAr13xx: Pass DW DMAC platform data from DT

The last patch "ARM: SPEAr13xx: Pass DW DMAC platform data from DT" has
dependency on second patch.

The correct order would be:
4c4c30c ARM: SPEAr13xx: Pass DW DMAC platform data from DT
d0e35f3 dmaengine: dw_dmac: Enhance device tree support
879a0ec dmaengine: dw_dmac: Update documentation style comments for
dw_dma_platform_data


PS: We are looking at output of git log. Last patch (or first from
bottom) was applied first.

--
viresh
