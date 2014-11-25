From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 24 Nov 2014 19:20:21 -0800
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM;
 not stable
In-Reply-To: <044101d00852$3f421420$bdc63c60$@kernel.org>
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
 <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
 <7hegtaq26c.fsf@deeprootsystems.com>
 <CAMAWPa-mLAFL7v8hHA5R-eBzpMFK-E-xcvjoV8Bn6tTwgP53Uw@mail.gmail.com>
 <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
 <CAMAWPa-sz5jT9izEONVZR2Z4mzuivKaNHSgyR+eP13tWZ84hYw@mail.gmail.com>
 <CAOesGMgSkJ8xkBgN7OpuDzT=ehaAd6kvbx5_tC50x78pvpkTwg@mail.gmail.com>
 <CAOesGMh-7md4PdQX1Wvk0jO+87j+fxSvBnVD_osjNd2zQ4L43w@mail.gmail.com>
 <044101d00852$3f421420$bdc63c60$@kernel.org>
Message-ID: <CAMAWPa-qk0DEmPNz5LZgJq9AuGhRxuY00XwxtEikt_vh-iozVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 5:50 PM, Kukjin Kim <kgene@kernel.org> wrote:
> Olof Johansson wrote:
>>
>> On Mon, Nov 24, 2014 at 5:37 PM, Olof Johansson <olof@lixom.net> wrote:
>> > On Mon, Nov 24, 2014 at 5:35 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> >> On Mon, Nov 24, 2014 at 4:25 PM, Olof Johansson <olof@lixom.net> wrote:
>> >>> On Mon, Nov 24, 2014 at 11:51 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> >>>> Kukjin,
>> >>>>
>> >>>> On Mon, Nov 10, 2014 at 11:35 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> >>>>> Kukjin Kim <kgene@kernel.org> writes:
>> >>>>>
>> >>>>>> Kevin Hilman wrote:
>> >>>>>>>
>> >>>>>>> From: Kevin Hilman <khilman@linaro.org>
>> >>>>>>>
>> >>>>>>> The option CONFIG_EXYNOS5420_MCPM is causing imprecise external aborts
>> >>>>>>> during boot testing, causing various userspace startup failures.
>> >>>>>>>
>> >>>>>>> Disable until it has gotten more testing.
>> >>>>>>>
>> >>>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>,
>> >>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
>> >>>>>>> Cc: Sachin Kamat <sachin.kamat@samsung.com>,
>> >>>>>>> Cc: Doug Anderson <dianders@chromium.org>,
>> >>>>>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
>> >>>>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
>> >>>>>>> Cc: Tushar Behera <tushar.behera@linaro.org>,
>> >>>>>>> Cc: stable at vger.kernel.org # v3.17+
>> >>>>>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> >>>>>>> ---
>> >>>>>>> This has been reported by a few people[1], but not investigated or fixed, so it's
>> >>>>>>> time to disable this feature until it can be fixed.
>> >>>>>>>
>> >>>>>> Hi Kevin,
>> >>>>>>
>> >>>>>> Yeah I agree with your opinion.
>> >>>>>>
>> >>>>>> But as you can see my tree, I've queued regarding mcpm patches for 3.19 will
>> >>>>>> be shown in -next in this weekend.
>> >>>>>
>> >>>>> Which of the recently queued patches are expected to address the
>> >>>>> imprecise abort issue?  I'd be happy to test them out.
>> >>>>
>> >>>> Exynos5 MCPM is still broken in linux-next and still causing an imprecise abort.
>> >>>>
>> >>>> What is the status of $SUBJECT patch?
>> >>>>
>> >>>>>> Anyway let me apply this into -fixes and
>> >>>>>> then let's enable after test its functionality in -next in a couple of days.
>> >>>>>
>> >>>>> Yes, I think this needs to be applied until these aborts are understood
>> >>>>> and fixed.
>> >>>>
>> >>>> Is anyone at Samsung actually looking into these MCPM issues?
>> >>>
>> >>> Hi Kevin,
>> >>>
>> >>> What hardware are you having problems with? 5420 or 5422/5800?
>> >>
>> >> Yes.  :)
>> >>
>> >> exynos5420-arndale-octa:
>> >> http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5420-
>> arndale-octa.html
>> >> exynos5422-odroid-xu3:
>> >> http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc6/arm-exynos_defconfig/boot-exynos5422-
>> odroid-xu3.html
>> >>
>> >> My boot tests seem to pass fine because I have such a minimal
>> >> userspace, but Tyler Baker reported that with a "real" userspace, he
>> >> can't boot to a shell:
>> >>
>> >>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286203.html
>> >
> Hmm...his report was in Sep...I think it should be fine with current -next?

No, it is still broken in linux-next (as I stated above.)

Moreover, earlier in this thread you mentioned you were merging some
MCPM patches that should address this, but did not respond when I
asked which patches you thing should address this issue

> To be honest, since I don't have the exynos5420 arndale, chromebook...but smdk
> which has different bootloader, I couldn't test it...I'll try to make a test
> farm like you guys...

Do you have some colleagues with any other 542x hardware?  I had
assumed that linux-next was being better tested on the publicaly
available, and widely available boards like odroid-xu3 and
Chromebook2, but I've come to realize the hard way that that is not
the case.  You mention your board has a different bootloader.  Do you
suspect there's a bootloader issue on these other platforms?  If so,
could you elaborate on possible fixes?  I'm more than willing to test
any proposed fixes, but I'm not familiar enough yet with these SoCs to
figure out the underlying issues alone.

Until you have a working board farm, you could start having a closer
look at the boot logs we're already producing.  Admittedly linux-next
broken in many ways besides this one for exynos currently, but it has
been having these imprecise aborts well before the other recent
issues.

Also, It's very possible that this issue is not even MCPM related at
all, and MCPM is just uncovering a previously hidden bug.  It would be
very helpful if people more familiar with this hardware and SoC would
investigate bug reports like these.

Kevin
