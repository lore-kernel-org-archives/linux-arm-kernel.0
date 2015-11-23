From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 23 Nov 2015 13:58:42 -0800
Subject: defconfig support for CPU_BIG_ENDIAN arm64 kernel
Message-ID: <56538C12.4030506@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For arm64 platforms there is only a single defconfig upstreamed.  This 
builds for Little Endian ARM64 platforms.  So...what about Big Endian?

It seems like we need another defconfig with CPU_BIG_ENDIAN to be 
enabled and built in the upstream kernel.  We need this deconfig to test 
that drivers compile in big endian mode and we have an upstream kernel 
image to run on these systems.

I'm hoping the upstreamed kernel is already being built/tested with the 
arm64 big endian compiler.

If not, perhaps the upstream solution is to continue to use the single 
defconfig we have today and start using scripts/kconfig/merge_config.sh 
to add the CPU_BIG_ENDIAN support to generate a big endian defconfig?

Hopefully arm64 is already being compiled and tested for Big Endian and 
I'm missing something?

Regards,
  Scott
