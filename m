From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 25 Nov 2014 11:31:18 +0530
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM;
 not stable
In-Reply-To: <CAMAWPa-qk0DEmPNz5LZgJq9AuGhRxuY00XwxtEikt_vh-iozVg@mail.gmail.com>
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
 <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
 <7hegtaq26c.fsf@deeprootsystems.com>
 <CAMAWPa-mLAFL7v8hHA5R-eBzpMFK-E-xcvjoV8Bn6tTwgP53Uw@mail.gmail.com>
 <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
 <CAMAWPa-sz5jT9izEONVZR2Z4mzuivKaNHSgyR+eP13tWZ84hYw@mail.gmail.com>
 <CAOesGMgSkJ8xkBgN7OpuDzT=ehaAd6kvbx5_tC50x78pvpkTwg@mail.gmail.com>
 <CAOesGMh-7md4PdQX1Wvk0jO+87j+fxSvBnVD_osjNd2zQ4L43w@mail.gmail.com>
 <044101d00852$3f421420$bdc63c60$@kernel.org>
 <CAMAWPa-qk0DEmPNz5LZgJq9AuGhRxuY00XwxtEikt_vh-iozVg@mail.gmail.com>
Message-ID: <CAM4voa==Ram0xXTL=SnKktyRt7VFphQxBJgcf9Yi9Zio0QctHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Tue, Nov 25, 2014 at 8:50 AM, Kevin Hilman <khilman@kernel.org> wrote:
> On Mon, Nov 24, 2014 at 5:50 PM, Kukjin Kim <kgene@kernel.org> wrote:
>> Olof Johansson wrote:
>>>
>>> On Mon, Nov 24, 2014 at 5:37 PM, Olof Johansson <olof@lixom.net> wrote:
>>> > On Mon, Nov 24, 2014 at 5:35 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> >> On Mon, Nov 24, 2014 at 4:25 PM, Olof Johansson <olof@lixom.net> wrote:
>>> >>> On Mon, Nov 24, 2014 at 11:51 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> >>>> Kukjin,
>>> >>>>
>>> >>>> On Mon, Nov 10, 2014 at 11:35 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> >>>>> Kukjin Kim <kgene@kernel.org> writes:
>>> >>>>>
>>> >>>>>> Kevin Hilman wrote:
>>> >>>>>>>
>>> >>>>>>> From: Kevin Hilman <khilman@linaro.org>
>>> >>>>>>>
>>> >>>>>>> The option CONFIG_EXYNOS5420_MCPM is causing imprecise external aborts
>>> >>>>>>> during boot testing, causing various userspace startup failures.
>>> >>>>>>>
>>> >>>>>>> Disable until it has gotten more testing.
>>> >>>>>>>
>>> >>>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>,
>>> >>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
>>> >>>>>>> Cc: Sachin Kamat <sachin.kamat@samsung.com>,
>>> >>>>>>> Cc: Doug Anderson <dianders@chromium.org>,
>>> >>>>>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
>>> >>>>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
>>> >>>>>>> Cc: Tushar Behera <tushar.behera@linaro.org>,
>>> >>>>>>> Cc: stable at vger.kernel.org # v3.17+
>>> >>>>>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>> >>>>>>> ---
>>> >>>>>>> This has been reported by a few people[1], but not investigated or fixed, so it's
>>> >>>>>>> time to disable this feature until it can be fixed.
>>> >>>>>>>
>>> >>>>>> Hi Kevin,
>>> >>>>>>
>>> >>>>>> Yeah I agree with your opinion.
>>> >>>>>>
>>> >>>>>> But as you can see my tree, I've queued regarding mcpm patches for 3.19 will
>>> >>>>>> be shown in -next in this weekend.
>>> >>>>>
>>> >>>>> Which of the recently queued patches are expected to address the
>>> >>>>> imprecise abort issue?  I'd be happy to test them out.
>>> >>>>
>>> >>>> Exynos5 MCPM is still broken in linux-next and still causing an imprecise abort.
>>> >>>>
>>> >>>> What is the status of $SUBJECT patch?
>>> >>>>
>>> >>>>>> Anyway let me apply this into -fixes and
>>> >>>>>> then let's enable after test its functionality in -next in a couple of days.
>>> >>>>>
>>> >>>>> Yes, I think this needs to be applied until these aborts are understood
>>> >>>>> and fixed.
>>> >>>>
>>> >>>> Is anyone at Samsung actually looking into these MCPM issues?
>>> >>>
>>> >>> Hi Kevin,
>>> >>>
>>> >>> What hardware are you having problems with? 5420 or 5422/5800?
>>> >>
>>> >> Yes.  :)
>>> >>
>>> >> exynos5420-arndale-octa:
>>> >> http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5420-
>>> arndale-octa.html
>>> >> exynos5422-odroid-xu3:
>>> >> http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5422-
>>> odroid-xu3.html
>>> >>
>>> >> My boot tests seem to pass fine because I have such a minimal
>>> >> userspace, but Tyler Baker reported that with a "real" userspace, he
>>> >> can't boot to a shell:
>>> >>
>>> >>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286203.html
>>> >
>> Hmm...his report was in Sep...I think it should be fine with current -next?
>
> No, it is still broken in linux-next (as I stated above.)
>
> Moreover, earlier in this thread you mentioned you were merging some
> MCPM patches that should address this, but did not respond when I
> asked which patches you thing should address this issue
>
>> To be honest, since I don't have the exynos5420 arndale, chromebook...but smdk
>> which has different bootloader, I couldn't test it...I'll try to make a test
>> farm like you guys...
>
> Do you have some colleagues with any other 542x hardware?  I had
> assumed that linux-next was being better tested on the publicaly
> available, and widely available boards like odroid-xu3 and
> Chromebook2, but I've come to realize the hard way that that is not

