From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 May 2018 09:23:45 -0700
Subject: [PATCH 04/14] ARM: bugs: add support for per-processor bug
 checking
In-Reply-To: <E1fIuAz-0003k5-OP@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuAz-0003k5-OP@rmk-PC.armlinux.org.uk>
Message-ID: <5f5ae660-ab61-603f-1dfe-7a0434b4da47@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 04:00 AM, Russell King wrote:
> Add support for per-processor bug checking - each processor function
> descriptor gains a function pointer for this check, which must not be
> an __init function.  If non-NULL, this will be called whenever a CPU
> enters the kernel via which ever path (boot CPU, secondary CPU startup,
> CPU resuming, etc.)
> 
> This allows processor specific bug checks to validate that workaround
> bits are properly enabled by firmware via all entry paths to the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
