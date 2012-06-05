From: joe@perches.com (Joe Perches)
Date: Tue, 05 Jun 2012 16:35:16 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <20120605162910.caccb0d4.akpm@linux-foundation.org>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
 <20120605162910.caccb0d4.akpm@linux-foundation.org>
Message-ID: <1338939316.11962.3.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-05 at 16:29 -0700, Andrew Morton wrote:
> What about writes starting with \001n?  AFACIT, that will be stripped
> away and the printk level will be altered.  This is new behavior.

Nope.

# echo "\001Hello Andrew" > /dev/kmsg
/dev/kmsg has
12,774,2462339252;\001Hello Andrew

12 is 8 + KERN_DEFAULT

# echo "<1>Hello Andrew" > /dev/kmsg
/dev/kmsg has:
9,775,2516023444;Hello Andrew