Are you seeing this on Chromebook2 (Peach-Pi 5800) too ?

> the case.  You mention your board has a different bootloader.  Do you
> suspect there's a bootloader issue on these other platforms?  If so,
> could you elaborate on possible fixes?  I'm more than willing to test
> any proposed fixes, but I'm not familiar enough yet with these SoCs to
> figure out the underlying issues alone.
>
> Until you have a working board farm, you could start having a closer
> look at the boot logs we're already producing.  Admittedly linux-next
> broken in many ways besides this one for exynos currently, but it has
> been having these imprecise aborts well before the other recent
> issues.
>
> Also, It's very possible that this issue is not even MCPM related at
> all, and MCPM is just uncovering a previously hidden bug.  It would be
> very helpful if people more familiar with this hardware and SoC would
> investigate bug reports like these.

The 3 boards I have access to (SMDK5420, Chromebook Peach-Pi and
Chromebook Peach-Pit) work fine with MCPM enabled. I am not sure why
it is failing only on the above mentioned boards as there is nothing
specific to them in the MCPM back-end.

I assume that when you default to platsmp (on disabling MCPM), the
non-working boards boot all cores upto userspace without any issues ?

Based on the timeline (problems started about 2.5 months back), there
have only been a couple of changes in the 5420 MCPM back-end. Could
you revert the following commits and check if things improve.

20fe6f9 ARM: EXYNOS: Support cluster power off on exynos5420/5800
fbb0499 ARM: 8083/1: exynos: activate the CCI on boot CPU/cluster
using the MCPM loopback

These might not revert cleanly, so instead of the above you could also
comment the following 2 lines:


diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
b/arch/arm/mach-exynos/mcpm-exynos.c
index dc9a764..9a07188 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -152,7 +152,7 @@ static void exynos_power_down(void)
                exynos_cpu_power_down(cpunr);

                if (exynos_cluster_unused(cluster)) {
-                       exynos_cluster_power_down(cluster);
+                       //exynos_cluster_power_down(cluster);
                        last_man = true;
                }
        } else if (cpu_use_count[cpu][cluster] == 1) {
@@ -356,8 +356,8 @@ static int __init exynos_mcpm_init(void)
        ret = mcpm_platform_register(&exynos_power_ops);
        if (!ret)
                ret = mcpm_sync_init(exynos_pm_power_up_setup);
-       if (!ret)
-               ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
+       //if (!ret)
+               //ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
        if (ret) {
                iounmap(ns_sram_base_addr);
                return ret;



If you still get aborts then I suspect that the problem is with the
bootloader configuration but am not sure. I am OK with disabling
5420_MCPM in the default configuration in such a case. This would
however mean that S2R also stops working by default on 5420.

Regards,
Abhilash
>
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
