From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 3 Dec 2015 19:01:00 +0800
Subject: [PATCH 3/3] ARM: dts: rockchip: add veyron-minnie board
In-Reply-To: <3359424.qNn8gsFXpA@diego>
References: <2767415.mEkgRbSSUB@diego> <2008536.lEUHWtryIT@diego>
 <5660190F.6080204@163.com> <3359424.qNn8gsFXpA@diego>
Message-ID: <566020EC.7060606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2015?12?03? 18:44, Heiko St?bner ??:
> Hi Caesar,
>
> Am Donnerstag, 3. Dezember 2015, 18:27:27 schrieb Caesar Wang:
>> ? 2015?12?02? 01:16, Heiko St?bner ??:
>>> From: Chris Zhong <zyw@rock-chips.com>
>>>
>>> Also known as the Asus Chromebit.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
>> Tested-by: Caesar Wang <wxt@rock-chips.com>
> thanks :-)
>
>
>> Tested on my mickey board with chrome os on kernel 4.4 -rc3.
>>
>> localhost / # cat /proc/version
>> Linux version 4.4.0-rc3+ (wxt at ubuntu) (gcc version 4.6.x-google 20120106
>> (prerelease) (GCC) ) #59 SMP Thu Dec 3 17:32:10 CST 2015
>>
>> .....but,
>> reboot long long test, that's seem mmc tune has a issue.
>>
>>     2.630892] mmcblk0: error -84 transferring data, sector 0, nr 8, cmd
>> response 0x900, card status 0x0
>> [    2.631006] mmcblk0: error -110 sending status command, retrying
>> [    2.631018] mmcblk0: error -84 transferring data, sector 1, nr 7, cmd
>> response 0x900, card status 0x0
>> [    2.631703]  mmcblk0: unable to read partition table
>> ...
> Could you try if what we do on Minnie fixes that error (disabling tuning for
> now) - i.e. adding the following to the Mickey dts:
>
> &emmc {
> 	/delete-property/mmc-hs200-1_8v;
> };
>
>

Yep, maybe we remove this node firstly but someone fix the emmc tune issues.

>> Anyway, the dts is good to support mickey machine.
>> I think the mmc tune is not prefect in mainline.
> yeah, it seems we still have some issues.
>
> Although it seems only the disney-mice seem affected ;-) [minnie and mickey].
> Pinky, Brain, Speedy, Jaq all seem to work somehow - at least I haven't gotten
> any reports about that

Cc shawn,
Maybe,  Shawn at RK has the interesting in debuging this issue.:-)



>
> Thanks
> Heiko
>


-- 
caesar wang | software engineer | wxt at rock-chip.com
