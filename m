From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 22 Sep 2011 14:04:12 +0300
Subject: booting single uImage on platforms with different base addresses
	for SDRAM
Message-ID: <20110922110411.GD20444@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Currently uImages have the load address hardcoded. As we now try to support
as many ARM platforms as possible with a single binary, this becomes a
problem. On tegra20 SDRAM starts at physical address 0, but on tegra30 SDRAM
starts at 0x80000000. It's possible to build a kernel image which can deal
with this, but the uImage still uses a hardcoded address. This results
in requiring 2 different uImages even though the zImage is the same.

Has anyone thought of a solution to this problem?

Thanks,

Peter.
