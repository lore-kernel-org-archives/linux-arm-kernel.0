From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 10 Nov 2011 14:57:34 +0900
Subject: [PATCH 1/3] ARM: EXYNOS: Add ASV feature for Exynos4 series
In-Reply-To: <4EAAF8EF.5010201@gmail.com>
References: <1319677938-25732-1-git-send-email-boyko.lee@samsung.com>
 <1319677938-25732-2-git-send-email-boyko.lee@samsung.com>
 <4EAAF8EF.5010201@gmail.com>
Message-ID: <CAJ0PZbR9DEOud8j90n0M4UHQ=HA35NSzO0MHUzAxsOz4ViVCKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 3:48 AM, Sylwester Nawrocki <snjw23@gmail.com> wrote:
>
> You're putting whole driver under arch/arm/, I'm wondering whether the functionality
> it provides could be handled by some generic framework, like cpufreq or devfreq.
> How this driver is different from cpufreq drivers ?

I think there would be futher usage with ASV if IEM and proper PMICs
are attaches; however, for now, ASV guides proper vddarm and vddint
voltages for each freuquency.

Both drivers in cpufreq(vddarm and arm core freq) and devfreq(vddint
and memory/bus freq.. and GPU or MMC later?) should use the result
value of ASV because they both alter voltages according to the ASV
value.

Thus, if this is going to be located in drivers/, it'd better be in
elsewhere (drivers/misc? drivers/hwmon? ..???) and capable of
providing values to other device drivers, at least to cpufreq and
devfreq drivers.


Cheers!
MyungJoo

>
> --
> Thanks,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
