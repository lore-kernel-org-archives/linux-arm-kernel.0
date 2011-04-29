From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:11:41 -0700
Subject: [PATCH 9/9] ARM: zImage: make sure no GOTOFF relocs are used
	with .bss symbols
In-Reply-To: <1304031024-5121-10-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-10-git-send-email-nico@fluxnic.net>
Message-ID: <20110429071141.GT3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110428 15:47]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> To be able to relocate the .bss section at run time independently from
> the rest of the code, we must make sure that no GOTOFF relocations are
> used with .bss symbols.  This usually means that no global variables can
> be marked static unless they're also const.
> 
> To enforce this, suffice to fail the build whenever a private symbol
> is allocated to .bss and list those symbols for convenience.
> 
> The user_stack and user_stack_end labels in head.S were converted into
> non exported symbols to remove false positives.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Marking something static in uncompress.h now fails with this patch, so:

Tested-by: Tony Lindgren <tony@atomide.com>
