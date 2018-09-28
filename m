From: joe@perches.com (Joe Perches)
Date: Fri, 28 Sep 2018 15:03:53 -0700
Subject: Bad MAINTAINERS pattern in section 'SOFTWARE DELEGATED EXCEPTION
 INTERFACE (SDEI)'
Message-ID: <20180928220353.31413-1-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	13609	SOFTWARE DELEGATED EXCEPTION INTERFACE (SDEI)
	13610	M:	James Morse <james.morse@arm.com>
	13611	L:	linux-arm-kernel at lists.infradead.org
	13612	S:	Maintained
	13613	F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
	13614	F:	drivers/firmware/arm_sdei.c
-->	13615	F:	include/linux/sdei.h
	13616	F:	include/uapi/linux/sdei.h

Commit that introduced this:

commit ad6eb31ef90355993eb55ff77e0e855ae7d91e4c
 Author: James Morse <james.morse@arm.com>
 Date:   Mon Jan 8 15:38:09 2018 +0000
 
     firmware: arm_sdei: Add driver for Software Delegated Exceptions
     
     The Software Delegated Exception Interface (SDEI) is an ARM standard
     for registering callbacks from the platform firmware into the OS.
     This is typically used to implement firmware notifications (such as
     firmware-first RAS) or promote an IRQ that has been promoted to a
     firmware-assisted NMI.
     
     Add the code for detecting the SDEI version and the framework for
     registering and unregistering events. Subsequent patches will add the
     arch-specific backend code and the necessary power management hooks.
     
     Only shared events are supported, power management, private events and
     discovery for ACPI systems will be added by later patches.
     
     Signed-off-by: James Morse <james.morse@arm.com>
     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
 
  MAINTAINERS                   |   9 +
  arch/arm64/include/asm/sdei.h |   8 +
  drivers/firmware/Kconfig      |   8 +
  drivers/firmware/Makefile     |   1 +
  drivers/firmware/arm_sdei.c   | 619 ++++++++++++++++++++++++++++++++++++++++++
  include/linux/arm_sdei.h      |  79 ++++++
  include/uapi/linux/arm_sdei.h |  73 +++++
  7 files changed, 797 insertions(+)

No commit with include/linux/sdei.h found
