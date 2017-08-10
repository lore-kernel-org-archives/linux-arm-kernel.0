From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 10 Aug 2017 12:40:26 +0800
Subject: [linux-sunxi] [PATCH 1/3] arm64: allwinner: a64: add ethernet0
 alias for BPi M64 EMAC node
In-Reply-To: <CAGb2v64DVdFU37V422KfT5zUFN7c6dXyLFBukZegbAuUKZmJBA@mail.gmail.com>
References: <20170722022852.7868-1-icenowy@aosc.io>
 <20170722022852.7868-2-icenowy@aosc.io>
 <CAGb2v64DVdFU37V422KfT5zUFN7c6dXyLFBukZegbAuUKZmJBA@mail.gmail.com>
Message-ID: <660391B7-FD1B-44BC-98AF-4CA99DCEBB0B@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?8?10? GMT+08:00 ??11:56:02, Chen-Yu Tsai <wens@csie.org> ??:
>Hi,
>
>On Sat, Jul 22, 2017 at 10:28 AM, Icenowy Zheng <icenowy@aosc.io>
>wrote:
>> The Banana Pi M64 board uses the A64 chip's EMAC to provide Ethernet
>> link.
>>
>> Add the ethernet0 alias in the device tree, in order to let U-Boot
>> generate a MAC address from the chip's SID.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>As mentioned in the discussion of the cover letter of this series,
>we'd really like to move this to fixes for 4.13.
>
>I'd like to move forward on this soon. Can I just do a wholesale
>rewrite of the commit message along the lines of the following
>example, and move the 3 patches to fixes for 4.13?

Yes.

Thanks!

>
>arm64: allwinner: a64: bananapi-m64: add missing ethernet0 alias
>
>The EMAC Ethernet controller was enabled, but an accompanying alias
>was not added. This results in unstable numbering if other Ethernet
>devices, such as a USB dongle, are present. Also, the bootloader uses
>the alias to assign a generated stable MAC address to the device node.
>
>Fixes: e7295499903d ("arm64: allwinner: bananapi-m64: Enable
>dwmac-sun8i")
>
>
>Thanks
>ChenYu
