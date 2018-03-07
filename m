From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 7 Mar 2018 23:05:33 +0530
Subject: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
In-Reply-To: <20180307143832.GJ3701@kernel.org>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
 <20180307143832.GJ3701@kernel.org>
Message-ID: <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will Cohen,

On Wed, Mar 7, 2018 at 8:08 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Wed, Mar 07, 2018 at 09:32:05AM -0500, William Cohen escreveu:
>> On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
>> > There is MIDR change on ThunderX2 B0, adding an entry to mapfile
>> > to enable JSON events for B0.
>> >
>> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>
> Ganapatrao, can you please take this in consideration and if agreeing
> send a v2 patch?
>
> With that I can add an Acked-by: wcohen, Right?
>
> - Arnaldo
>> > ---
>> >  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > index e61c9ca..93c5d14 100644
>> > --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > @@ -13,4 +13,5 @@
>> >  #
>> >  #Family-model,Version,Filename,EventType
>> >  0x00000000420f5160,v1,cavium,core
>> > +0x00000000430f0af0,v1,cavium,core
>> >  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
>> >
>>
>> Hi,
>> Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:

for arm64 implementation,  bits 3:0(Revision) and bits 23:20(Variant)
are ignored/dont-care.

>>
>> 0x00000000430f0af[[:xdigit:]],v1,cavium,core
>>
>>
>> -Will Cohen
>

thanks
Ganapat
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
