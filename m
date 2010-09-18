From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sat, 18 Sep 2010 16:24:57 +0100
Subject: make[2]: *** No rule to make target `.config',
	needed by `arch/arm/boot/compressed/vmlinux.lds'
Message-ID: <4C94D9C9.2060309@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when using the environment variable KCONFIG_CONFIG

This comes from:

arch/arm/boot/compressed/Makefile

$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile .config
	@sed "$(SEDFLAGS)" < $< > $@

My immediate feel is that changing that .config for $(KCONFIG_CONFIG)
ought to fix the problem. Is this right or am I missing something?

Jonathan
