From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 19:20:20 +0100
Subject: [PATCH 3/4] ARM: fix NOMMU __arm_ioremap prototype
In-Reply-To: <1367515404-512212-4-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
 <1367515404-512212-4-git-send-email-arnd@arndb.de>
Message-ID: <20130502182020.GC14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 07:23:23PM +0200, Arnd Bergmann wrote:
> The declaration of __arm_ioremap has changed to take a phys_addr_t
> as the first argument, while the definition for nommu has not
> changed. This adds the obvious change.

I've now dropped the offending patch from Laura which created this problem
(and from what it looks like other problems elsewhere).

It would be much better to have one patch which addresses this properly
rather than one patch causing a problem and then lots of smaller patches
fixing the problems caused by the first patch.
