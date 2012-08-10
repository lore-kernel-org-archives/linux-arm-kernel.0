From: mrosenberg@mozilla.com (Martin Rosenberg)
Date: Thu, 9 Aug 2012 22:52:29 -0700 (PDT)
Subject: Discontiguous memory and cacheflush
In-Reply-To: <447177957.1189939.1344577602635.JavaMail.root@mozilla.com>
Message-ID: <1613427331.1190769.1344577949008.JavaMail.root@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of days ago, I started a project to coalesce calls to cachefush in mozilla's JIT.  After working out most of the bugs that I could find, there were still some lingering failures, which I believe finally tracked down to do_cache_op, where it looks like only the first contiguous region of virtual memory is consulted.  I don't actually know about any of the functions that are being called, nor exactly what the datastructures represent, but if my understanding of the code is correct, then it is at odds with the documentation that is available (namely, man cacheflush(2)).  Is there something I've overlooked, any suggested workarounds?  Thanks --Marty
