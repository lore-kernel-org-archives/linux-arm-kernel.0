From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Apr 2011 15:50:47 +0300
Subject: [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries
	for some global variables
In-Reply-To: <1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110421125047.GD15060@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110420 07:12]:
> Many architecture specific versions of uncompress.h make use of global
> variables marked static.  In such case the GOT is bypassed and the
> code in head.S can't relocate them.
> 
> Instead of removing the static keyword from all those files and hope that
> it won't come back, let's simply
> define it out.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
> 
> This should fix remaining issues some people have with the DT append patch.

This fixes the issue where the beginning of the DT data got overwritten
by the uncompressed kernel:

Tested-by: Tony Lindgren <tony@atomide.com>
