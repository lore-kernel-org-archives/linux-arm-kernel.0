From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 20 Oct 2015 19:40:32 +0800
Subject: [PATCH v6 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <56260E06.2040902@osg.samsung.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
 <5624C896.8070108@osg.samsung.com> <5625A2A1.6090907@rock-chips.com>
 <56260E06.2040902@osg.samsung.com>
Message-ID: <56262830.4030201@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 10/20/2015 05:48 PM, Javier Martinez Canillas wrote:
> Hello Yakir,
>
> On 10/20/2015 04:10 AM, Yakir Yang wrote:
>> Hi Javier,
>>
>> On 10/19/2015 06:40 PM, Javier Martinez Canillas wrote:
>>> Hello Yakir,
>>>
>>> On 10/10/2015 05:35 PM, Yakir Yang wrote:
>>>> Hi all,
>>>>
>>>>      The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
>>>> share the same IP, so a lot of parts can be re-used. I split the common
>>>> code into bridge directory, then rk3288 and exynos only need to keep
>>>> some platform code. Cause I can't find the exact IP name of exynos dp
>>>> controller, so I decide to name dp core driver with "analogix" which I
>>>> find in rk3288 eDP TRM :)
>>>>
>>>> But  there are still three light registers setting differents bewteen
>>>> exynos and rk3288.
>>>> 1. RK3288 have five special pll resigters which not indicata in exynos
>>>>      dp controller.
>>>> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>>>>      between rk3288 and exynos.
>>>> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>>>>      register).
>>>>
>>>> This series have been well tested on Rockchip platform with eDP panel
>>>> on Jerry Chromebook and Display Port Monitor on RK3288 board and thanks
>>>> to Javier at Samsung help me to find a way to install mainline kernel to
>>>> Samsung Exynos Chromebooks, so this series also have been tested on Samsung
>>>> Snow and Peach Pit Chromebooks which borrowed from my friends.
>>>>
>>>> Besides, This version was build on linux-next branch (tag next-20150918), and
>>>> the above test experiments also base on that tag. But I know the latest tag is
>>>> next-20151009, so i do rebase this series again on next-20151009, there were
>>>> little conflicts(exynos_dp removed the suspend/resume).
>>>>
>>>> But after I retest this series on next-20151009, I saw kernel crashed in mmc
>>>> driver(dw_mci_probe failed to get regulator). So i have to disabled the MMC
>>>> module(after all I boot with USB device), and I can see eDP light up normally
>>>> in startup stage, but kernel keep crashed when it try to mount the filesystem.
>>>> I thought this isn't related to dp driver directly, so i choice not to debug
>>>> more depth.
>>>>
>>>> That's to say if someone want to test this series, I suggest you applied this
>>>> series on tag-20150918, just need to fix some light conflicts with the 01 & 02
>>>> patches (or just email me, I can send you directly).
>>>>
>>>> Thanks,
>>> Do you have a branch that I can use to test this series?
>> Thank you for your kind assistance, I have created a tree which checkout from the next-20151019. Surely there were some conflicts to applied this series on that tag, but things still works for me, here is the git address [https://github.com/yakir-Yang/linux/tree/analogix_dp]
>>
> I tested your branch on an Exynos5800 Peach Pi Chromebook and display is
> working on boot. I also tested DPMS and S2R and things are still working
> so for the whole series feel free to add:
>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks a lot    ;)

- Yakir

>> Best regards,
>> - Yakir
>>
> Best regards,
