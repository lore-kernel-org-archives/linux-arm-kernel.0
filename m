From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 24 May 2012 13:00:08 +0200
Subject: [ehci-mxc] USB stopped working in i.MX27 based Visstrim_M10 board.
Message-ID: <CACKLOr2h+a6NYRQn4gJ5A5dQ_b2hRbM+NYpt22Yh674+rBUvKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
in kernel 3.4 USB doesn't work anymore in Visstrim_M10 board. It is
based on an i.MX27 chip and this is the log I get when connecting an
UVC webcam:

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
mxc-ehci mxc-ehci.0: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.0: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.0: reset hcs_params 0x10011 dbg=0 ind cc=0 pcc=0
ordered ports=1
mxc-ehci mxc-ehci.0: reset hcc_params 0006 thresh 0 uframes 256/512/1024 park
mxc-ehci mxc-ehci.0: park 0
mxc-ehci mxc-ehci.0: reset command 0080002 (park)=0 ithresh=8
period=1024 Reset HALT
mxc-ehci mxc-ehci.0: ...powerdown ports...
mxc-ehci mxc-ehci.0: irq 56, io mem 0x10024000
mxc-ehci mxc-ehci.0: init command 0010005 (park)=0 ithresh=1 period=512 RUN
mxc-ehci mxc-ehci.0: USB 2.0 started, EHCI 1.00
usb usb1: default language 0x0409
usb usb1: udev 1, busnum 1, minor = 0
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 3.4.0-00005-gf095ebc ehci_hcd
usb usb1: SerialNumber: mxc-ehci.0
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
rtc-ds1307 0-0068: rtc core: registered m41t00 as rtc0
i2c /dev entries driver
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
mx2-camera mx2-camera.0: Camera driver attached to camera 0
tvp5150 0-005d: chip found @ 0xba (imx-i2c)
mxc-ehci mxc-ehci.0: GetStatus port:1 status 80001803 64  ACK POWER
sig=j CSC CONNECT
hub 1-0:1.0: port 1: status 0101 change 0001
tvp5150 0-005d: *** unknown tvp5151 chip detected.
tvp5150 0-005d: *** Rom ver is 1.0
hub 1-0:1.0: state 7 ports 1 chg 0002 evt 0000
hub 1-0:1.0: port 1, status 0101, change 0000, 12 Mb/s
usb 1-1: new high-speed USB device number 2 using mxc-ehci
mx2-camera mx2-camera.0: Camera driver detached from camera 0
mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock
frequency: 6250000
m2m-deinterlace m2m-deinterlace.0: mem2mem-deinterlace Device
registered as /dev/video1
i.MX SDHC driver
Registered led device: visstrim:ld0
Registered led device: visstrim:ld1
Registered led device: visstrim:ld2
Registered led device: visstrim:ld3
mxc-ehci mxc-ehci.0: port 1 high speed
mxc-ehci mxc-ehci.0: GetStatus port:1 status 88001205 68  ACK POWER
sig=se0 LPM PE CONNECT
asoc: tlv320aic32x4-hifi <-> imx-ssi.0 mapping ok
TCP: cubic registered
NET: Registered protocol family 17
input: gpio-keys as /devices/platform/gpio-keys/input/input0
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 1
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 2
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 3
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 4
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 5
rtc-ds1307 0-0068: setting system clock to 2012-05-24 10:45:41 UTC (1337856341)
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 6
ALSA device list:
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 7
  #0: visstrim_m10-audio
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 8
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 9
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 10
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 11
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 12
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 13
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 14
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 15
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 16
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 17
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 18
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 19
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 20
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 21
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 22
VFS: Mounted root (squashfs filesystem) readonly on device 31:2.
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 23
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 24
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 25
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 26
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 27
devtmpfs: mounted
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 28
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 29
Freeing init memory: 104K
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 30
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 31
mxc-ehci mxc-ehci.0: devpath 1 ep0in 3strikes
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 1
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 2
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 3
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 4
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 5
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 6
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 7
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 8
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 9
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 10
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 11
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 12
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 13
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 14
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 15
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 16
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 17
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 18
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 19
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 20
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 21
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 22
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 23
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 24
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 25
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 26
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 27
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 28
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 29
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 30
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 31
mxc-ehci mxc-ehci.0: devpath 1 ep0in 3strikes
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 1
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 2
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 3
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 4
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 5
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 6
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 7
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 8
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 9
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 10
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 11
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 12
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 13
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 14
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 15
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 16
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 17
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 18
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 19
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 20
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 21
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 22
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 23
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 24
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 25
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 26
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 27
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 28
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 29
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 30
mxc-ehci mxc-ehci.0: detected XactErr len 0/8 retry 31
mxc-ehci mxc-ehci.0: devpath 1 ep0in 3strikes
usb 1-1: device descriptor read/all, error -71
mxc-ehci mxc-ehci.0: port 1 high speed
mxc-ehci mxc-ehci.0: GetStatus port:1 status 80001805 64  ACK POWER
sig=j PE CONNECT
usb 1-1: new full-speed USB device number 3 using mxc-ehci
eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=imx27-fec-1:1b, irq=-1)
PHY: imx27-fec-1:1b - Link is Up - 100/Full
usb 1-1: khubd timed out on ep0in len=0/64
usb 1-1: khubd timed out on ep0in len=0/64
usb 1-1: khubd timed out on ep0in len=0/64
usb 1-1: device descriptor read/64, error -110
usb usb1: clear tt buffer port 1, a0 ep0 t00080a88
usb 1-1: khubd timed out on ep0in len=0/64
usb usb1: clear tt buffer port 1, a0 ep0 t00000000
usb 1-1: khubd timed out on ep0in len=0/64
usb 1-1: khubd timed out on ep0in len=0/64
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full-speed USB device number 4 using mxc-ehci
mx2-camera mx2-camera.0: Camera driver attached to camera 0
mx2-camera mx2-camera.0: Camera driver detached from camera 0
usb 1-1: khubd timed out on ep0out len=0/0
usb 1-1: khubd timed out on ep0out len=0/0
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full-speed USB device number 5 using mxc-ehci
usb 1-1: khubd timed out on ep0out len=0/0
usb 1-1: khubd timed out on ep0out len=0/0
usb 1-1: device not accepting address 5, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
# lsusb
Bus 001 Device 001: ID 1d6b:0002

What I find out is that this worked properly in kernel 3.0 and stopped
working in 3.1. Has anybody found something similar with an i.MX27
based board?

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
