From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Apr 2018 10:10:27 +0800
Subject: [linux-sunxi] [PATCH v2 00/10] Allwinner H3 DVFS support
In-Reply-To: <CAGb2v67FaU3_su9XGaGj4zVSoAnpfN8cAhbBHEJu3Owt=Qicmg@mail.gmail.com>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <CAGb2v67FaU3_su9XGaGj4zVSoAnpfN8cAhbBHEJu3Owt=Qicmg@mail.gmail.com>
Message-ID: <CAGb2v64zj=DHW2ta9d7=SGGbE2BZUeigJw=NqJMUfK0aV9+Aow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 12:41 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> On Tue, Feb 6, 2018 at 12:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> This patchset tries to add DVFS support for Allwinner H3 SoC,
>> considering two kinds of adjustable regulators used on H3 boards:
>> SY8106A I2C-controlled regulator and SY8113B regulator (controllable
>> by GPIO with some special designs on the board), and also taking the
>> uncontrollable boards into consider.
>>
>> PATCH 1 and PATCH 2 are for the SY8106A regulator, then PATCH 3 and
>> PATCH 4 are for the r_i2c bus, which is used by boards with SY8106A
>> to communicate with the regulator.
>>
>> PATCH 5 adds the operating points v2 table to the H3 SoC, but with
>> OPPs higher than 1008MHz temporarily dropped.
>>
>> Then there's patches for several tested boards: Orange Pi PC (with
>> SY8106A), Orange Pi One/Zero (with GPIO-adjustable SY8113B) and
>> ALL-H3-CC (unadjustable).
>>
>> Icenowy Zheng (5):
>>   ARM: sun8i: h3: add operating-points-v2 table for CPU
>>   ARM: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board
>>   ARM: sun8i: h3: add SY8113B regulator used by Orange Pi One board
>>   ARM: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage
>>   ARM: sun8i: h3: set the cpu-supply to VDD-CPUX on ALL-H3-CC H3 ver
>>
>> Ondrej Jirman (5):
>>   dt-bindings: add binding for the SY8106A voltage regulator
>>   regulator: add support for SY8106A regulator
>>   ARM: sunxi: h3/h5: Add r_i2c pinmux node
>>   ARM: sunxi: h3/h5: Add r_i2c I2C controller
>>   ARM: sun8i: h3: Add SY8106A regulator to Orange Pi PC

Dropped this patch at your request. The rest will be in -next.

ChenYu

>
> I've applied all the device tree patches for 4.18, taking into account
> comments from Maxime. See
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/h3-h5-for-4.17
>
> Mostly it's just renaming the regulator node names and labels.
>
> Please resend the first two patches to Mark Brown, the regulator
> subsystem maintainer. And you might want to mention the branch
> above in case he needs a use case reference.
>
> Regards
> ChenYu
