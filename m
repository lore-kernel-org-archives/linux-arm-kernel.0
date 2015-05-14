From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Thu, 14 May 2015 22:56:29 +0900
Subject: [GIT PULL 4/5] Samsung arm64 DT updates for v4.1
In-Reply-To: <555248E5.6010709@kernel.org>
References: <555248E5.6010709@kernel.org>
Message-ID: <CAGTfZH3bzjvVLH2HALDTLUf0MzibeH7sfFJh1n=dyuitYmUw_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wed, May 13, 2015 at 3:39 AM, Kukjin Kim <kgene@kernel.org> wrote:
>> Olof Johansson wrote:
>> >
>> > On Thu, Apr 02, 2015 at 03:16:55AM +0900, Kukjin Kim wrote:
>> > > The following changes since commit
> c517d838eb7d07bbe9507871fab3931deccff539:
>> > >
>> > >   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
>> > >
>> > > are available in the git repository at:
>> > >
>> > >
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> > > tags/samsung-dt-64
>> > >
>> > > for you to fetch changes up to
> 423c716151e254e42650ad78b30c2cd782c6f654:
>> > >
>> > >   arm64: dts: Add thermal-zones dt node for exynos5433 (2015-03-27
>> > > 02:13:43 +0900)
>> > >
>> > > ----------------------------------------------------------------
>> > > Samsung arm64 DT updates for v4.1
>> > >
>> > > - add new SoC for arm64 based exynos5433 SoC
>> > >   : exynos5433 - Octa cores for big.LITTLE architecture
>> > >   (Quad Cortex-A57 big and Quad Cortex-A53 LITTLE cores)
>> > >
>> > >   : added thermal-zones, TMU sensor and I2S dt nodes
>> > >   : added ADMA, RTC, ADC, PMU, SPI/PDMA and MSHC dt nodes
>> > >   : added pinctrl, HS-I2C, Serial and basic system dt nodes
>> > >
>> > > ----------------------------------------------------------------
>> > > Chanwoo Choi (6):
>> > >       arm64: dts: Add dts files for 64-bit Exynos5433 SoC
>> > >       arm64: dts: Add SPI/PDMA dt node for exynos5433
>> > >       arm64: dts: Add PMU dt node for exynos5433
>> > >       arm64: dts: Add RTC and ADC dt node for exynos5433
>> > >       arm64: dts: Add TMU sensor dt node for exynos5433
>> > >       arm64: dts: Add thermal-zones dt node for exynos5433
>> > >
>> > > Inha Song (2):
>> > >       arm64: dts: Add ADMA dt node for exynos5433
>> > >       arm64: dts: Add I2S dt node for exynos5433
>> > >
>> > > Jaehoon Chung (1):
>> > >       arm64: dts: Add MSHC dt node for exynos5433
>> > >
>> > >  .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
>> > >  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698
> +++++++++++++++
>> > >  .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  22 +
>> > >  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 231 +++++
>> > >  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 931
>> > > +++++++++++++++++++++
>> > >  5 files changed, 1883 insertions(+)
>> > >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
>> > >  create mode 100644
>> > > arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
>> > >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> > >  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> >
>> + Chanwoo, Mike
>>
>> Hi Olof,
>>
>> Thanks for your taking other pull-requests :-)
>>
>> > How do you even build these dts files? How did you test this branch
> before
>> > you sent it to us?
>> >
>> Yeah, your pointing out is exact. In my side, I've tested with 1) creating
>> exynos5433-smdk5433 board dt file and 2) adding ARCH_EXYNOS5433 config in
>> arch/arm64 and 3) including 5433 related clk tree, actually in linux-next.
>> Sorry for missing the explaining in my pull-request.
>>
>> For 1), I've talked to Chanwoo about that and he is not ready to post its
>> board dt now and I want actual board dt for mass product would be better
>> in mainline. Maybe need some time...
>>
>> For 2), we can add regarding updates for exynos-64 Kconfig/Makefile
> including
>> Arnd's suggestion to collapse all exynos-64 config entries in
> arm64/Kconfig
>> _later_, because current the exynos5433 dt has a dependency with 1)
> and clk
>> tree to support exynos5433 SoC.
>>
>> For 3), same as For 2). Additionally as you know tipically arm-soc and clk
>> trees could have dependencies when new SoC supporting is added.
>>
>> > Not merged.
>> >
>> Yeah, I agreed why you didn't. In this case, how do you think about adding
>> support new SoC then adding board dt including above changes later?
>>
>> Thanks,
>> Kukjin
>
> Hi Chanwoo,
>
> As you know, the arm64-exynos5433 couldn't be sent to upstream during
> previous merge window because it cannot be built without other stuff
> such as board DT file. I think, you need to post its regarding board DT
> file, I could test the exynos5433 series in my side with smdk5433 dt
> file though. Maybe as you know, I have no plan to upstream the smdk5433
> DT file because it will not be used outside of Samsung S.LSI.

Thanks for your test about Exynos5433 patch-set.
But, I cannot send the DTS file for Exynos5433 right now.
On the next, I'll send the Exynos5433's patchset and board dts file.

Best Regards,
Chanwoo Choi
