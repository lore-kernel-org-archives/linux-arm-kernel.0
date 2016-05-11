From: serveralex@gmail.com (=?utf-8?Q?Alexander_M=C3=BCller?=)
Date: Wed, 11 May 2016 20:27:02 +0200
Subject: [PATCH 0/6] Enable ethernet support on Amlogic meson8b /
 Hardkernel ODROID-C1
In-Reply-To: <m2eg989b27.fsf@baylibre.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
 <m2eg989b27.fsf@baylibre.com>
Message-ID: <7BE15397-BC3A-49D2-9FB3-6086BDB8E31E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sure. I separated the clock patches and sent them to the linux-clk mailing list:

http://permalink.gmane.org/gmane.linux.kernel.clk/6398

Alex

> On 11 May 2016, at 11:52, Kevin Hilman <khilman@baylibre.com> wrote:
> 
> Alexander M?ller <serveralex@gmail.com> writes:
> 
>> This patch series fixes a glitch in the pinctrl driver, adds clock gates
>> support and configures ethernet support via stmmac.
>> 
>> The previously sent patch "pinctrl: meson: Fix eth_tx_en bit index" is
>> also included in this patch series.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> I tested ethernet support on my odroidc1 with an NFS root and things are
> working well.
> 
> Alexander, could you separate out the clock patches and (re)send them
> making sure to copy the linux-clk list so the clock maintainers are sure
> to see them?  Thanks.
> 
> Kevin
> 
>> 
>> Alexander M?ller (6):
>>  pinctrl: meson: Fix eth_tx_en bit index
>>  ARM: DTS: Amlogic: Add ethernet pins
>>  ARM: clk: Amlogic: Add support for clock gates
>>  ARM: clk: Amlogic: Add clk81 clock gates
>>  ARM: DTS: Amlogic: Enable ethernet on meson8b
>>  ARM: DTS: Amlogic: Enable ethernet on ODROID-C1
>> 
>> arch/arm/boot/dts/meson8b-odroidc1.dts   |  10 ++
>> arch/arm/boot/dts/meson8b.dtsi           |  25 ++++
>> drivers/clk/meson/clkc.c                 |  18 +++
>> drivers/clk/meson/clkc.h                 |  18 +++
>> drivers/clk/meson/meson8b-clkc.c         | 196 +++++++++++++++++++++++++++++++
>> drivers/pinctrl/meson/pinctrl-meson8b.c  |   2 +-
>> include/dt-bindings/clock/meson8b-clkc.h |  99 +++++++++++++++-
>> 7 files changed, 365 insertions(+), 3 deletions(-)
