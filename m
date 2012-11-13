From: davem@davemloft.net (David Miller)
Date: Tue, 13 Nov 2012 17:17:36 -0500 (EST)
Subject: [PATCH V2] wanrouter: Remove it and the drivers that depend on it
In-Reply-To: <1352837845.12850.3.camel@joe-AO722>
References: <67fe0c5701a8c7cfe06b178cf04b1c5c06592714.1352548454.git.joe@perches.com>
 <20121113.144406.1610017702502358739.davem@davemloft.net>
 <1352837845.12850.3.camel@joe-AO722>
Message-ID: <20121113.171736.561094209116852795.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Tue, 13 Nov 2012 12:17:25 -0800

> That seems an odd workflow as it leaves dangling CONFIG_<foo>
> options set, but I guess it doesn't hurt so here it is.

As you said it's harmless, and more importantly it avoids
unnecessary conflicts.

> I just removed the modified arch/.../<foo>defconfig files.

Something is not right here:

[davem at drr net-next]$ git am --signoff V2-wanrouter-Remove-it-and-the-drivers-that-depend-on-it.patch 
Applying: wanrouter: Remove it and the drivers that depend on it
error: removal patch leaves file contents
error: net/wanrouter/Kconfig: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/Makefile: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/patchlevel: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/wanmain.c: patch does not apply
error: removal patch leaves file contents
error: net/wanrouter/wanproc.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_drv.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_main.c: patch does not apply
error: removal patch leaves file contents
error: drivers/net/wan/cycx_x25.c: patch does not apply
error: removal patch leaves file contents
error: include/linux/cyclomx.h: patch does not apply
error: removal patch leaves file contents
error: include/linux/cycx_drv.h: patch does not apply
error: removal patch leaves file contents
error: include/linux/wanrouter.h: patch does not apply
error: removal patch leaves file contents
error: include/uapi/linux/wanrouter.h: patch does not apply
