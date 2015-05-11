From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 May 2015 14:58:08 +0200
Subject: [PATCH v2 0/5] Add proper support for Compulab CM-A510/SBC-A510
In-Reply-To: <2740728.K6gusYnMDt@wuerfel>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <554A11D5.9060407@free-electrons.com> <2740728.K6gusYnMDt@wuerfel>
Message-ID: <5550A760.9080200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 06/05/2015 15:13, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 15:06:29 Gregory CLEMENT wrote:
>>
>> On 04/05/2015 22:08, Sebastian Hesselbarth wrote:
>>> This is v2 of the patch set to improve current mainline support for
>>> the Compulab CM-A510 System-on-Module (SoM) and its default Compulab
>>> SBC-A510 base board.
>>>
>>> Compared to v1 [1] there have been the overall changes:
>>> - Drop i2c-mux-pinctrl rework as Wolfram Sang raised concerns with
>>>   respect to OF_DYNAMIC. Instead we add i2c-mux-pinctrl node by
>>>   default and wait until corresponding driver respects disabled
>>>   sub-bus nodes. This will add 3 additional i2c busses to all
>>>   Dove based boards, but no functional change with respect to
>>>   i2c-0.
>>> - Split patches dealing with arch/arm/boot/dts/Makefile to route
>>>   them though arm-soc directly.
>>>
>>> Other patches of v1 have already been taken by MVEBU SoC maintainers
>>> as fixes.
>>>
>>> Patches are based on v4.1-rc1 and are intended for v4.2. All patches
>>> contain appropriate Acked-by's from related maintainers. Patches 3
>>> and 5 should go thought arm-soc directly, the rest can go though
>>> mvebu tree.
>>
>> Usually even the change of the arch/arm/boot/dts/Makefile go to
>> arm-soc through mvebu. For patch 5 it makes sens because if the series
>> is spited then the Makefile could be merged before the new file
>> to build.
>>
>> So unless, Arnd or Olof really want to pick the patches 3 and 5 I will
>> apply the patches 2 to 5 on mvebu/dt.
>>
>> Arnd, Olof, do you agree?
> 
> Yes, please pick up all the patches and send them to us with your
> normal pull requests.

patches 2 to 5 applied on mvebu/dt

Thanks,

Gregory


> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
