From: jacobchen110@gmail.com (=?UTF-8?B?6ZmI6LGq?=)
Date: Tue, 9 Aug 2016 17:28:53 +0800
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1815189.oGy6GHMbyM@phil>
References: <1549971.ctkvOGm2xW@diego> <2868781.4x2gJCRbLH@diego>
 <413ebccd-e8d6-1401-3065-f9a63b4d66e6@rock-chips.com>
 <1815189.oGy6GHMbyM@phil>
Message-ID: <CAFLEztQ1pa-CCbC8c8+VJ_kg8RyPOb-UHZiKBZffKEw9zyx9Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-07 22:44 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> Hi Shawn,
>
> Am Sonntag, 7. August 2016, 11:40:21 schrieb Shawn Lin:
>> On 2016/7/19 3:46, Heiko St?bner wrote:
>> > Am Montag, 18. Juli 2016, 23:32:32 schrieb Randy Li:
>> >> The Firefly RK3288 Reload is a combination Firefly rk3288 core board
>> >> with the Reload baseboard. Add a dtsi for the Firefly rk3288 core
>> >> which can be included into the dts for the various baseboards
>> >> in the future and dts for Reload base board.
>> >>
>> >> Currently supported are serial console, wired networking, eMMC and
>> >> SD storage, SPFIF, IR receiver, LEDs, SDIO wifi and USB. But only
>> >> the OTG could work on the host mode now, the other USB host can't
>> >> work now, additional patches are required.
>> >>
>> >> Signed-off-by: Randy Li <ayaka@soulik.info>
>> >> Acked-by: Rob Herring <robh@kernel.org>
>> >
>> > applied [0], after some minor reordering - please double check.
>> >
>> > Also, while the branch is named 4.8 this will only go into 4.9, as the
>> > merge- window supposedly opens on the weekend.
>>
>> Sorry for the noise here:), but I find there is some mmc stuff
>> which confuse me. Maybe Randy could elaborate more?
>>
>> Your sdmmc claims to support UHS-I mode like sd-uhs-sdr104, etc, which
>> will ask dw_mmc to switch vqmmc from 3V3 to 1V8 after sending CMD11.
>>
>> But the vqmmc is vccio_sd which is fixed as 3V3? :)
>
> so far we have only been able to achieve UHS speeds on devices based on the
> rk808 pmic (I had sucess on veyron and popmetal). The act8846-based boards
> seem to have some issue when trying to do the switch to 1.8V, resulting in
> mmc errors and the mmc-core switching back to 3.3V.
>
> I think this might be caused by a bug in the act8846 driver or some dts
> mistake. But so far nobody had the time and enthusiasm to investigate :-)
>
>
> Heiko

Hi all,
sdcard-supply must be specifed  in io-domains node to enable uhs.

io-domains {
compatible = "rockchip,rk3288-io-voltage-domain";
rockchip,grf = <&grf>;
sdcard-supply = <&vccio_sd>;
wifi-supply = <&vcc_18>;
};
