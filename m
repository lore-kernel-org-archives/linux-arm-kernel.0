From: stefan.hengelein@fau.de (Stefan Hengelein)
Date: Wed, 25 Feb 2015 18:10:08 +0100
Subject: Dead Kconfig Option OMAP4_ERRATA_I688
Message-ID: <CABv5NL-bnfV0BoH+G=nX+1eo6xeT_LN8dOFtSnwvdpcvjJhUFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the research for my masters thesis i came across the
OMAP4_ERRATA_I688 option and realized, it is never possible to enable
this option.

The a62a6e98 commit added the "&& !ARCH_MULTIPLATFORM" dependency to
disable this option for multiplatforms. However, because of enclosing
dependencies, this option isn't available for non-MULTIPLATFORM
configurations either.

CONFIG_OMAP4_ERRATA_I688 is defined in the menu "TI OMAP/AM/DM/DRA
Family" which depends on ARCH_MULTI_V6 || ARCH_MULTI_V7. (in
arch/arm/mach-omap2/Kconfig)

ARCH_MULTI_V6 and ARCH_MULTI_V7 however are defined in the menu
"Multiple platform selection" which depends on ARCH_MULTIPLATFORM (in
arch/arm/Kconfig)

Which is a contradiction.

There are no selects on OMAP4_ERRATA_I688, which would ignore
dependencies, either.

The question is:
Was disabling this option for non-MULTIPLATFORM configurations also intentional?

i have added a minimal example of the problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Kconfig.minimal
Type: application/octet-stream
Size: 955 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/9aeb26d1/attachment.obj>
