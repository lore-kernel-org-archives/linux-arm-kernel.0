From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 29 Jan 2016 23:28:25 +0300
Subject: [PATCH] ARM: dts: porter: add MAX3355 support
In-Reply-To: <SG2PR06MB0919D09C1146EAC0681EE109D8DA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <4506196.xOgpYRO52t@wasted.cogentembedded.com>
 <SG2PR06MB0919D09C1146EAC0681EE109D8DA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Message-ID: <56ABCB69.1070800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/28/2016 08:49 AM, Yoshihiro Shimoda wrote:

>> From: linux-renesas-soc-owner at vger.kernel.org [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Sergei
>> Shtylyov
>> Sent: Wednesday, January 27, 2016 7:14 AM
>>
>> Now that Maxim Integrated MAX3355 'extcon' driver and device tree bindings
>> are upstream along with the 'extcon' hook  in the Renesas USBHS driver, we
>> can add  MAX3355 device node to  the Porter device tree and properly refer
>> to it from the USBHS node instead of using  "renesas,enable-gpio" property
>> which only allowed checking the USB ID pin  at the driver probe time;  now
>> this  pin's  state can be monitored dynamically!
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> I tested this patch on Porter, but interrupt of "usb-otg" didn't happened
> even if I connected/disconnected a usb convert cable (usb micro-ab to A).
> Remarks: I confirmed that the usb convert cable worked correctly on other board.

    I guess I have the same cable and IRQs do happen for me when I connect and 
disconnect it (as it should be).

> Do I need other settings for this?

    No evident answer to that, your logs show that MAX3355 driver was enabled...

> root at 192:~# cat /proc/interrupts | grep usb
> 108:          0     GIC-0 139 Level     e6590000.usb
> 118:          1     GIC-0 140 Level     ehci_hcd:usb1, ohci_hcd:usb3
> 119:          0     GIC-0 145 Level     ehci_hcd:usb2, ohci_hcd:usb4
> 308:          0  e6055000.gpio  31 Edge      usb-otg
> root at 192:~#
> root at 192:~# cat /proc/interrupts | grep usb
> 108:          0     GIC-0 139 Level     e6590000.usb
> 118:          1     GIC-0 140 Level     ehci_hcd:usb1, ohci_hcd:usb3
> 119:          0     GIC-0 145 Level     ehci_hcd:usb2, ohci_hcd:usb4
> 308:          0  e6055000.gpio  31 Edge      usb-otg
> root at 192:~#
> root at 192:~# cd /sys/class/extcon/extcon0
> root at 192:/sys/class/extcon/extcon0# cat state
> USB=1
> USB-HOST=0

    I guess these states doesn't change even if you insert your cable?
They also do change for me.

> Best regards,
> Yoshihiro Shimoda

MBR, Sergei
