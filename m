From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 26 Aug 2016 14:09:42 +0200
Subject: [PATCH 0/8] Convert Netgear WNR854T to devicetree
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <op.ymsxegsy2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Fri, 26 Aug 2016 11:20:56 +0200, Jamie Lentin <jm@lentin.co.uk> wrote:

<snip>

> * Use Flash partition scheme from original netgear Linux image (but
> keeping the uboot/uboot_env split) instead of the partition scheme from
> the old non-DT support, which didn't match either Netgear's layout,
> u-boot or openWRT. NB: I've no copy of the original flash contents
> (Netgear's firmware images only contain a squashfs image of the rootfs),
> so I can't confirm the other partitions are accurately named.

Both the factory layout and OpenWrt's changed a few times - the later just  
to accommodate bigger kernels. Some factory firmwares did include a kernel  
update, too.

I would suggest staying with the OpenWrt layour (maybe increase again the  
size of the kernel partition):
- the bootloader loads the kernel from JFFS2
- most of the partitions in the factory firmware are empty
- the factory layout gives you almost no space to play with

But this is up to you now :)


Best,

Imre
