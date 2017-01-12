From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 12 Jan 2017 18:40:51 +0100
Subject: [PATCH v2] ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
In-Reply-To: <1483689872-30389-1-git-send-email-narmstrong@baylibre.com>
References: <1483689872-30389-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCDmF2-W4SFMSNrYwUpejYkV=rw-f3yhG3=mTmWxy4J8uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

(adding Brian Kim, one of the Hardkernel developers to this conversation)

On Fri, Jan 6, 2017 at 9:04 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> The current hardware is not able to run with all cores enabled at a
> cluster frequency superior at 1536MHz.
> But the currently shipped u-boot for the platform still reports an OPP
> table with possible DVFS frequency up to 2GHz, and will not change since
> the off-tree linux tree supports limiting the OPPs with a kernel parameter.
> A recent u-boot change reports the boot-time DVFS around 100MHz and
> the default performance cpufreq governor sets the maximum frequency.
> Previous version of u-boot reported to be already at the max OPP and
> left the OPP as is.
> Nevertheless, other governors like ondemand could setup the max frequency
> and make the system crash.
>
> This patch disables the DVFS clock and disables cpufreq.
I don't have any Odroid-C2 board, but having to live without cpufreq
sounds bad for the Odroid-C2 users.
What would we expect from a kernel perspective (maybe the Hardkernel
guys would adjust their u-boot instead of us adjusting to the behavior
of one specific device? one solution that I could think of involves
the "maxcpus" kernel parameter (see [0]), if this is not set u-boot
should report a max CPU frequency of 1536MHz (= max frequency for 4
active cores). Based on the "maxcpus" value additional frequencies can
be unlocked (this could be step-by-step if there are different
frequencies for one core/two cores/etc.). However, I'd like to hear
other opinions as well.


Regards,
Martin


[0] http://lxr.free-electrons.com/source/Documentation/kernel-parameters.txt?v=4.8#L2163
