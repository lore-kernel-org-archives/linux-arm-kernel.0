From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 15 Jan 2015 00:05:18 +0900
Subject: [GIT PULL RE-SEND] Samsung fixes for v3.19
In-Reply-To: <20150112221131.GC22090@quad.lixom.net>
References: <54B38550.6010707@kernel.org>
 <20150112221131.GC22090@quad.lixom.net>
Message-ID: <54B685AE.5080508@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Oops, it's totally my fault and mistake. Actually my git command for
pull-request was correct but the git tool was old version :-( because
there are two git in my laptop, anyway sorry for that and I'm resending
with signed tag has been created before.

Please pull if you're OK with my comments on your questions below.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-3.19

for you to fetch changes up to 26d13bf77b8e59adf4953577ba48e1903545bf7f:

  ARM: exynos_defconfig: Enable LM90 driver (2015-01-12 17:16:32 +0900)

----------------------------------------------------------------
Samsung fixes for v3.19
- exynos_defconfig: enable LM90 driver and display panel support
   - HWMON
   - SENSORS_LM90
   - Direct Rendering Manager (DRM)
   - DRM bridge registration and lookup framework
   - Parade ps8622/ps8625 eDP/LVDS bridge
   - NXP ptn3460 eDP/LVDS bridge
   - Exynos Fully Interactive Mobile Display controller (FIMD)
   - Panel registration and lookup framework
   - Simple panels
   - Backlight & LCD device support

- use pmu_system_controller phandle for dp phy
  : DP PHY requires pmu_system_controller to handle PMU reg. now

----------------------------------------------------------------
Andreas Faerber (1):
      ARM: exynos_defconfig: Enable LM90 driver

Javier Martinez Canillas (1):
      ARM: exynos_defconfig: Enable options for display panel support

Vivek Gautam (1):
      arm: dts: Use pmu_system_controller phandle for dp phy

 arch/arm/boot/dts/exynos5250.dtsi |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi |  4 ++--
 arch/arm/configs/exynos_defconfig | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

On 01/13/15 07:11, Olof Johansson wrote:
> Hi,
> 
> On Mon, Jan 12, 2015 at 05:26:56PM +0900, Kukjin Kim wrote:
>> Hi Arnd, Olof, Kevin
>>
>> Please pull samsung fixes for v3.19.
>>
>> Thanks,
>> Kukjin
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> v3.19-samsung-fixes
>>
>> Andreas Faerber (1):
>>       ARM: exynos_defconfig: Enable LM90 driver
>>
>> Javier Martinez Canillas (1):
>>       ARM: exynos_defconfig: Enable options for display panel support
>>
>> Vivek Gautam (1):
>>       arm: dts: Use pmu_system_controller phandle for dp phy
>>
>>  arch/arm/boot/dts/exynos5250.dtsi |    2 +-
>>  arch/arm/boot/dts/exynos5420.dtsi |    4 ++--
>>  arch/arm/configs/exynos_defconfig |   18 +++++++++++++++++-
>>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> Please write a tag description and sign it. You used to do this, why stop?
> 
> Also, you're not explaining what these patches fixes. I can see the usefulness
> in the display configuration options, but I'm less sure why 3.19 needs the LM90
> driver if it's just for consistency?
> 
Yeah it could be but I think, updating defconfig would be helpful
anytime if possible.

> Finally, please explain why pmu breaks. Sounds like an incompatible binding
> change?

Yes, correct so it is required even though the change has been done in
v3.18 not v3.19...commit a5ec59865025 (phy: exynos-dp-video: Use syscon
support to control pmu register)

Thanks,
Kukjin
