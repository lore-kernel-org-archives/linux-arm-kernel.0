From: dcb314@hotmail.com (David Binderman)
Date: Mon, 8 Feb 2016 15:50:50 +0000
Subject: linux-4.5-rc3/arch/arm/mach-ux500/cpu-db8500.c:89: statement after
 return ?
Message-ID: <DUB128-W6810AD43780578EF2A48789CD50@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.5-rc3/arch/arm/mach-ux500/cpu-db8500.c:89]: (style) Statements following return, break, continue, goto or throw will never be executed.

Source code is

??? return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
???????????? readl((u32 *)uid+0),
???????????? readl((u32 *)uid+1), readl((u32 *)uid+2),
???????????? readl((u32 *)uid+3), readl((u32 *)uid+4));
??? iounmap(uid);
}

This looks like a cut-n-paste error to me. Suggest rework.

Regards

David Binderman

 		 	   		  
