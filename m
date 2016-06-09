From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 9 Jun 2016 14:22:57 +0300
Subject: [PATCH v3 05/12] ARM: shmobile: r8a7792: add SMP support
In-Reply-To: <CAMuHMdXe==X8x5Q2Hnm7kPp9THwvqVq95imwGoAQyDQv=8=P3g@mail.gmail.com>
References: <12536856.AsKMEpuejQ@wasted.cogentembedded.com>
 <7848375.HIECFST0Ua@wasted.cogentembedded.com>
 <CAMuHMdXe==X8x5Q2Hnm7kPp9THwvqVq95imwGoAQyDQv=8=P3g@mail.gmail.com>
Message-ID: <97912a61-cff1-24e1-b275-16431e20bff3@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/9/2016 11:44 AM, Geert Uytterhoeven wrote:

>> Add R8A7792 SMP support using the shared APMU code. This SoC has 2 ARM
>> Cortex-A15  CPU cores.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
[...]
>>  # PM objects
>> Index: renesas/arch/arm/mach-shmobile/r8a7792.h
>> ===================================================================
>> --- /dev/null
>> +++ renesas/arch/arm/mach-shmobile/r8a7792.h
>> @@ -0,0 +1,6 @@
>> +#ifndef __ASM_R8A7792_H__
>> +#define __ASM_R8A7792_H__
>> +
>> +extern const struct smp_operations r8a7792_smp_ops;
>
> For new SMP support, you should no longer add an SoC-specific struct
> smp_operations, but rely on the DT "enable-method" property, cfr.
> "[PATCH v3 00/09] ARM: shmobile: APMU DT support via SMP Enable method V3"
> (http://www.spinics.net/lists/linux-sh/msg45229.html).
>
> That series will no longer apply, but I've been carrying (and rebasing) it in
> my local tree for quite a while, as it was related to SYSC cleanup (avoiding
> your r8a7792_ca15_scu). But unfortunately that depends on the SYSC node always
> be present in DT.

    My patch is not against you repo, it's against Simon's repo. If you indeed 
care for these Magnus' patches (abandoned again?), please re-post them and get 
them merged.

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
