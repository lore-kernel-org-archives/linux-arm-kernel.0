From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 09:12:08 +0200
Subject: [PATCH v2 2/2] ARM: vf610: Add SoC bus support for Vybrid
In-Reply-To: <27733a88b73adb7000205e020bafdb6f7ebe1843.1432099651.git.maitysanchayan@gmail.com>
References: <cover.1432099651.git.maitysanchayan@gmail.com>
 <27733a88b73adb7000205e020bafdb6f7ebe1843.1432099651.git.maitysanchayan@gmail.com>
Message-ID: <9691074.oWRy1bscbz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 11:06:52 Sanchayan Maity wrote:
> Implements SoC bus support to export SoC specific information. Read
> the unique SoC ID from the Vybrid On Chip One Time Programmable
> (OCOTP) controller, SoC specific information from the Miscellaneous
> System Control Module (MSCM), revision from the ROM revision register
> and expose it via the SoC bus infrastructure.
> 
> Sample Output:
> 
> root at vf:/sys/devices/soc0# cat soc_id
> df63c12a2e2161d4
> root at vf:/sys/devices/soc0# cat family
> Freescale Vybrid VF500
> root at vf:/sys/devices/soc0# cat revision
> 00000013
> root at vf:/sys/devices/soc0# cat machine
> Freescale Vybrid
> 

I would prefer to see this as a driver in drivers/soc that registers
to a platform device. Is there any DT node that would be a reasonable
device to bind to?

	Arnd
