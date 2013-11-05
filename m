From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Nov 2013 15:20:42 +0000
Subject: [PATCH 0/3] follow up fixes for V7 big endian changes
In-Reply-To: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131105152042.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 06:16:02PM -0800, Victor Kamensky wrote:
> 3) ARM: fix mov to mvn conversion in case of 64 bit phys_addr_t and BE
> Conflict resolution between [5] and [6] was not entirely correct for 
> the case when 'mov' instruction has to be converted into 'mvn'
> instruction.

This is a good reason why rushing stuff along when there's two people
working in the same area is bad news.  The person who gets to do the
conflict resolution doesn't always know what the correct solution is,
so many of them are pure guesses, and many of them won't be adequately
tested.

Quite honestly, I would have preferred *not* to have pulled Ben's BE
changes along with Santosh's other changes, and have Ben rebase for
the _following_ merge window to prevent exactly this kind of mess.

The BE stuff has been one problem after another...
