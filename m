From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 20:39:41 +0100
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110923115721.GA7013@glandium.org>
References: <20110923115721.GA7013@glandium.org>
Message-ID: <20110923193941.GQ17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 01:57:21PM +0200, Mike Hommey wrote:
> We've been hitting random crashes at startup with Firefox on tegras
> (under Android), and narrowed it down to a I-cache/D-cache
> inconsistency. A reduced testcase of the issue looks like the following
> (compile as ARM, not Thumb):

If you write code at run time, you need to use the sys_cacheflush
API to ensure that it's properly synchronized with the I-cache.  It's
a well known issue, and it applies to any harvard cache structured
CPU which doesn't automatically ensure coherence (which essentially
means all ARMs.)
