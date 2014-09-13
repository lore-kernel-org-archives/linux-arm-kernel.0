From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sat, 13 Sep 2014 18:29:58 +0530
Subject: exynos5420/arndale-octa: imprecise external aborts on
 exynos_defconfig
In-Reply-To: <7h7g1bwbyh.fsf@deeprootsystems.com>
References: <CANMBJr41TQx4jVjnOO9WThn=SiZCq12mx1xtGN8_ubzZrO1=YA@mail.gmail.com>
 <7h7g1bwbyh.fsf@deeprootsystems.com>
Message-ID: <CAJuA9ahkpZ4EJQz4DoAjYzo0OQw5zXLavAVoXRBdgPcm9EUQYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 12:16 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Tyler Baker <tyler.baker@linaro.org> writes:
>
>> Exynos5420-based Arndale octa boards have recently started failing boot
>> tests due to imprecise external aborts.  This only appears to happen
>> when using exynos_defconfig and boots fine with multi_v7_defconfig.  The
>> issue seems to be intermittent, so is not reliably reproducable and
>> difficult to bisect.  Here are a few boot logs from recent
>> mainline/linux-next kernels that are failing:
>
> FYI, I'm seeing the same periodic aborts.  For example, here's my boot
> of next-20140910:
> http://images.armcloud.us/kernel-ci/next/next-20140910/arm-exynos_defconfig/boot-exynos5420-arndale-octa.html
>
> However, my userspace is much simpler and doesn't seem to cause a panic,
> so my boot tests report passing. (I should fixup my scripts so these
> imprecise aborts are reported as a FAIL.)
>
> I'm glad you pointed out that it happens only with exynos_defconfig and
> not multi_v7_defconfig because I noticed that too.  I haven't had the
> time to track it any further than that, so maybe the exynos folks can
> help track it down from here.
>
> Thanks for reporting this,
>
> Kevin

Hi Tyler, Kevin,

>From the bootlog you have shared,

[    1.060016] CPU4: failed to come online
[    2.070031] CPU5: failed to come online
[    3.080049] CPU6: failed to come online
[    4.090066] CPU7: failed to come online
[    4.090099] Brought up 4 CPUs
[    4.090109] SMP: Total of 4 processors activated.
[    4.090119] CPU: WARNING: CPU(s) started in wrong/inconsistent
modes (primary CPU mode 0x13)
[    4.090128] CPU: This may indicate a broken bootloader or firmware.

Would it be possible to set max cpus to 1, disable switcher and try
again. I don't have a arndale octa board but I have tested mainline
kernel with smdk5420 board. It boots all eight CPUs, switcher works
fine and there are no imprecise aborts seen.

Thanks,
Thomas.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
