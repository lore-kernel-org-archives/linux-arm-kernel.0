From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 27 Jan 2016 10:04:18 -0800
Subject: 4.5-rc1 kernel is failed to bootup on FSL LS2080 RDB board
In-Reply-To: <VI1PR04MB123006EC1EECE3A064BDE40C88D90@VI1PR04MB1230.eurprd04.prod.outlook.com>
References: <56A80920.8030504@linaro.org>
 <VI1PR04MB123006EC1EECE3A064BDE40C88D90@VI1PR04MB1230.eurprd04.prod.outlook.com>
Message-ID: <56A906A2.7070504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/26/2016 10:27 PM, Bhupesh Sharma wrote:
> Hi,
>
>> From: Shi, Yang
>> Sent: Wednesday, January 27, 2016 5:33 AM
>
>> Hi folks,
>>
>> I tried to boot 4.5-rc1 kernel on my FSL LS2080 RDB (aka LS2085 RDB), but
>> it is failed silently. If I use the dtb file shipped with the SDK with
>> 4.5-rc1 kernel, I can get the serial console output, but it is failed to
>> detect PCI bus.
>>
>> If I use both kernel and dtb from the SDK, it works well.
>>
>> The bootloader information:
>>
>> U-Boot 2015.07-rc1Layerscape2-SDK+g7e8bad0 (Aug 27 2015 - 14:31:42)
>>
>> SoC:  LS2085E (0x87010010)
>> Clock Configuration:
>>          CPU0(A57):1600 MHz  CPU1(A57):1600 MHz  CPU2(A57):1600 MHz
>>          CPU3(A57):1600 MHz  CPU4(A57):1600 MHz  CPU5(A57):1600 MHz
>>          CPU6(A57):1600 MHz  CPU7(A57):1600 MHz
>>          Bus:      600  MHz  DDR:      1333.333 MT/s     DP-DDR:
>> 1333.333 MT/s
>> Reset Configuration Word (RCW):
>>          00: 40282830 40400040 00000000 00000000
>>          10: 00000000 00200000 00200000 00000000
>>          20: 00c12980 00002580 00000000 00000000
>>          30: 00000e0b 00000000 00000000 00000000
>>          40: 00000000 00000000 00000000 00000000
>>          50: 00000000 00000000 00000000 00000000
>>          60: 00000000 00000000 00027000 00000000
>>          70: 412a0000 00000000 00000000 00000000
>> Model: Freescale Layerscape 2085a RDB Board
>> Board: LS2085E-RDB, Board Arch: V1, Board version: D, boot from vBank: 4
>> FPGA: v1.18
>>
>> And, I have ARCH_LAYERSCAPE, CONFIG_PCIE_DW and CONFIG_PCI_LAYERSCAPE
>> enabled.
>>
>> Any hint is appreciated.
>>
>
> As Minghuan (our PCI developer, added in CC) suggested the reason is that uboot is for
> LS2085a but kernel dtb is for ls2080.
>
> Please apply the patch https://patchwork.kernel.org/patch/7767061/ and try again.

Thanks so much. That patch just solves the problem partially, I just 
found the layerscape pci host driver need recognize ls2085a compatible 
too. With the both fix, I can get the PCI work.

I already sent the patch to the mailing list.

Regards,
Yang

>
> Regards,
> Bhupesh
>
