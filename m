From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Fri, 05 Oct 2012 17:34:02 +0200
Subject: mxc-nand + jffs2 : dir ino #9041 appears to be a hard link
Message-ID: <506EFDEA.7050305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am working with iMX27 (3DS) with NAND support (and bbiswap patch : 
mxc_nand : allow swapping the Bad block Indicator for NFC v1).

Here is errors that I have sometimes after updating a lot of of files.
Everything is working good until I power off the board (before that I 
start that reboot script that sync and umount all filesystems and 
remount / as ro (sync is also run before remount) before reboot.
While this update, there is several "ln -sf" because busybox must be 
updated.

Sometimes it works and sometimes filesystem gets corrupted and gives me 
following kind of errors :
jffs2: error: (1) jffs2_build_inode_pass1: child dir "share" (ino #9044) 
of dir ino #9041 appears to be a hard link


jffs2: warning: (1022) jffs2_get_inode_nodes: Eep. No valid nodes for 
ino #9044.
jffs2: warning: (1022) jffs2_do_read_inode_internal: no data nodes found 
for ino #9044

This never occurs with kernel 2.6.22 from Freescale but with kernel 
3.4.4, it occurs.
I am going to compile kernel 3.4.12 but I don't see anything in commits 
about this problem.

Does anyone have an idea where the problem is ?
Thanks for your help.
Best regards,
Ga?tan Carlier.
