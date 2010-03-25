From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 12:06:12 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <4BAB4DE8.1030707@mvista.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
Message-ID: <20100325120612.GB6590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 05:20:00PM +0530, Philby John wrote:
> This was tested throughly but not for alignment and to verify the fix is  
> easy. All you need to do is revert the commit and then type reboot at  
> the command prompt. On reboot you will get "aaci-pl041 fpga:04: ac97  
> read back fail" failures, rendering audio non-functional on an ARM1176.

Given the analysis, I can not believe your statement.

> The right fix would be to use writew() instead of writel()

No, you're writing to reserved bits in the interrupt enable register
for a channel we don't use.  There's no way that this is correct, or
even a valid fix.
