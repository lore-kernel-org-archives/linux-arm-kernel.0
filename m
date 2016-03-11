From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 11 Mar 2016 22:48:36 +0800
Subject: [PATCH 0/6] arc_emac: fixes the emac issues oand cleanup emac
 drivers
In-Reply-To: <56E2CC39.6050907@cogentembedded.com>
References: <1457693731-6966-1-git-send-email-wxt@rock-chips.com>
 <56E2CC39.6050907@cogentembedded.com>
Message-ID: <56E2DAC4.4020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

? 2016?03?11? 21:46, Sergei Shtylyov ??:
> Hello.
>
> On 3/11/2016 1:55 PM, Caesar Wang wrote:
>
>> This series patches are based on kernel 4.5-rc7+ version.
>> Linux version 4.5.0-rc7-next-20160310+ (wxt at nb) (...) #23 SMP Fri Mar 
>> 11 15:55:53
>
> [...]
>
>> 1) This series has 6 patches: (1--->6)
>> net: arc_emac: make the rockchip emac document more compatible
>> net: arc_emac: add phy-reset-* are optional for device tree
>
>    I'm not seeing these patches on netdev...

Sent by the patman tool.

LKML:
https://patchwork.kernel.org/patch/8564501/
https://patchwork.kernel.org/patch/8564511/

>
>> net: arc_emac: support the phy reset for emac driver
>> net: arc: trivial: cleanup the emac driver
>> clk: rockchip: rk3036: fix and add node id for emac clock
>> ARM: dts: rockchip: add support emac for RK3036
>>
>> 2) This series patches have the following decriptions:
>
>    Descriptions.
>
>> Hi Rob, David:
>> PATCH[1/6-2/6]: ====>
>> net: arc_emac: make the rockchip emac document more compatible
>> net: arc_emac: add phy-reset-* are optional for device tree
>>
>> The patches change the rockchip emac document for more compatible and
>> Add the phy-reset-* property for document.
>>
>> This patch adds the following property for arc_emac.
>>
>> phy-reset-* include the following:
>> 1) phy-reset-gpios:
>> The phy-reset-gpios is an optional property for arc emac device tree 
>> boot.
>> Change the binding document to match the driver code.
>>
>> 2) phy-reset-duration:
>> Different boards may require different phy reset duration. Add property
>> phy-reset-duration for device tree probe, so that the boards that need
>> a longer reset duration can specify it in their device tree.
>>
>> 3) phy-reset-active-high:
>> We need that for a custom hardware that needs the reverse reset 
>> sequence.
>
>    Why not infer this from the "phy-reset-gpios" prop?

See:
https://patchwork.kernel.org/patch/8564511/

phy-reset-active-high : If present then the reset sequence using the GPIO
  specified in the "phy-reset-gpios" property is reversed (H=reset state,
  L=operation state).


Thanks,

Caesar

>
> MBR, Sergei
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
