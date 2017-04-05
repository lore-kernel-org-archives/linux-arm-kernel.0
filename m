From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Apr 2017 16:28:24 +0200
Subject: [PATCH 1/1] ARM: dts: armada-xp-linksys-mamba: use wan instead
 of internet for DSA port
In-Reply-To: <20170405052847.326-1-ralph.sennhauser@gmail.com>
References: <20170405052847.326-1-ralph.sennhauser@gmail.com>
Message-ID: <20170405142824.GB13449@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 07:28:46AM +0200, Ralph Sennhauser wrote:
> The LEDs for the "wan" port are already labeled "mamba:amber:wan" resp.
> "mamba:white:wan". So besides being an outlier with regard to the rest
> of the product line (see table below) changing the label fixes an
> internal inconsistency as well.
> 
> This will be visible in user space. Given commit cb4f71c42988 ("ARM:
> dts: armada-38x: change order of ethernet DT nodes on Armada 38x") it's
> expected to happen anyway. Commit 499400c9ac20 ("ARM: dts:
> armada-xp-linksys-mamba: Utilize new DSA binding") switches to the new
> bindings, use this opportunity to do it now rather than later.
> 
> |-----------------------------------------------------------------|
> | Labels used for the case and those used for the DSA ports       |
> |-----------------------------------------------------------------|
> | case labels	| armada-385-linksys-*	| armada-xp-linksys-mamba |
> |---------------|-----------------------|-------------------------|
> | internet	| wan			| internet		  |
> | 1		| lan1			| lan1			  |
> | 2		| lan2			| lan2			  |
> | 3		| lan3			| lan3			  |
> | 4		| lan4			| lan4			  |
> |-----------------------------------------------------------------|

Hi Ralph

I always encourage people to use the case labels as interface names.
So if i was going to make a change, it would be wan->internet for the 
armada-385-linksys-*.

> I underestimated the urge of people to make all the same before. While I do not
> particularly like this sort of change I see it coming anyway. So this patch is
> meant to make it a deliberate decision so it no longer is an item lurking in
> the shadows. Whether this patch gets taken or rejected my goal is reached.

I would say, this is now too late. Changing an interface name will
break configuration scripts. We are stuck with it.

      Andrew
