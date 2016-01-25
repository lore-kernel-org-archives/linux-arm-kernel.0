From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 25 Jan 2016 11:14:36 +0900
Subject: [PATCH v9 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
In-Reply-To: <56724519.80108@samsung.com>
References: <cover.1447659546.git.p.fedin@samsung.com>
 <56724519.80108@samsung.com>
Message-ID: <56A5850C.4020005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.12.2015 14:16, Krzysztof Kozlowski wrote:
> On 16.11.2015 16:43, Pavel Fedin wrote:
>> This patch extends Exynos SROM controller driver with ability to configure
>> controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
>> which is connected via SROMc bank #3.
>>
>> With this patchset, support for the whole existing SMDK range can be added.
>> Actually, only bank number is different.
>>
>> This patchset also depends on Exynos 5410 pinctrl support, introduced by
>> patches 0003 and 0004 from this set:
>> [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html
>>
>> Pinctrl support is necessary in order to correctly configure
>> multifunctional pins of the Exynos chip.
>>
> 
> Let me share the plan/status:
> 1. Currently Kukjin Kim is out of office (he told me he will be back on
> Christmas).
> 2. I asked arm-soc people to pull my previous pull requests.
> 
> 3. I applied this patchset to my branch:
> next/stuff-late-not-split-per-branch
> https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/stuff-late-not-split-per-branch
> 
> 4. This branch is not pushed to linux-next. I will sort it out if my
> previous pull requests get in. I will be out of office for Christmas so
> depending on the timing of {arm-soc,Christmas,Kukjin} this may or may
> not go into v4.5 (yay...).
> 
> 5. If it does not get into v4.5, I will rebase it and proceed further
> for v4.6.
> 
> If you have any questions, please let me know.

Hi Kukjin, Pankaj, Pavel,

I rebased these 3 patchsets (move SROM to drivers, add bank support,
mnove PMU to drivers) on v4.5-rc1 and re-organized the work on usual
arm-soc branches.

Hmmm, maybe not such "usual" because of the dependencies (DTS changes
are needed before removal of code from mach-exynos) this looks a little
bit different. Anyway I put it on a separate branch and tag:
1. samsung-drivers-soc-srom-pmu-4.6
2. samsung-dt-srom-4.6

https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/

Everything is also in for-next. The point is that you don't have to do
anything as for now. I'll handle it for v4.6 (hopefully).

Tests on Trats2 passed fine. Now each commit is being tested on mine
Odroid XU3 (http://www.krzk.eu).

Best regards,
Krzysztof
