From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 22 Sep 2009 11:15:28 -0500
Subject: Adjust cache settings of user pages?
Message-ID: <4AB8F820.4000103@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys:


I'm using get_user_pages() to let me "stream" data directly from a
hardware device to the user application that wants it.  (The device in
question is an SPI device, and I use the user pages as the receive buffer).

In the abstract, everything I have is working fine.  However, users are
wanting to read the data immediately as soon as they know that the data
is there.  What I'm finding is that even though I've sent them such
indication (via a blocking read()), the data in question might not have
actually gotten placed into the user buffer at that point--- probably
because the pages are still in the cache?  (The data does eventually
show up).

What the right API is (if there is one) to tell the kernel to turn off
caching for a user page--- or even if such a thing is possible.  Can
anyone offer any hints?


Thanks!


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
