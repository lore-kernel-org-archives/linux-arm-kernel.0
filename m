From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Nov 2010 16:12:10 +0000
Subject: [PATCH] arch/arm/kernel/smp_twd.c: Correct local timer printk
	decimal output
In-Reply-To: <1289244455.29216.348.camel@Joe-Laptop>
References: <1289244455.29216.348.camel@Joe-Laptop>
Message-ID: <20101112161210.GA10125@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 08, 2010 at 11:27:35AM -0800, Joe Perches wrote:
> The timer decimal place is shown incorrectly.
> The %100 divisor needs to have 1 fewer 0.
> 
> Convert to pr_<level> while at it.

I'd rather avoid core code having KBUILD_MODNAME prefix it.  The message
is unique enough as is.
