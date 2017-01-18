From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jan 2017 10:30:55 +0530
Subject: odroid xu4:pinctrl and gpio mapping for usb 3.0
Message-ID: <CANAwSgSsXXuFjK6ckyYBNCqwAp6KS1V+LwMBMNkzW90BxUxpAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I tried to find the link between pinctrl and internal gpio for usb 3.0 ports
from the schematics, but I could not find valuable input.

I tired to map the internal gpio pins to gather information on
id-gpio and vbus-gpio pins, but it was no luck.

I tried to debug the phy-exynos5-usbdrd.c and the vbus regulator
input is missing, but with no correct input on internal gpio and pinctrl
so it hard to map this correctly.

Is their some thing missing configuration.

Their are some issues into the phy-exynos5-usbdrd.c
with respect to exynos5_usbdrd_phy_exit not getting called
on the warm boot which leads to usb ports not getting reset.

Please share me some input on improve the power on usb 3.0 ports

odroid at odroidxu4n:~$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
        |__ Port 2: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 2: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M

root at odroidxu4n:~# lsusb -v|egrep "^Bus|MaxPower"
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    MaxPower                0mA
Bus 005 Device 002: ID 0bda:8153 Realtek Semiconductor Corp.
    MaxPower              180mA
    MaxPower              180mA
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA
Bus 004 Device 003: ID 174c:5106 ASMedia Technology Inc. ASM1051 SATA
3Gb/s bridge
    MaxPower                0mA
Bus 004 Device 002: ID 05e3:0616 Genesys Logic, Inc. hub
    MaxPower                0mA
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    MaxPower                0mA
Bus 003 Device 004: ID 04b4:00f8 Cypress Semiconductor Corp.
    MaxPower              500mA
Bus 003 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
    MaxPower              100mA
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
    MaxPower                0mA
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA

-Best Regards
Anand Moon
