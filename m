From: m.reichl@fivetechno.de (Markus Reichl)
Date: Fri, 21 Jul 2017 11:26:02 +0200
Subject: USB 3.0 is broken on Odroid Xu4 on latest kernel
In-Reply-To: <CANAwSgSoo7g=RN4wQ96+NJRYZYy2WeHwPA-xJ2JY7yt25irDfA@mail.gmail.com>
References: <CANAwSgSoo7g=RN4wQ96+NJRYZYy2WeHwPA-xJ2JY7yt25irDfA@mail.gmail.com>
Message-ID: <29c0eb80-f880-ce45-8dfd-0e148b278a1b@fivetechno.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

the issue below is fixed with 
4.13.0-rc1-next-20170721.

Gru?,
-- 
Markus Reichl

Am 19.07.2017 um 16:58 schrieb Anand Moon:
> Hi Krzysztof,
> 
> Today I tried to compile the latest kernel for Odroid xu4.
> using exynos_defconfig I build and loaded the kernel.
> but to my surprise usb 3.0 device and missing.
> 
> odroid login: root
> Password:
> Last login: Wed Jul 19 14:01:44 UTC 2017 on ttySAC2
> Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.13.0-rc1-xu4ml-27846-g74cbd96 armv7l)
> 
>  * Documentation:  https://help.ubuntu.com
>  * Management:     https://landscape.canonical.com
>  * Support:        https://ubuntu.com/advantage
> root at odroid:~# lsusb
> Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 002: ID 0603:0002 Novatek Microelectronics Corp.
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> root at odroid:~# lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
>     |__ Port 1: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
>     |__ Port 1: Dev 2, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
> 
> Full dmesg can be found on blow link.
> https://pastebin.com/K3xfPCPe
> 
> The reason for failed is below.
> 
> [    7.187096] usb usb4-port1: connect-debounce failed
> 
> I tried to debug this but failed to find the root cause.
> Nothing is connected to the UBS 3.0 port for the failure to cause.
> 
> If I load old kernel it seen to work correctly.
> If you provoid some input I will give this a try.
> 
> Best Regards
> -Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
