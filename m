From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 24 Oct 2014 15:28:03 +0200
Subject: [PATCH 2/5] clk: samsung: exynos4415: Add clocks using common
 clock framework
In-Reply-To: <CAD8Lp45F_6UWXx0f2xVGZL+Rgemg2fzkYhnfPdaeaiky0rKPgw@mail.gmail.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>	<1413775935-17743-2-git-send-email-cw00.choi@samsung.com>
 <CAD8Lp45F_6UWXx0f2xVGZL+Rgemg2fzkYhnfPdaeaiky0rKPgw@mail.gmail.com>
Message-ID: <544A53E3.7040501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.10.2014 15:18, Daniel Drake wrote:
> On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch adds the new clock driver of Exynos4415 SoC based on Cortex-A9
>> using common clock framework. The CMU (Clock Management Unit) of Exynos4415
>> controls PLLs(Phase Locked Loops) and generates system clocks for CPU, buses
>> and function clocks for individual IPs.
> 
> There seems to be a lot in common here with other exynos4 variants in
> clk-exynos4.c. Have you considered just adding support for the 4415 in
> the existing driver?

I tried when I was still at Samsung and the outcome was far from being
nice. There are certain differences, such as separate address spaces of
few clock controllers and different bit fields in apparently similar
registers, which made resulting code quite ugly.

Also another advantage of separate driver is that it can be made without
duplicating initial fails of the driver for Exynos4, such as private
bindings for external clocks or clock controllers in different power
domains grouped together into one big logical clock controller, because
at development time they looked so (contiguous address space).

Best regards,
Tomasz
