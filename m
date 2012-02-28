From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Feb 2012 19:24:59 +0000
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler framework
In-Reply-To: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20120228192458.GC3617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 06:59:44PM +0000, Dave Martin wrote:
> #ifdef __ASSEMBLY__
> stuff
> for
> the
> assembler
> #else
> asm("stuff");
> asm("for");
> asm("the");
> asm("assembler");

That's invalid - nothing guarantees that the compiler won't place
anything in between these asm statements in the output assembly
file.
