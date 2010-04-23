From: rmk@ftp.linux.org.uk (Russell King)
Date: Fri, 23 Apr 2010 15:40:58 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
Message-ID: <20100423144058.GA11637@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Above change is necessary but what an alternative approach is for this. 
> There are many use case where ioremap* is needed.

This is a very difficult issue to answer; the only way we can safely
remap RAM with different attributes is if we disable the existing
mappings - but since we create those with 1MB sections, that's far
from easy to achieve.

I think a viable safe solution is to set aside some RAM at boot (which
the kernel doesn't manage at all) and then use ioremap on that; that
approach will still work with this patch in place.

Note that I've applied this patch to my devel tree, which has been
pushed out; please note that I'm making use of others 'net connections
to do this.
