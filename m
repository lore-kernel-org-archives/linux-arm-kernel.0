From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 Jun 2016 08:37:15 -0700
Subject: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
In-Reply-To: <5763EF68.1040307@ti.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <5763EF68.1040307@ti.com>
Message-ID: <CAD=FV=XK=YTyj=yfZ2bXq-W2OeEFi+h3X0SypXmLqVaEmNf5bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

On Fri, Jun 17, 2016 at 5:39 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 14 June 2016 04:34 AM, Douglas Anderson wrote:
>> The theme of this series of patches is to try to allow running the eMMC
>> at 150 MHz on the rk3399 SoC, though the changes should still be correct
>> and have merit on their own.  The motivation for running at 150 MHz is
>> that doing so improves signal integrity and (with some eMMC devices)
>> doesn't affect throughput.
>>
>> These patches have been structured to keep things as separate as
>> possible, but nevertheless there are still some dependencies between
>> patches.  It probably makes the most sense for all of the non-device
>> tree patches to go through a single tree.  If others agree, perhaps the
>> most sane would be to get Acks from PHY maintainers and then to land the
>> patches in the MMC tree.  Device tree patches should be able to be
>> landed separately and the worst what would happen is a warning in the
>> kernel log if you have the code without the device tree.
>>
>> The code patches are based on Ulf's mmc-next, then 4 patches that are
>> outstanding / ready to land.  Specifically:
>> - https://patchwork.kernel.org/patch/9086501/
>>   phy: rockchip-emmc: give DLL some extra time to be ready
>> - https://patchwork.kernel.org/patch/9093681/
>>   phy: rockchip-emmc: configure frequency range and drive impedance
>> - https://patchwork.kernel.org/patch/9086511/
>>   phy: rockchip-emmc: configure default output tap delay
>> - https://patchwork.kernel.org/patch/9086531/
>>   phy: rockchip-emmc: reindent the register definitions
>
> Do you want all these "phy: rockchip-emmc:" along with the patch in this series
> to go in MMC tree? Or I can take all the phy part in my linux-phy -next branch?

If Ulf is amenable, I was hoping that these could all go through the
MMC tree with your blessing.  ...then "dts" patches would go through
Heiko's tree.

-Doug
