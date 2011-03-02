From: ccross@google.com (Colin Cross)
Date: Tue, 1 Mar 2011 17:25:34 -0800
Subject: Store buffer and l2x0_cache_sync
Message-ID: <AANLkTi=CzrVuqA0V-_kRnLWOHVw7aOzDpuJfvSD9Vdhx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2x0_cache_sync on a PL310 has no wait after the writel_relaxed to the
L2X0_CACHE_SYNC register, because PL310 cache operations are atomic.
Doesn't the cpu store buffer still need to be flushed after the
register write, either with a dsb or a dummy read?
