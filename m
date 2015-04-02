From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 15:28:09 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2321040.CmsL1gluUd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 April 2015 11:16:24 Thomas Petazzoni wrote:
> The Armada 370 DB boards are now being used with a more recent version
> of U-Boot, which has Device Tree support, and remaps internal
> registers at 0xf1000000 like most of the other Marvell EBU platforms.
> 
> Consequently, this commit updates the Device Tree describing this
> platform to use this new internal register address, so that the
> mainline kernel can easily be used on such boards that use a modern
> bootloader. A comment is also added to warn users who could have
> boards with an older bootloader version.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I think it would be better to add a new .dts file that includes the
former, and give it a new name, such as armada-370-db-broken-uboot.dts.

We should not stop supporting the older versions, and it would be better
to revert the bootloader change in their u-boot before it spreads too far.

	Arnd
