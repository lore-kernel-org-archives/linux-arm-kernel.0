From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Jun 2015 14:15:25 +0100
Subject: [PATCH RFC 2/2] ARM: add soc memory barrier extension
In-Reply-To: <E1Z07tA-0001TV-As@rmk-PC.arm.linux.org.uk>
References: <E1Z07tA-0001TV-As@rmk-PC.arm.linux.org.uk>
Message-ID: <20150603131525.GD18604@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 01:35:20PM +0100, Russell King wrote:
> Add an extension to the heavy barrier code to allow a SoC specific
> memory barrier function to be provided.  This is needed for platforms
> where the interconnect has weak ordering, and thus needs assistance
> to ensure that memory writes are properly visible in the correct order
> to other parts of the system.

Do you have an example of where this is needed? Were they previously
handled by hijacking outer_cache.sync?

-- 
Catalin
