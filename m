From: phil@nwl.cc (Phil Sutter)
Date: Fri, 11 Mar 2016 07:58:16 +0100
Subject: [PATCH] ARM: mvebu: fix overlap of Crypto SRAM with PCIe memory
 window
In-Reply-To: <1457452797-363-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1457452797-363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160311065630.F01576739A@mail.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Tue, Mar 08, 2016 at 04:59:57PM +0100, Thomas Petazzoni wrote:
> When the Crypto SRAM mappings were added to the Device Tree files
> describing the Armada XP boards in commit c466d997bb16 ("ARM: mvebu:
> define crypto SRAM ranges for all armada-xp boards"), the fact that
> those mappings were overlaping with the PCIe memory aperture was
> overlooked. Due to this, we currently have for all Armada XP platforms
> a situation that looks like this:

This patch fixes the issues for me, at least with proprietary U-Boot
underneath (I checked, they were still present with upstream kernel).
Thanks a lot!

Cheers, Phil
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbibIYACgkQnMPprxY1hCc2GACgmj9bNXnF6QDvCVk2Q5+R/gB2
3e0AoIhosGwE22VnZ1Le8S6X0JRjeVfR
=w853
-----END PGP SIGNATURE-----
