From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Nov 2012 09:41:22 +0000
Subject: Build failure: drivers/net/wan/wanxlfw.inc
Message-ID: <20121107094122.GT28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a randconfig build last night, the following was observed:

  BLD FW  drivers/net/wan/wanxlfw.inc
/bin/sh: as68k: command not found
In file included from include/linux/kernel.h:10:0,
                 from include/linux/skbuff.h:17,
                 from include/linux/hdlc.h:14,
                 from drivers/net/wan/wanxlfw.S:37:
include/linux/bitops.h:181:2: error: #error BITS_PER_LONG not 32 or 64
In file included from include/linux/string.h:9:0,
                 from include/linux/dynamic_debug.h:100,
                 from include/linux/kernel.h:14,
                 from include/linux/skbuff.h:17,
                 from include/linux/hdlc.h:14,
                 from drivers/net/wan/wanxlfw.S:37:
include/uapi/linux/string.h:7:20: fatal error: string.h: No such file or directocompilation terminated.
make[4]: *** [drivers/net/wan/wanxlfw.inc] Error 127

Obviously the lack of as68k doesn't help, but it looks like something is
broken with the includes too.

Full log and config at:
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2640
http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2640
