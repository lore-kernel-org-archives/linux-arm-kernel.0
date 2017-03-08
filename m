From: bishah@cisco.com (Bijal Shah (bishah))
Date: Wed, 8 Mar 2017 11:44:12 +0000
Subject: L2 cache management question
Message-ID: <bdcc07da22ae43589768d6d4aebbf788@XCH-RTP-013.cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I hope this is this the right mailer for this question.

I've been looking into an issue on an ARM platform which seems to revolve around the way the L2 cache is managed by the kernel.

Looking at l2x0_cache.c file in the arch/arm/mm directory, I see a common pattern for an address range flush where if the address range is larger than the cache size, a flush_all is called almost without question. Is there any specific reason for this? Asking for the project I'm working on, as the address ranges may contain very few if any dirty lines, and a flush_all is expensive and locks out other CPUs while it is going on.

Regards,
Beej

Twenty years from now you will be more disappointed by the things that you didn't do than by the ones you did, so throw off the bowlines, sail away from the safe harbour, catch the trade winds in your sails, explore. Dream. Discover.
 - - Mark Twain - -
