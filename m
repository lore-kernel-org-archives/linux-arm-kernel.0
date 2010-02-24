From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 23:42:15 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002241824520.1946@xanadu.home>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
Message-ID: <20100224234215.GA21985@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 06:34:49PM -0500, Nicolas Pitre wrote:
> What about simply not compiling the decompressor with -fPIC when using 
> ZBOOT_ROM=y?  That would certainly solve the problem with the only 
> restriction that such kernel images won't be bootable from RAM which is 
> probably an acceptable compromize.

Unfortunately, that doesn't solve the stack-bashing with ZBOOT_ROM=n.

I'm afraid that the commit adding LZO support is going to have to be
reverted until a better solution to this is found.
