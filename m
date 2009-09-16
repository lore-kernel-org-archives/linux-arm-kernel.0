From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Sep 2009 21:59:27 +0100
Subject: [PATCH] arm: new W macro to WORD_ACCESS
In-Reply-To: <20090916175812.GA18993@Chamillionaire.breakpoint.cc>
References: <200909161601.35662.elendil@planet.nl>
	<20090916175812.GA18993@Chamillionaire.breakpoint.cc>
Message-ID: <1253134767.19743.3.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-16 at 19:58 +0200, Sebastian Andrzej Siewior wrote:
> As reported by Frans Pop the new global macro W on ARM which is included
> via
> |arch/arm/include/asm/uaccess.h:20
> |include/linux/uaccess.h:5
> |include/linux/crypto.h:26
> |crypto/cast6.c:23
> 
> leads to a build error because the crypto/cast6.c defines a function
> which is named W.

This was already reported by Alexey Dobriyan and I included his patch in
my Thumb-2 branch (and -next for now):

http://linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=4fb3c2e2ab3549308a1b1663296d165e45d72ba5

Since this macro is only used in ARM assembly code, the patch simply
adds some ifdefs around it.

Russell, if you are OK with Alexey's patch, I'll send you a pull request
(though for only one patch, alternatively just merge it manually).

-- 
Catalin
