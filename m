From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 09:32:40 +0000
Subject: [RFC PATCH v2 1/2] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
Message-ID: <20120105093240.GM11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 01:02:05AM -0600, Robert Lee wrote:
> +	asm("b 1f; .align 5; 1:");
> +	asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */

Err, no.  The compiler is free to add whatever instructions it sees
fit between these two asm() statements.

If you want to ask the compiler to issue a set of assembly instructions
as a block, you have to use just one asm() statement.
