From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 25 Jan 2013 09:10:10 +0200
Subject: [BUG] panda board locks up on boot
In-Reply-To: <1359082886.21576.199.camel@gandalf.local.home>
References: <1359082886.21576.199.camel@gandalf.local.home>
Message-ID: <51022FD2.8090101@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steven,

On 01/25/13 05:01, Steven Rostedt wrote:
> I've recently started testing my work on arm boards and have found that
> they both don't boot under the latest kernel anymore. I already posted
> about my snowball board, but my panda board also locks up.
> 
> I've bisected it down to this commit:
> 
> commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Fri Apr 13 12:27:37 2012 +0100
> 
>     mmc: omap_hsmmc: remove private DMA API implementation
>     
>     Remove the private DMA API implementation from omap_hsmmc, making it
>     use entirely the DMA engine API.
>     
>     Tested-by: Tony Lindgren <tony@atomide.com>
>     Tested-by: Venkatraman S <svenkatr@ti.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> 
> The commit before boots fine, when adding this commit, it locks up.
> 
> I reverted the commit (with tweaks) against 3.8-rc4 and was able to get
> my board booting again. Not sure what to do, but I wanted to let people
> know.

Care to post your kernel config file?


-- 
Regards,
Igor.
