From: ta.omasab@gmail.com (Thomas Abraham)
Date: Mon, 21 Jul 2014 18:45:03 +0530
Subject: [PATCH] ARM: dts: add CPU nodes for Exynos4 SoCs
In-Reply-To: <10657588.befqTi5XsZ@amdc1032>
References: <1863399.9O2S91ZvEO@amdc1032>
 <CAD8Lp46eB3cDqD+1YMnWOG-V8CG7fCG1s2KH7znL0OrHSazRcQ@mail.gmail.com>
 <10657588.befqTi5XsZ@amdc1032>
Message-ID: <CAJuA9aiaVg-FJty6a_+RwwO6W1jYQYhUABNqDB7vWnpCJL=wcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 6:40 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Monday, July 21, 2014 01:43:53 PM Daniel Drake wrote:
>> On Fri, Jul 18, 2014 at 5:00 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> > Recent patch by Tomasz Figa ("irqchip: gic: Fix core ID calculation
>> > when topology is read from DT") fixed GIC driver to filter cluster ID
>> > from values returned by cpu_logical_map() for SoCs having registers
>> > mapped without per-CPU banking making it is possible to add CPU nodes
>> > for Exynos4 SoCs.  In case of Exynos SoCs these CPU nodes are also
>> > required by future changes adding initialization of cpuidle states in
>> > Exynos cpuidle driver through DT.
>>
>> This conflicts with work in the thread "cpufreq: use generic cpufreq
>> drivers for exynos platforms" which is already in its 7th iteration.
>> Perhaps best to work directly with Thomas to help him finish that series?
>
> Patch "[PATCH v7 4/6] ARM: dts: Exynos: add cpu nodes, opp and cpu clock
> configuration data" from Thomas needs another revision anyway since it lacks
> cluster ID in Exynos4210 CPU node.  It also mixes addition of CPU nodes
> with cpufreq specific changes and IMHO addition of CPU nodes should be in
> separate patch to ease bisection if any later problems turn up.  Therefore
> I think that it would be the best if Thomas would rebase his work on top of
> "irqchip: gic: Fix core ID calculation when topology is read from DT" patch
> and this one.  Thomas, are you okay with this?

Hi Bartlomiej,

Yes, I am okay with this.

Regards,
Thomas.

>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
