From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 24 Oct 2014 15:56:08 +0200
Subject: [PATCH 2/5] clk: samsung: exynos4415: Add clocks using common
 clock framework
In-Reply-To: <CAD8Lp45F_6UWXx0f2xVGZL+Rgemg2fzkYhnfPdaeaiky0rKPgw@mail.gmail.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-2-git-send-email-cw00.choi@samsung.com>
 <CAD8Lp45F_6UWXx0f2xVGZL+Rgemg2fzkYhnfPdaeaiky0rKPgw@mail.gmail.com>
Message-ID: <544A5A78.2030101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/14 15:18, Daniel Drake wrote:
> On Sun, Oct 19, 2014 at 9:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> > This patch adds the new clock driver of Exynos4415 SoC based on Cortex-A9
>> > using common clock framework. The CMU (Clock Management Unit) of Exynos4415
>> > controls PLLs(Phase Locked Loops) and generates system clocks for CPU, buses
>> > and function clocks for individual IPs.
>
> There seems to be a lot in common here with other exynos4 variants in
> clk-exynos4.c. Have you considered just adding support for the 4415 in
> the existing driver?

I would rather avoid mixing clock description tables for more SoCs in
clk-exynos4.c. There is quite a few differences between exynos4x12 and
exynos4415 clock controllers, I'm afraid merging exynos4415 support to
clk-exynos4.c would just create more branches and made the code harder
to follow, without much decrease in code size. The clock tree in single
SoC is already complex, without consolidating support for several SoCs
in one unit.

-- 
Regards,
Sylwester
