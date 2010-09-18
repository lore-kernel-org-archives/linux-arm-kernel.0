From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 18 Sep 2010 12:19:38 +0200
Subject: [Openpxa-users] colibri pxa320 NAND errors
In-Reply-To: <201009161827.04823.pieterg@gmx.com>
References: <201009161827.04823.pieterg@gmx.com>
Message-ID: <201009181219.38933.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 16. z??? 2010 18:27:04 pieterg napsal(a):
> Hi all,
> 
> I guess there are a few colibri 320 users on this list, I'd like to hear
> your experiences with the NAND flash.
> 
> I'm getting a whole lot of single bit errors, and also many double bit
> errors. As a result, my filesystem gets corrupted, even after a single
> reboot.
> I'm using jffs2, but tried ubifs as well (to rule out jffs2 bugs), with
> even worse results.
> 
> The situation is the same for colibri boards pxa310 V1.30A, pxa320 V1.2E,
> V1.2F.
> These use similar types of flash (Samsung K9F4G08U0A, K9K8G08U0A,
> K9K8G08U0B).
> Tried different boards, to rule out some incidental error.
> 
> I'm not 100% convinced it's a hardware issue, because when I write a
> (jffs2) image with u-boot, I can boot it without any errors.
> Only after the first reboot, after some modifications have been made to the
> filesystem, everything gets messy (see a kernel console snippet below)
> 
> So you might think it's a kernel bug.
> I'm using the latest devel branch from Eric Miao, but this problem has been
> there since at least 2.6.28.
> And, I find it hard to believe I'm the only one getting all these problems.
> 
> To make sure it's not my heavily modified old 2009.3 u-boot, which is
> causing the problems because of some faulty nand controller configuration,
> I've just built the latest openpxa u-boot, and booted it with OBM2.
> But the results are the same.
> 
> Does anyone recognise this situation?
> Or are you using the nand without any problems?
>

Maybe the NAND's misconfigured, what bootloader do you use ?

btw. CCing appropriate places.
 
> Rgds, Pieter
> 
> 
> 
> double bit error @ page 00002284
> double bit error @ page 00002285
> double bit error @ page 00002287
> double bit error @ page 00002288
> double bit error @ page 0000228b
> double bit error @ page 0000228c
> double bit error @ page 00002299
> double bit error @ page 0000229a
> double bit error @ page 0000229c
> double bit error @ page 0000229d
> double bit error @ page 000022a0
> double bit error @ page 000022a5
> double bit error @ page 00002284
> double bit error @ page 00002285
> double bit error @ page 00002287
> double bit error @ page 00002288
> double bit error @ page 0000228b
> double bit error @ page 0000228c
> double bit error @ page 00002299
> double bit error @ page 0000229a
> double bit error @ page 0000229c
> double bit error @ page 0000229d
> double bit error @ page 000022a0
> double bit error @ page 000022a5
> Empty flash at 0x00cc197c ends at 0x00cc2000
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc2000: Read 0x248da816,
> calculated 0x7c7ef05f
> jffs2_scan_dirent_node(): Name CRC failed on node at 0x00cc2844: Read
> 0xf76a5b96, calculated 0xd0c4da7e
> jffs2_scan_dirent_node(): Name CRC failed on node at 0x00cc3044: Read
> 0x6c47a3fe, calculated 0x6fc37790
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc3710: Read 0xf02508a7,
> calculated 0xf02108a7
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc39dc: Read 0x0321a42a,
> calculated 0xcd10dc77
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc512c: Read 0x4c51a8fc,
> calculated 0xdd0c08c8
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc6d8c: Read 0x4cd5a708,
> calculated 0x659913c2
> jffs2_scan_eraseblock(): Node at 0x00cc6e04 {0x1985, 0x2004, 0x001001fc)
> has invalid CRC 0x7ebffc99 (calculated 0x347deec8)
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc6e08:
> 0x01fc instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc6e0c:
> 0xfc99 instead
> jffs2_scan_dirent_node(): Name CRC failed on node at 0x00cc7044: Read
> 0xb9eb2d20, calculated 0xceec1db6
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc736c: Read 0x36c54c35,
> calculated 0x34c54c35
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc73c4: Read 0xe2812946,
> calculated 0x04a617d8
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc748c: Read 0x1b4eab40,
> calculated 0xd4f392dc
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc757c: Read 0xd2ec78b6,
> calculated 0x8f0029ba
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc78a8: Read 0x50f59a58,
> calculated 0xb1a0b2bd
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc78f8: Read 0xfcc89ca3,
> calculated 0x21d0aa21
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc7b0c: Read 0x4f25942e,
> calculated 0x22d9556c
> jffs2_scan_inode_node(): CRC failed on node at 0x00cc7ce0: Read 0x43b8bc80,
> calculated 0xd9a964d0
> jffs2_scan_eraseblock(): Node at 0x00cc803c {0x1985, 0xe002, 0x00000063)
> has invalid CRC 0xa5126c1a (calculated 0xa5126c9a)
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc8040:
> 0x0063 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc8044:
> 0x6c1a instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc8048:
> 0x07d0 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc804c:
> 0x002d instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc8050:
> 0x8180 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00cc8058:
> 0x064b instead
> Further such events for this erase block will not be printed
> 
> ---------------------------------------------------------------------------
> --- Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Openpxa-users mailing list
> Openpxa-users at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openpxa-users
