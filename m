From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 May 2018 15:16:51 +0100
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20180524141651.GV4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

After merging the pm tree, today's linux-next build (arm64 defconfig)
failed like this:

drivers/acpi/ec.o: In function `acpi_ec_dispatch_gpe':
/home/broonie/next/next/drivers/acpi/ec.c:1040: undefined reference to `acpi_dispatch_gpe'
/home/broonie/next/next/drivers/acpi/ec.c:1040:(.text+0x228c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `acpi_dispatch_gpe'

Probably caused by commit

  8f81c457105b5d4 ("ACPI: EC: Dispatch the EC GPE directly on s2idle wake")

(though the symbol appears to be there and like it should be built and
the relocation warning looks funky...).  I've used the PM tree from the
last -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/fcc5a5bf/attachment.sig>
