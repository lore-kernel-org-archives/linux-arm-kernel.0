From: horms@verge.net.au (Simon Horman)
Date: Fri, 27 Sep 2013 13:52:06 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
In-Reply-To: <201308252146.24500.sergei.shtylyov@cogentembedded.com>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <201308252146.24500.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130927045206.GD16541@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 09:46:23PM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Add HPB-DMAC platform device on R8A7779 SoC along with its slave and channel
> configurations (only for SDHI0 so far).
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: moved *enum* declaring HPB-DMAC slave IDs from now removed <mach/dma.h>
> to <mach/r8a7779.h>, removed #include <mach/dma.h> from setup-r8a7779.c, removed
> SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[] and
> hpb_dmae_channels[], added ASYNCMDR.ASBTMD{20|24|43} and ASYNCMDR.ASMD{20|24|43}
> fields/values, fixed comments to ASYNCMDR.ASBTMD2[123] and ASYNCMDR.ASMD2[123]
> fields/values, renamed all the bit/field/value #define's to include 'HBP_DMAE_'
> prefix to match the driver, moved comments after the element initializers of
> hpb_dmae_channels[].]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 2:
> - renamed all the bit/field/value #define's to include 'HBP_DMAE_' prefix to
>   match the driver;
> - added #define's for MMC[01] related fields of the ASYNCMDR register.
> 
>  arch/arm/mach-shmobile/include/mach/r8a7779.h |    7 +
>  arch/arm/mach-shmobile/setup-r8a7779.c        |  154 ++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)

Thanks, queued up for v3.13.
