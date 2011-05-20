From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 May 2011 19:07:48 +0100
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
Message-ID: <20110520180748.GF7445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:
> I've simply done there what the "setmode" macro from <asm/assembler.h>  
> is doing, have chosen not to include that file because it overrides 
> "push" on a global scale for no good reason and that sort of thing makes 
> me cringe.

"push" was never an ARM instruction until someone decided to make r13
"special".  As our macros there pre-date the invention of the new ARM
instruction neumonics, it takes precident _especially_ as there's
perfectly good alternative ways to say "push" to the assembler.
