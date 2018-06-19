From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Jun 2018 15:22:47 +0100
Subject: next/master boot: 138 boots: 8 failed, 112 passed with 18 offline
 (next-20180619)
In-Reply-To: <20180619141324.GD11230@sirena.org.uk>
References: <5b290c6d.1c69fb81.fc936.98ee@mx.google.com>
 <20180619141324.GD11230@sirena.org.uk>
Message-ID: <69c0adb9-b784-4f73-fcc9-ff1a01ce27c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/06/18 15:13, Mark Brown wrote:
> On Tue, Jun 19, 2018 at 07:00:13AM -0700, kernelci.org bot wrote:
> 
> Today and yesterday's -next is failing to boot on rk3399-firefly in two
> configs:
> 
>>     defconfig:
>>         rk3399-firefly:
>>             lab-baylibre-seattle: failing since 1 day (last pass: next-20180615 - first fail: next-20180618)
> 
>>     defconfig+CONFIG_RANDOMIZE_BASE=y:
>>         rk3399-firefly:
>>             lab-baylibre-seattle: failing since 1 day (last pass: next-20180615 - first fail: next-20180618)
> 
> The log ends with:
> 
> [    2.629278] SWITCH_REG2: supplied by vcc3v3_sys
> [    2.633030] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> [    2.633723] fan53555-reg: supplied by vcc_sys
> [    2.6353|] Internal error: undefined instruction: 0 [#1] PREEMPT SMP
> 
> which is rather entertaining. 
> 

Based on the logs from successful boots, I see it's CPUFreq that gets
probed after fan53555-reg. I also see that it warns about unlisted OPPs
in the successful boots. I guess, the undefined instruction could occur
if there's issue with CPU DVFS(under voltage or frequency that's not
supported). I don't have much knowledge on the platform, I am just
guessing on the possible cause here.

-- 
Regards,
Sudeep
