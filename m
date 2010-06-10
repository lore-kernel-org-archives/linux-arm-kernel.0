From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Thu, 10 Jun 2010 17:14:02 +0300
Subject: [PATCH 0/3] ARM: unwind extension
In-Reply-To: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <20100610141402.GY17639@pcarmody-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/10 14:17 +0200, Carmody Phil.2 (EXT-Ixonos/Helsinki) wrote:
> 
> The first two patches are simply preparation for the third, making it
> effectively trivial, even though it's the only one with a concrete 
> change in behaviour.
> 
> The origins of this patchset are the discovery that unwind and kmemleak
> don't always cooperate well with each other - any allocation within 
> an exit or devexit function causes kmemleak to look up symbols that 
> aren't in any unwind table. This of course means that all WARN_ONs and
> BUGs will suffer the same fate.
> 
> It could certainly be said that with a typical system the linked list
> has grown too large to be practical as a container, and some improvements
> could be made in that direction in the future.

Catalin, 

Have you had a chance to look at these yet? The linked-list efficiency
issue I mention in the final paragraph above is a no-brainer; I have a 
1-line tweak that improves the real-world efficiency so much that on 
average there are only 2 linked list operations rather than (on a 50+
module system) 70. However, that patch is orthogonal to the above set, 
so I'll not mix the two.

Phil
