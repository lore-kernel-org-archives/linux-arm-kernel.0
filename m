From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 21 Apr 2011 09:22:07 -0400 (EDT)
Subject: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
	end
In-Reply-To: <20110421104954.GH13688@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<20110420072156.GA28679@atomide.com>
	<alpine.LFD.2.00.1104200850030.24613@xanadu.home>
	<20110420165514.GE10402@atomide.com>
	<alpine.LFD.2.00.1104201318040.24613@xanadu.home>
	<20110421055945.GB13688@atomide.com>
	<20110421104954.GH13688@atomide.com>
Message-ID: <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Tony Lindgren wrote:

> Otherwise we end up overwriting ourselves. This fixes booting
> on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> (ARM: 6750/1: improvements to compressed/head.S).
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I don't understand why this is needed.  The copy loop is explicitly 
copying from the end going backward exactly to cope with this 
possibility.

Hmmm...


Nicolas
