From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 11 Jun 2012 15:20:22 +0800
Subject: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
In-Reply-To: <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
 <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
Message-ID: <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 2:21 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> Hi Ming Lei,
> Can you let me know if you noticed any write/timeout errors ?

Nothing error logs found during writing.

Below is one of my test case.

root at beagleboard:~# upk
updateing kernel...
flush storage...
root at beagleboard:~# cat bin/upk
#!/bin/sh

echo "updateing kernel..."
cp -f /mnt/nfs/t/uImage /media/mmcblk0p1/

echo "flush storage..."
sync
root at beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ
root at beagleboard:~# umount /media/mmcblk0p1
root at beagleboard:~# mount -t vfat /dev/mmcblk0p1 /media/mmcblk0p1
root at beagleboard:~#
root at beagleboard:~#
root at beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ


Thanks,
--
Ming Lei
