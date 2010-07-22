From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jul 2010 12:19:56 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <20100722111631.GM31293@n2100.arm.linux.org.uk>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
	<20100722103038.GE31293@n2100.arm.linux.org.uk>
	<1279796069.9564.2.camel@e102109-lin.cambridge.arm.com>
	<20100722105729.GK31293@n2100.arm.linux.org.uk>
	<1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
	<20100722111631.GM31293@n2100.arm.linux.org.uk>
Message-ID: <1279797596.9564.25.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-22 at 12:16 +0100, Russell King - ARM Linux wrote:
> The kernel boot requirements document has for the last _8_ years said:
> 
>    The boot loader must pass at a minimum the size and location of the system
>    memory, and root filesystem location. Therefore, the minimum tagged list
>    should look:
> 
>            +-----------+
>    base -> | ATAG_CORE |  |
>            +-----------+  |
>            | ATAG_MEM  |  | increasing address
>            +-----------+  |
>            | ATAG_NONE |  |
>            +-----------+  v
> 
> and still u-boot gets it wrong...  Now tell me why I hate boot loaders
> soo much.

Maybe it's time to ignore all boot loaders and do everything in the
kernel :)

-- 
Catalin
