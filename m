From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 May 2013 13:10:30 +0100
Subject: [PATCH 0/3] Xen ARM fixes for 3.10-RC1
Message-ID: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this small patch series fixes few Xen on ARM problems I found with more
testing:

- in order to work in dom0, we need to delay the initilization of the pm
  functions after arch_init;

- VCPUOP_register_vcpu_info needs to be executed by each online cpu
  separately;

- VCPUOP_register_vcpu_info is not actually supposed to fail.



Stefano Stabellini (3):
      xen/arm: initialize pm functions later
      xen/arm: do not handle VCPUOP_register_vcpu_info failures
      xen: rename xen_secondary_init and run it on every online cpu

 arch/arm/xen/enlighten.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)
