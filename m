From: andreas@kemnade.info (Andreas Kemnade)
Date: Fri, 7 Sep 2018 19:35:57 +0200
Subject: Regression in next with filesystem context concept
In-Reply-To: <20180907161023.GF5662@atomide.com>
References: <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <20180907161023.GF5662@atomide.com>
Message-ID: <20180907193522.1a98d410@aktux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 7 Sep 2018 09:10:23 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * David Howells <dhowells@redhat.com> [180907 08:51]:
> > Tony Lindgren <tony@atomide.com> wrote:
> >   
> > > Looks like next-20180906 now has a regression where mounting
> > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > filesystem superblock creation/configuration context").  
> > 
> > Am I right in thinking you're not using any of the LSMs?  
> 
> Assuming LSM as in Documentation/lsm.txt, right not using any.
> 
> BTW, I don't think this issue shows up with ramdisk either,
> so that's probably why for example kernelci.org does not
> show errors.
> 

I have also similar experience with my automated tests (automated
alarming does not work yet ;-)), I am still in the beginning.
I do there a ramdisk boot to create an overlay mount with the fresh
modules on top of an ordinary rootfs. initramfs mount is
ok, but the microsd card fails.

Testing from a ramdisk I get:
/ # ls -l /dev/mmcblk0p2 
brw-------    1 0        0         179,   2 Jan  1  1970 /dev/mmcblk0p2
/ # mount /dev/mmcblk0p2 /mnt/
[  682.819061] Filesystem requires source device
[  682.825103] Filesystem requires source device
[  682.830810] Filesystem requires source device
[  682.836303] Filesystem requires source device
[  682.843078] Filesystem requires source device
[  682.847991] Filesystem requires source device
[  682.853149] Filesystem requires source device
mount: mounting /dev/mmcblk0p2 on /mnt/ failed: No such file or directory

64GB microsd at omap_hsmmc correcly recognized. 
Last known successful boot: next-20180830

so you are not alone with such problems.
will investigate further

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/66723be6/attachment-0001.sig>
