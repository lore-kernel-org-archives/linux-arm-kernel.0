From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 09:55:30 +0000
Subject: [PATCH v3 0/6] ARM: EXYNOS: Add secure firmware support
In-Reply-To: <006501cdc0a8$d880c990$89825cb0$%kim@samsung.com>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <006501cdc0a8$d880c990$89825cb0$%kim@samsung.com>
Message-ID: <20121112095530.GF28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 04:39:28PM +0900, Kukjin Kim wrote:
> (+ Russell King)

I think there's still an amount of work to do here; it's not a generic
interface at the moment because it makes some assumptions about how
things are done (eg, it assumes that there _will_ be a CPU boot register;
that is not always true.

Moreover, the 'cpu' arguments given seem to be uncertain whether they're
logical CPU numbers or physical CPU numbers.

Lastly, where is this interface actually documented?  It's just a bunch
of code _without_ _any_ documentation.  That means people will interpret
it differently, and it'll get used differently from platform to platform.

Let's have some documentation on this.
