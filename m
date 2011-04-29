From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:07:23 -0700
Subject: [PATCH 8/9] ARM: zImage: remove the static qualifier from
	global data variables
In-Reply-To: <1304031024-5121-9-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-9-git-send-email-nico@fluxnic.net>
Message-ID: <20110429070723.GS3755@atomide.com>
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
> Let's remove the static qualifier from current offenders, or turn them
> into const variables when possible.  Next commit will ensure the build
> fails if one of those is reintroduced due to otherwise enforced coding
> standards for the kernel.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

This fixes the DT data corruption issue I was seeing with the DT
append patch.

Tested-by: Tony Lindgren <tony@atomide.com>
