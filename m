From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri, 18 Dec 2015 12:56:28 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: Add L2 cache-controller nodes
In-Reply-To: <CAMuHMdXpgtPDMBUd_aJsxvh1oFF36i5AnTTSvh+1kmEzcWkGyg@mail.gmail.com>
References: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
 <1449904607-4060-2-git-send-email-dirk.behme@gmail.com>
 <CAMuHMdXpgtPDMBUd_aJsxvh1oFF36i5AnTTSvh+1kmEzcWkGyg@mail.gmail.com>
Message-ID: <5673F46C.2070501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.12.2015 12:03, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Sat, Dec 12, 2015 at 8:16 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Add device nodes for the L2 caches, and link the CPU node to its L2
>> cache node.
>>
>> The L2 cache for the Cortex-A57 CPU cores is 2 MiB large (organized as
>> 128 KiB x 16 ways).
>>
>> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
>> 32 KiB x 16 ways).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>> ---
>> Note: Geert: I picked your patch from
>>
>> http://www.spinics.net/lists/arm-kernel/msg466628.html
>>
>> incoporated some review comments and rebased it against
>>
>> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/log/?h=next renesas-next-20151211v2-v4.4-rc1
>
> This is more or less what I have locally, except that I kept the latency
> properties


Hmm, maybe I missed anything, but the only part reading the latency I 
can find is

arch/arm/mm/cache-l2x0.c

[1] which isn't relevant for arm64?

Best regards

Dirk

[1]

./arch/arm/mm/cache-l2x0.c:1042:	of_property_read_u32(np, 
"arm,tag-latency", &tag);
./arch/arm/mm/cache-l2x0.c:1143:	of_property_read_u32_array(np, 
"arm,tag-latency", tag, ARRAY_SIZE(tag));
