From: rreedd555@gmail.com (takanobu watanabe)
Date: Tue, 10 Aug 2010 16:50:40 +0900
Subject: kernel2.6.34.1 headers_install did not make asm
Message-ID: <AANLkTi=E9nYU8nV2LiaaS2tENYThqb42rasDoohMKaC=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I try to build glibc2.7 for armv5teji.
When install headers,it shown INSTALL include/asm (32 files),but none.

tknv at Lenny55G:~/src/kernel-2.6.34/linux-2.6.34.1$ make ARCH=arm
CROSS_COMPILE=/home/tknv/
Tool/arm-none-linux-gnueabi/arm-2010q1/bin/arm-none-linux-gnueabi-
headers_install
  CHK     include/linux/version.h
  HOSTCC  scripts/unifdef
  INSTALL include/asm-generic (34 files)
  INSTALL include/drm (14 files)
  INSTALL include/linux/byteorder (2 files)
  INSTALL include/linux/can (4 files)
  INSTALL include/linux/dvb (8 files)
  INSTALL include/linux/hdlc (1 file)
  INSTALL include/linux/isdn (1 file)
  INSTALL include/linux/netfilter (59 files)
  INSTALL include/linux/netfilter_arp (2 files)
  INSTALL include/linux/netfilter_bridge (16 files)
  INSTALL include/linux/netfilter_ipv4 (14 files)
  INSTALL include/linux/netfilter_ipv6 (11 files)
  INSTALL include/linux/nfsd (6 files)
  INSTALL include/linux/raid (2 files)
  INSTALL include/linux/spi (1 file)
  INSTALL include/linux/sunrpc (1 file)
  INSTALL include/linux/tc_act (6 files)
  INSTALL include/linux/tc_ematch (4 files)
  INSTALL include/linux/usb (7 files)
  INSTALL include/linux/wimax (1 file)
  INSTALL include/linux (358 files)
  INSTALL include/mtd (5 files)
  INSTALL include/rdma (1 file)
  INSTALL include/scsi/fc (4 files)
  INSTALL include/scsi (4 files)
  INSTALL include/sound (8 files)
  INSTALL include/video (3 files)
  INSTALL include/xen (1 file)
  INSTALL include (0 file)
  INSTALL include/asm (32 files)
tknv at Lenny55G:~/src/kernel-2.6.34/linux-2.6.34.1$ ls include/
acpi         crypto     Kbuild  math-emu  net     rxrpc  trace
asm-generic  drm        keys    media     pcmcia  scsi   video
config       generated  linux   mtd       rdma    sound  xen
tknv at Lenny55G:~/src/kernel-2.6.34/linux-2.6.34.1$

I could not find asm in include dir.
By the way asm dir is required when configure glibc2.7 that why I need it.
And also I tried just change asm-generic name to asm then try build
glibc2.7, but It was not success yet.

Thanks
-- 
tknv/
