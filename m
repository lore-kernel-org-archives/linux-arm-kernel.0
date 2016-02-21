From: hs@denx.de (Heiko Schocher)
Date: Sun, 21 Feb 2016 10:27:49 +0100
Subject: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
In-Reply-To: <20160219170404.GH21202@atomide.com>
References: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
 <20160219170404.GH21202@atomide.com>
Message-ID: <56C98315.1000707@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony, Peter,

Am 19.02.2016 um 18:04 schrieb Tony Lindgren:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160219 06:14]:
>> This reverts commit 8e6ebfaa9b384088002baa10f7534efa73a0794e.
>>
>> Without the patch reverted regulators will not work. This prevents
>> MMC to be working for example so the boards can not boot to
>> MMC rootfs.
>>
>> Tested it on beaglebone white and bisect also points to the
>> reverted commit.
>> The issue can be also fixed by adding "regulator-compatible =" to all board
>> dts file for the regulators.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> I have noticed that bbw did not find the MMC with linux-next, but it turns out
>> that even 4.5-rc4 is behaving the same way.
>> I have run bisect and with this revert patch I can boot up fine.
>> To be honest I don't know why the tps65217.dtsi has been deleted in the first
>> place.
>
> I think initially the only real issue was the naming. The
> tps65217.dtsi file should be just renamed to tps65217-am335x.dtsi
> to make it clear that this configuration is commonly used for
> most am335x boards.
>
> I'll apply this revert into omap-for-v4.5/fixes as it fixes a
> regression.

Sorry for breaking ... but I have no bbw hw for testing ...
(This is maybe a reason for having something like an automated
  testsystem, see an example/proposal here:

https://github.com/hsdenx/tbot

see a demo for automated tests (running on a raspberry pi at my home
in hungary, boards are in munich/germany)
http://xeidos.ddns.net/buildbot/tgrid
)

But I removed this file as Mark Brown suggested it, see:

https://lkml.org/lkml/2015/10/21/581

So please introduce a "tps65217-am335x.dtsi" file ... Mark?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
