From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 30 Oct 2017 22:52:42 +0100
Subject: [GIT PULL] Amlogic SoC updates for v4.15
In-Reply-To: <CAK8P3a1fLbzp4xzFyTEO1w4vu=X=wwSV74_WBXiuYqTeF1P5ng@mail.gmail.com>
References: <7hy3ntq50j.fsf@baylibre.com>
 <CAK8P3a1fLbzp4xzFyTEO1w4vu=X=wwSV74_WBXiuYqTeF1P5ng@mail.gmail.com>
Message-ID: <CAFBinCBpDsn1rrUUy74dpkCsHj_wca3ojmCaUUEiVB41cfvTMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Oct 30, 2017 at 11:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Oct 29, 2017 at 5:43 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> ----------------------------------------------------------------
>> Amlogic SoC updates for v4.15
>> - add SMP support to Meson8/8b
>
> Pulled into next/soc. For my understanding, could you clarify what
> this line is needed for on meson?
>
> +textofs-$(CONFIG_ARCH_MESON) := 0x00208000
this was already part of Carlo's version of the SMP patches. I didn't
question this change (I simply assumed that it's relevant - I never
questioned "why" it was relevant) so far
however, that was until Linus L?ssing (CC'ed) investigated a
bug-report from Emiliano Ingrassia (also CC'ed). you can find his
results here: [0]
(tl;dr: kernel refuses to boot without this change when using a
slightly modified multi_v7_defconfig)

Linus even asked me to split this change out into a separate patch [1]
however, by the time I came back home Kevin already sent out the pull request

please let me know if
- we can keep the patches the way they are right now
- or if you want to separate this change into a separate patch


Regards
Martin


[0] https://lkml.org/lkml/2017/10/28/148
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/005155.html
