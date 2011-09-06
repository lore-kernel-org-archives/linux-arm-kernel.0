From: samgandhi9@gmail.com (Sam Gandhi)
Date: Tue, 6 Sep 2011 10:17:41 -0700
Subject: Help in running top of git on Freescale MX28 EVK board
Message-ID: <CAOdLEaq2_EcK+UKtbGQjCCCXm09Yc9T9SrG_XLj8KOsUODpLRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to boot top of git://linux-arm.org/linux-2.6.git on
Freescale MX28 EVK board.
However I am unable to get any output on serial console.

I have attached the .config file that I am using to build this kernel
if there is a mistake I have done in selecting the configuration. I
have enabled CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK and I don't see
any output on console after kernel start. I have attached the console
output below

However on the same board I am able to boot 2.6.35 kernel that
freescale ships, using the same u-boot and command line arguments,
which are shown below.

console=ttyAM0,115200
ip=192.168.137.1:192.168.137.254:255.255.255.255:255.255.255.0
root=/dev/nfs nfsroot=192.168.137.254:/tftpboot/boot/,v3,tcp

I would appreciate pointer to correct .config file to use for
Freescale MX28 EVK board.


PowerPrep start initialize power...
Battery Voltage = 4.22V
5v source detected.Valid battery
voltage detected.Booting from battery
voltage .
Sep  2 201110:29:34
FRAC 0x92925552
memory type is DDR2
Wait for ddr ready 1power 0x00820616
Frac 0x92925552
start change cpu freq
hbus 0x00000003
cpu 0x00010001
start test memory accress
ddr2 0x40000000
finish simple test
MACH type is 2531


U-Boot 2009.08-svn46031 (Sep 02 2011 - 10:32:17)

Freescale i.MX28 family
CPU:   454 MHz
BUS:   151 MHz
EMI:   205 MHz
GPMI:   24 MHz
DRAM:  128 MB
MMC:   IMX_SSP_MMC: 0, IMX_SSP_MMC: 1
In:    serial
Out:   serial
Err:   serial
Net:   got MAC address from IIM: 00:04:9f:01:7e:d5
FEC0
Warning: FEC0 MAC addresses don't match:
Address in SROM is         00:04:9f:01:7e:d5
Address in environment is  00:c0:8a:88:73:73

Hit any key to stop autoboot:  0
Using FEC0 device
TFTP from server 192.168.137.254; our IP address is 192.168.137.1
Filename 'boot/uImage'.
Load address: 0x42000000
Loading: FEC: Link is down 7809
T #################################################################
         #################################################################
         ##
done
Bytes transferred = 1932328 (1d7c28 hex)
## Booting kernel from Legacy Image at 42000000 ...
   Image Name:   Linux-3.1.0-rc1-07628-g8399b33-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1932264 Bytes =  1.8 MB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.


Regards,
-Sam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 33126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110906/54cd0552/attachment-0001.obj>
