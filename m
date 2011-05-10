From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 21:32:33 +0100
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <20110510220214.916621d1.ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
	<20110510220214.916621d1.ospite@studenti.unina.it>
Message-ID: <20110510203233.GA5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 10:02:14PM +0200, Antonio Ospite wrote:
> I was blindly trusting code already in mainline again, and for that I
> apologize, I finally took the time to look at the implementation
> of IS_ERR() and test its use, and being IS_ERR(NULL) true it is not what
> we want indeed, see the attached test program.
> 
> So, I am going to remove the ifdefs anyway but use IS_ERR_OR_NULL();
> how does that sound? Am I still missing anything?

That sounds a lot better, and should avoid the issue which caused me to
throw out the original patch.
