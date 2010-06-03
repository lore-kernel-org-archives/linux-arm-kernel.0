From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 04 Jun 2010 09:04:57 +1200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100603192459.GA9169@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
Message-ID: <4C0818F9.9070008@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> The subject says everything you need to know.  Randy provided this
> link earlier:
> 
>   http://lkml.org/lkml/2010/6/2/472
> 
> Linus doesn't appear to be listening to reason, so I see now this as
> a fait accompli.  It'll apparantly happen at the next merge window.
> 
> So, don't send anything which contains a defconfig file or updates to
> it.  It's pointless.

Is it worth being a bit proactive and getting rid of some of them in
advance? Things like spear3[012]0_defconfig are basically identically
except for the board type. Combining all three of those would remove
1500 lines of code.

Basically reduce down to one or two defconfigs for each mach directory
which include as many boards and drivers as possible. People wanting
more tailored configs can do that in their own trees.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
