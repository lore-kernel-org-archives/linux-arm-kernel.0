From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 01:35:27 +0200
Subject: Fix orion_nand build on ARCH_MVEBU
In-Reply-To: <20120816183708.GT22226@titan.lakedaemon.net>
References: <20120816183708.GT22226@titan.lakedaemon.net>
Message-ID: <1346110528-30858-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

I investigated a little bit, and found out that orion_nand driver was
the only PLAT_ORION driver needing <mach/hardware.h>, and in fact this
include was not needed. The attached patch therefore removes this
include from orion_nand.

Thanks,

Thomas
