From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 24 Nov 2014 23:16:12 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <CAOMZO5DZSxeTC9fKYXk6XBAG-03qW+TM_8HS_3M8Mkbd-iEdzg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201406182220.22818@pali>
 <CAOMZO5DZSxeTC9fKYXk6XBAG-03qW+TM_8HS_3M8Mkbd-iEdzg@mail.gmail.com>
Message-ID: <201411242316.12215@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 23:53:00 Fabio Estevam wrote:
> On Wed, Jun 18, 2014 at 5:20 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> > So how to read Revision and Serial number in DT based
> > kernel?
> 
> $ cat /sys/bus/soc/devices/soc0/soc_id
> i.MX6SX
> 
> $ cat /sys/bus/soc/devices/soc0/revision
> 1.0
> 
> $ cat /sys/bus/soc/devices/soc0/machine
> Freescale i.MX6 SoloX SDB Board

This does *not* working with DT based boot!

$ cat /sys/bus/soc/devices/soc0/soc_id
cat: can't open '/sys/bus/soc/devices/soc0/soc_id': No such file or directory
$ cat /sys/bus/soc/devices/soc0/revision 
ES3.1
$ cat /sys/bus/soc/devices/soc0/machine 
OMAP3430/3530


Here is output from *non* DT based boot:

# busybox cat /proc/cpuinfo 
processor       : 0
model name      : ARMv7 Processor rev 3 (v7l)
Features        : swp half thumb fastmult vfp edsp thumbee neon 
vfpv3 tls vfpd32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc08
CPU revision    : 3

Hardware        : Nokia RX-51 board
Revision        : 0012
Serial          : 0000000000000000


As you can see in those files are totally *different* values.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/835bc0cb/attachment.sig>
