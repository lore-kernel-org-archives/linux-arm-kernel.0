From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 14:50:32 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: fix uart1 CTS/RTS pins at PG on
 A23/A33
In-Reply-To: <20160823064755.GA2598@lukather>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
 <20160823064755.GA2598@lukather>
Message-ID: <652921471935032@web14j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



23.08.2016, 14:47, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Tue, Aug 23, 2016 at 01:58:25PM +0800, Icenowy Zheng wrote:
>> ?PG8, PG9 is said to be the CTS/RTS pins for UART1 according to the A23/33
>> ?datasheets. However, the function is wrongly named "uart2" in the pinctrl
>> ?driver. This patch fixes this by modifying them to be named "uart1".
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> This looks good, but could you send it to stable?

Yes... But currently in mainline kernel, no dt file for A23/33 uses UART1.
(Lots of the tablets is so low-end that they do not ship with BT support, and
then no support for extra UART is needed)

I found the problem when running mainline kernel on my iNet D978 Rev2 board
tablet. It come with a RTL8723BS.

>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
