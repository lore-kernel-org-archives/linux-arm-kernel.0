From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 10:05:02 +0100
Subject: [PATCH 2/3] ARM: module - simplify unwind table handling
In-Reply-To: <1275567442-11370-3-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-2-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-3-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <20100624090502.GA1398@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 03:17:21PM +0300, Phil Carmody wrote:
>  #ifdef CONFIG_ARM_UNWIND
...
> +#else
> +struct mod_arch_specific {
> +}
> +#endif

I assume no one tried building these with UNWIND disabled?  linux-next
reports most ARM builds are broken by this.

Dropped all three patches out of my git tree until it can be fixed.
