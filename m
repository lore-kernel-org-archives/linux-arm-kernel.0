From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 20 Jun 2016 20:17:02 +0200
Subject: [PATCH v3 0/15] Changes to support 150 MHz eMMC on rk3399
In-Reply-To: <1466445414-11974-1-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Message-ID: <1805593.i4NJUkPJQz@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. Juni 2016, 10:56:39 schrieb Douglas Anderson:
> The theme of this series of patches is to try to allow running the eMMC
> at 150 MHz on the rk3399 SoC, though the changes should still be correct
> and have merit on their own.  The motivation for running at 150 MHz is
> that doing so improves signal integrity and (with some eMMC devices)
> doesn't affect throughput.
> 
> These patches have been structured to keep things as separate as
> possible, but nevertheless there are still some dependencies between
> patches.  It probably makes the most sense for all of the non-device
> tree patches to go through a single tree.  PHY patches now have Acks
> from Kishon so that means things should be clear for all non-DTS patches
> to go through the MMC tree if Ulf agrees.  Device tree patches should be
> able to be landed separately and the worst what would happen is a
> warning in the kernel log if you have the code without the device tree.
> 
> The code patches are based on Ulf's mmc-next.  In v3 of the series I've
> pulled in the latest version of a previous PHY series posted by Brian
> Norris.
> 
> The device tree patches are based on Heiko's v4.8-armsoc/dts64.

just so it doesn't get lost from v2->v3, I plan on picking up the dts patches 
9 and 15 after the rest landed in the mmc tree - as they will only apply on 
top of my general dts branch.


Heiko
