From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Dec 2013 20:06:11 +0000
Subject: [PATCH 0/4] arm64 topology support
Message-ID: <1387483575-11430-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Another spin of the arm64 topology work - this should incorporate most
of the feedback from Lorenzo, there's a few things that were still under
discussion the main ones being:

 - Should we have a smp_store_cpu_info(); like I say I like the errors
   it generates for omitted cores and the reuse of the SMP enumeration
   code (and cross-check with that I guess - make sure we don't get
   confused about which CPUs are getting enabled).

 - Should we update the binding to allow cores in the root cpu_map node
   (since it's less effort in code and not a meaningful difference
   semantically), warn if we find cores in the cpu_map node or actively
   reject such DTs?

In both cases I don't much mind but I think what's there is reasonable
so I've left the code as-is pending further feedback.  I also didn't
update the code to get more reuse of the iteration code, like I said I
did look at that when writing the code but couldn't find anything that
actually made things more pleasant but if someone has some ideas...

Everything else raised should be addressed I think.

Mark Brown (4):
  arm64: topology: Implement basic CPU topology support
  arm64: topology: Add support for topology DT bindings
  arm64: topology: Tell the scheduler about the relative power of cores
  arm64: topology: Provide relative power numbers for cores

 arch/arm64/Kconfig                |  24 +++
 arch/arm64/include/asm/topology.h |  39 ++++
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/smp.c           |  12 ++
 arch/arm64/kernel/topology.c      | 384 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 460 insertions(+)
 create mode 100644 arch/arm64/include/asm/topology.h
 create mode 100644 arch/arm64/kernel/topology.c

-- 
1.8.5.2
