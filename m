From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jul 2013 02:02:34 +0400
Subject: [PATCH 1/3] ARM: shmobile: use common platform header for HPB-DMAC
In-Reply-To: <CANqRtoTCaJfbECSpX7nMZoV8SPeQqs-xrJQ0-+-smA+bx3QG=w@mail.gmail.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300245.58486.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTCaJfbECSpX7nMZoV8SPeQqs-xrJQ0-+-smA+bx3QG=w@mail.gmail.com>
Message-ID: <51E865FA.9000706@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/02/2013 08:59 AM, Magnus Damm wrote:

>> From: Max Filippov <max.filippov@cogentembedded.com>

>> Use previously empty <mach/dma.h> to declare HPB-DMA slave IDs.

>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>> [Sergei: changed the guard macro name, fixed comment, extended copyright.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/mach-shmobile/include/mach/dma.h |   25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)

> Thanks for your patch. Can you please explain the reason why you put
> this shared information under mach/?

    I'm afraid that's more a question to the original author, Phil Edworthy.
He put this stuff into <mach/hpb-dmae.h>.

>  From my point of view we should really have as few special things as
> possible under mach/. Starting to share DMA stuff here looks special.
> I would like mach-shmobile to be as standard as possible (basically
> only ARM code in the future), and in the case we have I/O devices or
> other IOMMUs or DMA controllers then we should use include/linux or
> that recently added platform data directory if needed. We need to make
> sure that our headers stay compatible with multiplatform support.

> I realize you may want to share this header between multiple SoCs, but
> I really want to avoid creating local common code under arch/arm/ that
> has nothing to do with ARM. Also, this is IMO a total non-issue,
> instead of merging code and making back porting more difficult for any
> particular SoC, then how about spending effort on the ling term
> instead, like DMA DT?

> So my recommendation is to keep this information together with each
> SoC. And also work on DT. In between have a coffee or work on DT, but
> please do not spend time on merging short term per-SoC information and
> making back porting more difficult.

    OK. DT would be a next step I guess.

> Thanks,

> / magnus

WBR, Sergei
