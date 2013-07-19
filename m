From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jul 2013 15:32:38 +0400
Subject: [PATCH 1/3] ARM: shmobile: use common platform header for HPB-DMAC
In-Reply-To: <51E92053.5080103@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300245.58486.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTCaJfbECSpX7nMZoV8SPeQqs-xrJQ0-+-smA+bx3QG=w@mail.gmail.com>
 <51E865FA.9000706@cogentembedded.com>
 <87txjrbe11.wl%kuninori.morimoto.gx@renesas.com>
 <51E92053.5080103@cogentembedded.com>
Message-ID: <51E923D6.5050502@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-07-2013 15:17, Sergei Shtylyov wrote:

>>>>> From: Max Filippov <max.filippov@cogentembedded.com>

>>>>> Use previously empty <mach/dma.h> to declare HPB-DMA slave IDs.

>>>>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>>>>> [Sergei: changed the guard macro name, fixed comment, extended copyright.]
>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>>> ---
>>>>>    arch/arm/mach-shmobile/include/mach/dma.h |   25
>>>>> ++++++++++++++++++++++++-
>>>>>    1 file changed, 24 insertions(+), 1 deletion(-)

>>>> Thanks for your patch. Can you please explain the reason why you put
>>>> this shared information under mach/?

    IIUC, because the only 2 file using it were under arch/arm/mach-shmobile/.

>>>      I'm afraid that's more a question to the original author, Phil Edworthy.
>>> He put this stuff into <mach/hpb-dmae.h>.

>> Then, why you could send this patch instead of original author,

>     Ask Phil why didn't he upstream his stuff. We, unlike him, do have
> obligation to upstream it.

>> even though you can't answer any question about it ?

>     I'm not the author of the patch, let me remind you, Max Filippov is.
> He was on vacations.

    Phil's patches were only for R8A7778, IIRC (yet, the platfrom DMA code was 
placed in a separate file, not r8a7778.c). Max decided to use the 
<mach/hpb-dmae.h> header for sharing the DMA channel IDs between R8A777[89], I 
agreed but suggested to use the empty <mach/dma.h> instead.

>> Best regards
>> ---
>> Kuninori Morimoto

WBR, Sergei
