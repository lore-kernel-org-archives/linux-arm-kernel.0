From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 13:56:53 +0100 (BST)
Subject: [PATCH 0/8] Convert Netgear WNR854T to devicetree
In-Reply-To: <op.ymsxegsy2s3iss@ecaz>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk> <op.ymsxegsy2s3iss@ecaz>
Message-ID: <alpine.DEB.2.11.1608261325310.19980@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, Imre Kaloz wrote:

> Hi Jamie,
>
> On Fri, 26 Aug 2016 11:20:56 +0200, Jamie Lentin <jm@lentin.co.uk> wrote:
>
> <snip>
>
>> * Use Flash partition scheme from original netgear Linux image (but
>> keeping the uboot/uboot_env split) instead of the partition scheme from
>> the old non-DT support, which didn't match either Netgear's layout,
>> u-boot or openWRT. NB: I've no copy of the original flash contents
>> (Netgear's firmware images only contain a squashfs image of the rootfs),
>> so I can't confirm the other partitions are accurately named.
>
> Both the factory layout and OpenWrt's changed a few times - the later just to 
> accommodate bigger kernels. Some factory firmwares did include a kernel 
> update, too.

The Netgear firwmare images (as far as I've seen) all contain a uImage, as 
the uImage lives in the same JFFS2 partition as the rootfs, which the 
firmware image is a dump of.

> I would suggest staying with the OpenWrt layour (maybe increase again the 
> size of the kernel partition):
> - the bootloader loads the kernel from JFFS2
> - most of the partitions in the factory firmware are empty

Phew, I'm not missing out on much then :)

> - the factory layout gives you almost no space to play with
>
> But this is up to you now :)

When making a patchset for the D-Link DNS-325 I remember being told that 
the kernel's default partition scheme should match the vendor's (even if 
it is fairly nonsensical). It's easy enough to override if you've replaced 
the default firmware, and I'll invariably be overriding it so the mainline 
kernel definition won't make much difference to me either way.

Of course, one could also argue I'm breaking backwards compatibility at 
this point by changing it, so maybe I should put it back.

> Best,
>
> Imre

-- 
Jamie Lentin
