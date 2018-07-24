From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 24 Jul 2018 14:24:01 +1000
Subject: [PATCH 0/5] arm: dts: aspeed DTS updates for OpenPower
Message-ID: <20180724042406.15374-1-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are DTS updates for Aspeed SoCs used on OpenPower systems.

They should comply with existing bindings either upstream, in
linux-next or about to be pulled into linux-next, and that have
been acked by Rob.

 - Add the "cvic" node for the coprocessor interrupt controller
to the Aspeed G4 and G5 SoC .dtsi files.

 - Switch OpenPower Romulus and Palmetto systems from using the
Linux bitbang GPIO FSI master to using the new ColdFire coprocessor
based one which is much faster (driver about to hit linux-next)

 - Add a basic definition of the POWER8 and POWER9 processors
as seen on an FSI bus by the BMC. Not every device in there is
exposed yet. More devices will be added as their drivers and
bindings get finalized.
