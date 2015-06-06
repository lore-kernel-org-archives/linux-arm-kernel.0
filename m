From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Sat, 6 Jun 2015 20:43:45 +0900
Subject: [PATCH] Documentation: ARM: EXYNOS: Describe boot loaders
 interface
In-Reply-To: <848ubx2j9v.wl-peter.chubb@nicta.com.au>
References: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
 <848ubx2j9v.wl-peter.chubb@nicta.com.au>
Message-ID: <CAJKOXPefY1jCddwAL=uSg28St9rZbgxsLcDSmjmFfjYH-8EmGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-06 20:01 GMT+09:00 Peter Chubb <peter.chubb@nicta.com.au>:
>>>>>> "Krzysztof" == Krzysztof Kozlowski <k.kozlowski.k@gmail.com> writes:
>
> Krzysztof> Various boot loaders for Exynos based boards use certain
> Krzysztof> memory addresses during booting for different
> Krzysztof> purposes. Mostly this is one of following : 1. as a CPU
> Krzysztof> boot address, 2. for storing magic cookie related to low
> Krzysztof> power mode (AFTR, sleep).
>
> Krzysztof> The document, based solely on kernel source code, tries to
> Krzysztof> group the information scattered over different files. This
> Krzysztof> would help in the future when adding support for new SoC or
> Krzysztof> when extending features related to low power modes.
>
> Is it worth grabbing the info from u=boot and documenting it here
> (it's not documented other than in the hardkenel U=Boot source)?
>
> I can send you the info, or you can see it in
> https://github.com/hardkernel/u-boot/blob/odroidxu3-v2012.07/board/samsung/smdk5420/lowlevel_init.S
> at symbol nscode_base near line 104

Hi,

+CC ?ukasz Majewski (u-boot)

The patch actually covers u-boot. What is missing:
1, Reset - I think kernel does not set it.
2. LPA - There is no mainline support for it yet so I did not add it.
It should be added along with cpuidle LPA.
3. MCPM and Exynos542x stuff. There are some exceptions and weird
comments in the kernel (like "To increase the stability of KFC reset
we need to program  the PMU SPARE3 register"). It would take me some
more time to understand it so I wanted to start with basic version and
get comments.

Best regards,
Krzysztof
