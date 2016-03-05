From: phil@nwl.cc (Phil Sutter)
Date: Sat, 5 Mar 2016 15:36:31 +0100
Subject: Broken PCIe on Synology DS414
Message-ID: <20160305143445.827496739A@mail.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Commit c466d997bb160 ("ARM: mvebu: define crypto SRAM ranges for all
armada-xp boards") breaks PCIe on the MV78230 based Synology DS414. The
kernel does not complain, but 'lspci' does not show a single device.
Reverting this commit cures vanilla 4.5-rc6 again for me.

Seems like the ranges declared for crypto SRAM conflict with PCIe
controller ones in some way. Looking at the DT files, all MV78230 based
devices should be affected, not just the DS414.

Is this a known problem? Please let me know if there is anything I can
do to further analyze the issue.

Thanks, Phil
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlba7uwACgkQnMPprxY1hCf8tACcDc1uAjGIw9Q06hxZ6sz3hQf9
19EAn355YCXKamlXK3ir/Sh/fhtvZpew
=71Sh
-----END PGP SIGNATURE-----
