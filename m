From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 May 2011 11:32:42 +0100
Subject: [PATCH v5 02/19] ARM: LPAE: add ISBs around MMU enabling code
In-Reply-To: <1304936539.7658.31.camel@e102109-lin.cambridge.arm.com>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
	<20110508214101.GO27807@n2100.arm.linux.org.uk>
	<1304936539.7658.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110509103242.GQ27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 11:22:19AM +0100, Catalin Marinas wrote:
> Alternatively an exception return would do as well (like movs pc, lr)
> but I think we still add some code for setting up the SPSR.

That gives us a way out of both of these without introducing any CPU
specific code.  We can setup the SPSR before this block of code, and
call it with two movs pc, reg instructions which will provide the
necessary synchronization.

That sounds to me like an all-round better solution here.
