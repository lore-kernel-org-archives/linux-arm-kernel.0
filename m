From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 21:54:07 -0400 (EDT)
Subject: Git pull request: 64-bit atomic user helper
Message-ID: <alpine.LFD.2.00.1106202134510.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following for the next merge window:

	git://git.linaro.org/people/nico/linux.git cmpxchg64

This series cleans up the kuser documentation, then it adds 64-bit
cmpxchg support as needed by some user space applications.

Tested with the initial libgcc patches relying on this, using a 
kernel that has this series applied, and another without those 
patches to verify that the test for the availability of the needed 
helper does work as intended.

Nicolas Pitre (2):
      ARM: kuser: move interface documentation out of the source code
      ARM: add a kuser_cmpxchg64 user space helper

 Documentation/arm/kernel_user_helpers.txt |  267 +++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S              |  246 ++++++++-------------
 2 files changed, 361 insertions(+), 152 deletions(-)


Nicolas
