From: slash.tmp@free.fr (Mason)
Date: Tue, 17 May 2016 17:56:44 +0200
Subject: CONFIG_ZBOOT_ROM_TEXT and CONFIG_ZBOOT_ROM_BSS in defconfig
Message-ID: <573B3F3C.80800@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When reviewing my platform's defconfig, these two entries jumped out:

CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0

I found it odd that they would appear in the defconfig, since I don't
care about them, and left them at their default value -- as most
platforms seem to do:

$ git grep CONFIG_ZBOOT_ROM_TEXT=0x0 arch/arm/configs | wc -l
83

# Compressed boot loader in ROM.  Yes, we really want to ask about
# TEXT and BSS so we preserve their values in the config files.
config ZBOOT_ROM_TEXT
	hex "Compressed ROM boot loader base address"
	default "0"

It seems 'make savedefconfig' doesn't consider 0 and 0x0 to be equivalent.

I can submit a patch changing the default from 0 to 0x0, i.e.
no functional change. The two entries would then disappear
from defconfigs.

Arnd didn't seem to like the idea. How do others feel?

Regards.
