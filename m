From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 2 Jul 2013 13:59:20 +0900
Subject: [PATCH 1/3] ARM: shmobile: use common platform header for HPB-DMAC
In-Reply-To: <201306300245.58486.sergei.shtylyov@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300245.58486.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoTCaJfbECSpX7nMZoV8SPeQqs-xrJQ0-+-smA+bx3QG=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sun, Jun 30, 2013 at 7:45 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
>
> Use previously empty <mach/dma.h> to declare HPB-DMA slave IDs.
>
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: changed the guard macro name, fixed comment, extended copyright.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/include/mach/dma.h |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

Thanks for your patch. Can you please explain the reason why you put
this shared information under mach/?

>From my point of view we should really have as few special things as
possible under mach/. Starting to share DMA stuff here looks special.
I would like mach-shmobile to be as standard as possible (basically
only ARM code in the future), and in the case we have I/O devices or
other IOMMUs or DMA controllers then we should use include/linux or
that recently added platform data directory if needed. We need to make
sure that our headers stay compatible with multiplatform support.

I realize you may want to share this header between multiple SoCs, but
I really want to avoid creating local common code under arch/arm/ that
has nothing to do with ARM. Also, this is IMO a total non-issue,
instead of merging code and making back porting more difficult for any
particular SoC, then how about spending effort on the ling term
instead, like DMA DT?

So my recommendation is to keep this information together with each
SoC. And also work on DT. In between have a coffee or work on DT, but
please do not spend time on merging short term per-SoC information and
making back porting more difficult.

Thanks,

/ magnus
