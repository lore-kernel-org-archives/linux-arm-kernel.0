From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 04 Aug 2010 04:02:17 -0000
Subject: memblock_is_region_reserved() issue
In-Reply-To: <1280885890.1902.134.camel@pasglop>
References: <1280882307.1902.124.camel@pasglop>
	<1280885890.1902.134.camel@pasglop>
Message-ID: <1280894327.1902.138.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks !

You seem to use memblock_is_region_reserved() in a few places in the new
code assuming (as I would) that it returns a boolean (0 reserved, !0 not
reserved).

However, the implementation looks totally wrong. I was wondering if you
had noticed :-)

I'm about to send a fix, but wanted to make sure you guys were ok with
it.

Cheers,
Ben.
