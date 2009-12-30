From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 13:55:06 +0200
Subject: [patch-v2.6.34 8/9] arm: omap: musb: do not pass clock name to
	driver
In-Reply-To: <4B3B3818.5030804@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	<1262127567-15202-9-git-send-email-felipe.balbi@nokia.com>
	<4B3B3818.5030804@ru.mvista.com>
Message-ID: <1262174106.28789.180.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2009-12-30 at 14:23 +0300, Sergei Shtylyov wrote:
>    It's not so actually. This depends on the matching mechanism 
> established within clkdev: by device, by name, or by both. Not all 
> implementations will match by device, e.g. DA8xx/OMAP-L1x will match by 
> clock name.

then it has to be fixed. The name shouldn't matter. This was a big
discussion when Russell came up with the clkdev stuff and I remember
clearly that clock names shouldn't be passed down to drivers because
they don't matter.

-- 
balbi
