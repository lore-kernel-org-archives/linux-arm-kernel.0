From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 26 Sep 2014 15:45:09 +0200
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <5425690A.6080102@gmail.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
 <5424900D.2070709@gmail.com> <54254776.7070803@samsung.com>
 <5425690A.6080102@gmail.com>
Message-ID: <54256DE5.5050203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/14 15:24, Tomasz Figa wrote:
> I'm not concerned specifically with Exynos4210, but with placing such
> kind of data in common dtsi files.
> 
> Notice that even on boards which have correct initialization done by
> firmware, this will cause the settings to be overwritten, even if the
> firmware sets correct, but different values, regardless of them being
> clock parents or rates.
> 
> To me, even if this would mean duplicating some data, making this per
> board and present only in dts files of boards that actually need this
> (i.e. are known to have broken firmware) sounds more reasonable.

OTOH by having those settings in device tree would ensure the clock
tree is set correctly, regardless of the firmware. There is only one
correct clock parent for these devices, so the kernel couldn't do any
harm. I'd say it never worked in practice to rely on the bootloader
to configure these things, and one could say the firmware has been
broken in general with regards to this issue.

--
Regards,
Sylwester
